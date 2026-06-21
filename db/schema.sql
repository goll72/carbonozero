CREATE DOMAIN CNPJ_TIPO AS CHAR(18)
CHECK (
    value ~ '^[0-9A-Z]{2}\.[0-9A-Z]{3}\.[0-9A-Z]{3}/[0-9A-Z]{4}-[0-9]{2}$'
);

CREATE DOMAIN CNPJ_RAIZ_TIPO AS CHAR(10)
CHECK (
    value ~ '^[0-9A-Z]{2}\.[0-9A-Z]{3}\.[0-9A-Z]{3}$'
);

CREATE DOMAIN CNPJ_ORDEM_TIPO AS CHAR(7)
CHECK (
    value ~ '^[0-9A-Z]{4}-[0-9]{2}$'
);

CREATE DOMAIN CEP_TIPO AS CHAR(9)
CHECK (value ~ '^[0-9]{5}-[0-9]{3}$');

CREATE TYPE ENT_FED_TIPO AS ENUM ('mun', 'uf');

CREATE TABLE ent_fed (
    cod_ibge CHAR(7),
    tipo ENT_FED_TIPO,

    CONSTRAINT enf_fed_pk
        PRIMARY KEY (cod_ibge)
);

CREATE TABLE uf (
    sigla CHAR(2),
    cod_ibge CHAR(7) NOT NULL,
    
    CONSTRAINT uf_pk
        PRIMARY KEY(sigla),
    CONSTRAINT uf_sk
        UNIQUE (cod_ibge),
    CONSTRAINT uf_ck
        CHECK (sigla ~ '^[A-Z]{2}$'),
    CONSTRAINT uf_fk 
        FOREIGN KEY (cod_ibge) REFERENCES ent_fed(cod_ibge) 
        ON DELETE RESTRICT
        ON UPDATE CASCADE
        DEFERRABLE
);

CREATE TABLE org_adm_mun (
    cod_ibge CHAR(7),
    cnpj CNPJ_TIPO NOT NULL,
    raz_soc TEXT,
    end_rua TEXT,
    end_nro INT,
    end_cep CEP_TIPO,
    nome_mun TEXT NOT NULL,
    sigla_uf CHAR(2),

    CONSTRAINT org_adm_mun_pk
        PRIMARY KEY (cod_ibge),
    CONSTRAINT org_adm_mun_sk
        UNIQUE (cnpj),
    CONSTRAINT org_adm_mun_fk_cod
        FOREIGN KEY (cod_ibge) REFERENCES ent_fed(cod_ibge) 
        ON DELETE RESTRICT
        ON UPDATE CASCADE
        DEFERRABLE,
    CONSTRAINT org_adm_mun_fk_uf
        FOREIGN KEY (sigla_uf) REFERENCES uf(sigla)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
);

CREATE TABLE empresa (
    cnpj_raiz CHAR(10),
    cnae CHAR(9),
    dt_fund DATE NOT NULL,
    raz_soc TEXT,
    nat_jur CHAR(5) NOT NULL,
    dt_adesao DATE NOT NULL,

    CONSTRAINT empresa_pk
        PRIMARY KEY (cnpj_raiz)
);

