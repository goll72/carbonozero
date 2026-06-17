CREATE TYPE ENT_FED_TIPO AS ENUM ('mun', 'uf');

CREATE TABLE ent_fed (
    cod_ibge CHAR(7) PRIMARY KEY,
    tipo ENT_FED_TIPO
);

CREATE TABLE uf (
    sigla CHAR(2) PRIMARY KEY,
    cod_ibge CHAR(7) NOT NULL UNIQUE REFERENCES ent_fed(cod_ibge)
);

CREATE TABLE org_adm_mun (
    cod_ibge CHAR(7) PRIMARY KEY REFERENCES ent_fed(cod_ibge),
    cnpj CHAR(14) NOT NULL UNIQUE,
    raz_soc VARCHAR(255),
    end_rua VARCHAR(127),
    end_nro INT,
    end_cep CHAR(9),
    nome_mun VARCHAR(127) NOT NULL,
    sigla_uf CHAR(2) REFERENCES uf(sigla)
);

CREATE TABLE empresa (
    cnpj_raiz CHAR(8) PRIMARY KEY,
    cnae CHAR(9),
    dt_fund DATE NOT NULL,
    raz_soc VARCHAR(255),
    nat_jur CHAR(5) NOT NULL,
    dt_adesao DATE NOT NULL
);

CREATE TABLE filial (
    cnpj_raiz CHAR(8) REFERENCES empresa(cnpj_raiz),
    cnpj_ordem CHAR(6),
    qtde_func INT,
    end_rua VARCHAR(127),
    end_nro INT,
    end_cep CHAR(9),
    mun_cod CHAR(7) NOT NULL REFERENCES org_adm_mun(cod_ibge),

    PRIMARY KEY (cnpj_raiz, cnpj_ordem)
);

CREATE TABLE organiz_socioamb (
    cnpj CHAR(14) PRIMARY KEY,
    nome VARCHAR(255),
    end_rua VARCHAR(127),
    end_nro INT,
    end_cep CHAR(9),
    mun_cod CHAR(7) REFERENCES org_adm_mun(cod_ibge)
);

CREATE TABLE acao_co2 (
    cnpj CHAR(14),
    dt_inicio DATE,
    nome VARCHAR(255),
    valor_p DECIMAL,
    valor_lim DECIMAL,
    p_co2_transp INT,
    p_custo_transp INT,
    p_co2_energ INT,
    p_custo_energ INT,
    p_co2_recic INT,
    p_custo_recic INT,

    PRIMARY KEY (cnpj, dt_inicio, nome),
    FOREIGN KEY (cnpj) REFERENCES organiz_socioamb(cnpj)
);

CREATE TABLE vinc_contrib_co2 (
    id SERIAL PRIMARY KEY,
    cnpj_filial_raiz CHAR(8) NOT NULL,
    cnpj_filial_ordem CHAR(4) NOT NULL,
    cnpj_organiz_socioamb CHAR(14) NOT NULL,
    dt_inicio_acao_co2 DATE NOT NULL,
    nome_acao_co2 VARCHAR(255) NOT NULL,

    UNIQUE (
        cnpj_filial_raiz,
        cnpj_filial_ordem,
        cnpj_organiz_socioamb,
        dt_inicio_acao_co2,
        nome_acao_co2
    ),

    FOREIGN KEY (cnpj_filial_raiz, cnpj_filial_ordem) REFERENCES filial(cnpj_raiz, cnpj_ordem),
    FOREIGN KEY (cnpj_organiz_socioamb, dt_inicio_acao_co2, nome_acao_co2) REFERENCES acao_co2(cnpj, dt_inicio, nome)
);

CREATE TABLE contrib_co2 (
    id_contrib SERIAL REFERENCES vinc_contrib_co2(id),
    dt DATE,
    valor DECIMAL,

    PRIMARY KEY (id_contrib, dt)
);

CREATE TABLE hist_co2 (
    cnpj_raiz CHAR(8),
    cnpj_ordem CHAR(6),
    ano INT,
    mes INT,

    emissao_tot DECIMAL,
    compens_tot DECIMAL,

    PRIMARY KEY (cnpj_raiz, cnpj_ordem, ano, mes),
    FOREIGN KEY (cnpj_raiz, cnpj_ordem) REFERENCES filial(cnpj_raiz, cnpj_ordem)
);

CREATE TABLE serv_nbs (
    nbs INT PRIMARY KEY,
    nome VARCHAR(255)
);

CREATE TABLE prod_ncm (
    ncm INT PRIMARY KEY,
    nome VARCHAR(255)
);

CREATE TYPE REG_LEG_TIPO AS ENUM ('if', 'multa');

CREATE TABLE reg_leg (
    ent CHAR(7) REFERENCES org_adm_mun(cod_ibge),
    tipo REG_LEG_TIPO,
    nro INT,
    ano INT,

    dt_vigencia DATE NOT NULL,
    dt_revogacao DATE,

    serv INT REFERENCES serv_nbs(nbs),
    prod INT REFERENCES prod_ncm(ncm),

    lim_multa DECIMAL,
    base_calc_multa DECIMAL,

    meta_if DECIMAL,
    aliq_if DECIMAL,

    PRIMARY KEY (ent, tipo, nro, ano)
);

CREATE TABLE inst_cient (
    cnpj CHAR(14) PRIMARY KEY,
    nome VARCHAR(255),
    end_rua VARCHAR(127),
    end_nro INT,
    end_cep CHAR(9),
    mun_cod CHAR(7) REFERENCES org_adm_mun(cod_ibge)
);

CREATE TABLE equipe_inst_cient (
    cnpj_inst_cient CHAR(14),
    nome VARCHAR(255),
    
    PRIMARY KEY (cnpj_inst_cient, nome)
);

CREATE TABLE equipe_inst_cient_membro (
    cnpj_inst_cient CHAR(14),
    nome_equipe VARCHAR(255),
    nome_membro VARCHAR(255) NOT NULL,

    PRIMARY KEY (cnpj_inst_cient, nome_equipe)
);

CREATE TABLE relatorio (
    id SERIAL PRIMARY KEY,
    dt_pedido DATE NOT NULL,
    dt_pub DATE,
    
    cnpj_filial_raiz CHAR(8) NOT NULL,
    cnpj_filial_ordem CHAR(6) NOT NULL,
    
    cnpj_inst_cient CHAR(14) NOT NULL,
    nome_equipe VARCHAR(63) NOT NULL,
    
    mun_cod CHAR(7) REFERENCES org_adm_mun(cod_ibge),
    
    aliq_if DECIMAL,
    multa_aplic DECIMAL,

    UNIQUE (dt_pedido, cnpj_filial_raiz, cnpj_filial_ordem, cnpj_inst_cient, nome_equipe),
    FOREIGN KEY (cnpj_filial_raiz, cnpj_filial_ordem) REFERENCES filial(cnpj_raiz, cnpj_ordem),
    FOREIGN KEY (cnpj_inst_cient, nome_equipe) REFERENCES equipe_inst_cient(cnpj_inst_cient, nome)
);

CREATE TABLE relatorio_prod (
    id_relatorio SERIAL REFERENCES relatorio(id),
    ncm INT REFERENCES prod_ncm(ncm),
    tco2_p_un DECIMAL,

    PRIMARY KEY (id_relatorio, ncm)
);

CREATE TABLE relatorio_serv (
    id_relatorio SERIAL REFERENCES relatorio(id),
    nbs INT REFERENCES serv_nbs(nbs),
    ocorrencia TIMESTAMPTZ,
    tco2 DECIMAL,

    PRIMARY KEY (id_relatorio, nbs, ocorrencia)
);