CREATE TABLE filial (
    cnpj_raiz CNPJ_RAIZ_TIPO,
    cnpj_ordem CNPJ_ORDEM_TIPO,
    qtde_func INT,
    end_rua TEXT,
    end_nro INT,
    end_cep CEP_TIPO,
    mun_cod CHAR(7) NOT NULL,

    CONSTRAINT filial_pk
        PRIMARY KEY (cnpj_raiz, cnpj_ordem),
    CONSTRAINT filial_fk_empresa
        FOREIGN KEY (cnpj_raiz) REFERENCES empresa(cnpj_raiz)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT filial_fk_mun 
        FOREIGN KEY (mun_cod) REFERENCES org_adm_mun(cod_ibge)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE organiz_socioamb (
    cnpj CNPJ_TIPO,
    nome TEXT,
    end_rua TEXT,
    end_nro INT,
    end_cep CEP_TIPO,
    mun_cod CHAR(7),

    CONSTRAINT organiz_socioamb_pk
        PRIMARY KEY(cnpj),
    CONSTRAINT organiz_socioamb_fk
        FOREIGN KEY(mun_cod) REFERENCES org_adm_mun(cod_ibge)
        ON DELETE RESTRICT
        ON UPDATE CASCADE

);

CREATE TABLE acao_co2 (
    cnpj CNPJ_TIPO,
    dt_inicio DATE,
    nome TEXT,
    razao_comp_custo DECIMAL,
    valor_lim DECIMAL,
    p_co2_transp INT,
    p_custo_transp INT,
    p_co2_energ INT,
    p_custo_energ INT,
    p_co2_recic INT,
    p_custo_recic INT,

    CONSTRAINT acao_co2_pk
        PRIMARY KEY (cnpj, dt_inicio, nome),
    CONSTRAINT acao_co2_fk
        FOREIGN KEY (cnpj) REFERENCES organiz_socioamb(cnpj)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT acao_co2_p_co2_valida
        CHECK (COALESCE(p_co2_transp, p_co2_energ, p_co2_recic) IS NULL OR p_co2_transp + p_co2_energ + p_co2_recic = 100),

    CONSTRAINT acao_co2_p_custo_valida
        CHECK (COALESCE(p_custo_transp, p_custo_energ, p_custo_recic) IS NULL OR p_custo_transp + p_custo_energ + p_custo_recic = 100)
);

-- MRel: Financia
CREATE TABLE vinc_contrib_co2 (
    id SERIAL,
    cnpj_filial_raiz CNPJ_RAIZ_TIPO NOT NULL,
    cnpj_filial_ordem CNPJ_ORDEM_TIPO NOT NULL,
    cnpj_organiz_socioamb CNPJ_TIPO NOT NULL,
    dt_inicio_acao_co2 DATE NOT NULL,
    nome_acao_co2 TEXT NOT NULL,

    CONSTRAINT financia_pk
        PRIMARY KEY (id),
    CONSTRAINT financia_sk
        UNIQUE (
            cnpj_filial_raiz,
            cnpj_filial_ordem,
            cnpj_organiz_socioamb,
            dt_inicio_acao_co2,
            nome_acao_co2
        ),
    CONSTRAINT financia_fk_acao
        FOREIGN KEY (cnpj_organiz_socioamb, dt_inicio_acao_co2, nome_acao_co2) REFERENCES acao_co2(cnpj, dt_inicio, nome)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,
    CONSTRAINT finacia_fk_filial
        FOREIGN KEY (cnpj_filial_raiz, cnpj_filial_ordem) REFERENCES filial(cnpj_raiz, cnpj_ordem)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- Obs. devido à separação entre as tabelas conforme
-- projetado no modelo relacional, visando reduzir o
-- uso de espaço na base de dados, não será possível
-- verificar diretamente (com `CHECK`) se a data da
-- contribuição é válida, sendo necessário fazer a
-- verificação em triggers SQL ou na aplicação.
CREATE TABLE contrib_co2 (
    id_contrib SERIAL,
    dt DATE,
    valor DECIMAL NOT NULL,

    CONSTRAINT contrib_co2_pk
        PRIMARY KEY (id_contrib, dt),
    CONSTRAINT contrib_co2_fk
        FOREIGN KEY (id_contrib) REFERENCES vinc_contrib_co2(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE hist_co2 (
    cnpj_raiz CNPJ_RAIZ_TIPO,
    cnpj_ordem CNPJ_ORDEM_TIPO,
    ano INT,
    mes INT,

    emissao_tot DECIMAL NOT NULL,
    compens_tot DECIMAL NOT NULL,

    CONSTRAINT hist_co2_pk
        PRIMARY KEY (cnpj_raiz, cnpj_ordem, ano, mes),
    CONSTRAINT hist_co2_fk
        FOREIGN KEY (cnpj_raiz, cnpj_ordem) REFERENCES filial(cnpj_raiz, cnpj_ordem)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE serv_nbs (
    nbs CHAR(12),
    nome TEXT,

    CONSTRAINT serv_nbs_pk
        PRIMARY KEY(nbs)
);

CREATE TABLE prod_ncm (
    ncm CHAR(10),
    nome TEXT,

    CONSTRAINT prod_ncm_pk
        PRIMARY KEY(ncm)
);

CREATE TYPE REG_LEG_TIPO AS ENUM ('if', 'multa');

CREATE TABLE reg_leg (
    ent CHAR(7),
    tipo REG_LEG_TIPO,
    nro INT,
    ano INT,

    dt_vigencia DATE NOT NULL,
    dt_revogacao DATE,

    serv CHAR(12),
    prod CHAR(10),

    lim_multa DECIMAL,
    base_calc_multa DECIMAL,

    meta_if DECIMAL,
    aliq_if DECIMAL,

    CONSTRAINT reg_leg_pk
        PRIMARY KEY (ent, tipo, nro, ano),
    CONSTRAINT reg_leg_fk_ent
        FOREIGN KEY (ent) REFERENCES ent_fed(cod_ibge)
        ON DELETE RESTRICT 
        ON UPDATE RESTRICT,
    CONSTRAINT reg_leg_fk_serv
        FOREIGN KEY (serv) REFERENCES serv_nbs(nbs)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT reg_leg_fk_prod
        FOREIGN KEY (prod) REFERENCES prod_ncm(ncm)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Visto que buscas por regras legislativas que estão em vigor em um determinado
-- período de tempo são recorrentes no sistema, criar um índice para a data de
-- vigência poderia trazer um aumento de desempenho considerável em uma base de
-- dados real (com um volume de dados maior).
CREATE INDEX IF NOT EXISTS reg_leg_ent_dt_vigencia_idx ON reg_leg(ent, dt_vigencia);

CREATE TABLE inst_cient (
    cnpj CNPJ_TIPO,
    nome TEXT NOT NULL,
    end_rua TEXT,
    end_nro INT,
    end_cep CEP_TIPO,
    mun_cod CHAR(7),

    CONSTRAINT inst_cient_pk
        PRIMARY KEY (cnpj),
    CONSTRAINT inst_cient_fk
        FOREIGN KEY (mun_cod) REFERENCES org_adm_mun(cod_ibge)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE equipe_inst_cient (
    cnpj_inst_cient CNPJ_TIPO,
    nome TEXT,
    
    CONSTRAINT equipe_inst_cient_pk 
        PRIMARY KEY (cnpj_inst_cient, nome),
    CONSTRAINT equipe_inst_cient_fk
        FOREIGN KEY (cnpj_inst_cient) REFERENCES inst_cient(cnpj)
        ON DELETE CASCADE
        ON UPDATE CASCADE        
);

CREATE TABLE equipe_inst_cient_membro (
    cnpj_inst_cient CNPJ_TIPO,
    nome_equipe TEXT,
    nome_membro TEXT,

    CONSTRAINT equipe_inst_cient_membro_pk
        PRIMARY KEY (cnpj_inst_cient, nome_equipe, nome_membro),
    CONSTRAINT equipe_inst_cient_membro_fk
        FOREIGN KEY (cnpj_inst_cient, nome_equipe) REFERENCES equipe_inst_cient(cnpj_inst_cient, nome)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE relatorio (
    id SERIAL,
    dt_pedido DATE NOT NULL,
    dt_pub DATE,
    
    cnpj_filial_raiz CNPJ_RAIZ_TIPO NOT NULL,
    cnpj_filial_ordem CNPJ_ORDEM_TIPO NOT NULL,
    
    cnpj_inst_cient CNPJ_TIPO NOT NULL,
    nome_equipe TEXT NOT NULL,
    
    mun_cod CHAR(7) REFERENCES org_adm_mun(cod_ibge),
    
    aliq_if DECIMAL,
    multa_aplic DECIMAL,

    CONSTRAINT relatorio_pk
        PRIMARY KEY(id),
    CONSTRAINT relatorio_sk
        UNIQUE (
            dt_pedido, 
            cnpj_filial_raiz, cnpj_filial_ordem, 
            cnpj_inst_cient, nome_equipe
        ),
    CONSTRAINT relatorio_fk_filial
        FOREIGN KEY (cnpj_filial_raiz, cnpj_filial_ordem) REFERENCES filial(cnpj_raiz, cnpj_ordem)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT relatorio_fk_inst_cient
        FOREIGN KEY (cnpj_inst_cient, nome_equipe) REFERENCES equipe_inst_cient(cnpj_inst_cient, nome)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE relatorio_prod (
    id_relatorio SERIAL,
    ncm CHAR(10),
    tco2_p_un DECIMAL NOT NULL,
    qtde DECIMAL NOT NULL,

    CONSTRAINT relatorio_prod_pk
        PRIMARY KEY (id_relatorio, ncm),
    CONSTRAINT relatorio_prod_fk_relatorio
        FOREIGN KEY (id_relatorio) REFERENCES relatorio(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT relatorio_prod_fk_prod
        FOREIGN KEY (ncm) REFERENCES prod_ncm(ncm)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE relatorio_serv (
    id_relatorio SERIAL,
    nbs CHAR(12),
    ocorrencia TIMESTAMPTZ,
    tco2 DECIMAL NOT NULL,

    CONSTRAINT relatorio_serv_pk
        PRIMARY KEY (id_relatorio, nbs, ocorrencia),
    CONSTRAINT relatorio_serv_fk_relatorio
        FOREIGN KEY (id_relatorio) REFERENCES relatorio(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT relatorio_serv_fk_serv
        FOREIGN KEY (nbs) REFERENCES serv_nbs(nbs)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

\i db/filters/reg_leg.sql;
\i db/filters/contrib_co2.sql;
