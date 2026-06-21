DEALLOCATE ALL;

-- Todas as regras legislativas que se aplicam a um certo município.
--
-- Argumentos:
--  - Nome do município
--  - Sigla da UF
PREPARE reg_leg_mun(TEXT, CHAR(2)) AS
    WITH cod(mun, uf) AS (
        SELECT cod_ibge, substring(cod_ibge, 1, 2) FROM org_adm_mun WHERE nome_mun = $1 AND sigla_uf = $2
    )
    SELECT * FROM reg_leg, cod WHERE ent = cod.uf OR ent = cod.mun; 

-- Todas as filiais que não receberam nenhuma multa em um intervalo
-- de datas passadas por parâmetro   
--
-- Argumentos:
--  - Intervalo de data, na qual queira saber quais filiais não receberam multa
--
-- Assumindo:
--  - Foi adotado que a Instituição de pesquisa começa a analisar determinada
--    filial, após um mês da data de pedido
-- 
--  - Foi adotado que a Instituição de pesquisa demora entorno de 1 mês para
--    terminar sua análise de determinada filial
--
--  - Foi adotado que qualquer relatório que tiver um valor de multa, em
--    que o periodo da analise conter sobreposição com o periodo passado por 
--    parâmetro, é considerado uma tupla falsa para a query

PREPARE filial_sem_multa_p(DATERANGE) AS
    SELECT cnpj_raiz, cnpj_ordem FROM filial
        EXCEPT 
        SELECT 
            f.cnpj_raiz, 
            f.cnpj_ordem
        FROM filial AS f
            JOIN relatorio AS r 
            ON f.cnpj_raiz = r.cnpj_filial_raiz 
            AND f.cnpj_ordem = r.cnpj_filial_ordem
        WHERE
            $1 && DATERANGE(
                date_trunc('month', r.dt_pedido + INTERVAL '1 month')::DATE,
                date_trunc('month', r.dt_pedido + INTERVAL '2 months')::DATE
            )
            AND r.multa_aplic > 0;

-- Todas as filiais que contribuíram mais do que R$X em ações de compensação,
-- nos últimos K meses, sendo pelo menos Y% de suas contribuições em uma area Z.
-- O resultado deve ser ordenado, em ordem decrescente, pela porcentagem.
--
-- Argumentos:
--  - valor mínimo contribuído pela filial (X)
--  - quantidade de meses a serem analisados (K)
--  - porcentagem de contribuições que devem pertencer a uma determina área, de 0 a 100 (Y)
--  - área (Z IN ('transporte', 'energia', 'reciclagem'))
PREPARE filial_contrib_min_prop(DECIMAL, INT, DECIMAL, TEXT) AS
    WITH
        contrib_filial(cnpj_raiz, cnpj_ordem, transp, energ, recic) AS (
            SELECT
                    v.cnpj_filial_raiz,
                    v.cnpj_filial_ordem,
                    SUM(c.valor * a.p_co2_transp / 100),
                    SUM(c.valor * a.p_co2_energ / 100),
                    SUM(c.valor * a.p_co2_recic / 100)
                FROM vinc_contrib_co2 AS v
                    JOIN acao_co2 AS a on (v.cnpj_organiz_socioamb, v.dt_inicio_acao_co2, v.nome_acao_co2) = (a.cnpj, a.dt_inicio, a.nome)
                    JOIN contrib_co2 AS c on c.id_contrib = v.id
                WHERE
                    DATERANGE(
                        date_trunc('month', current_date - make_interval(months => $2))::DATE,
                        current_date
                    ) @> c.dt
               GROUP BY v.cnpj_filial_raiz, v.cnpj_filial_ordem
        ),
        contrib_filial_p(cnpj_raiz, cnpj_ordem, p) AS (
            SELECT
                    cnpj_raiz,
                    cnpj_ordem,
                    (
                        CASE
                            WHEN $4 = 'transporte' THEN 100 * transp / (transp + energ + recic)
                            WHEN $4 = 'energia' THEN 100 * energ / (transp + energ + recic)
                            WHEN $4 = 'reciclagem' THEN 100 * recic / (transp + energ + recic)
                        END
                    )
                FROM contrib_filial
        )
    SELECT u.cnpj_raiz, u.cnpj_ordem, transp + energ + recic AS total, transp, energ, recic, p
        FROM contrib_filial AS u
            JOIN contrib_filial_p AS v ON (u.cnpj_raiz, u.cnpj_ordem) = (v.cnpj_raiz, v.cnpj_ordem)
        WHERE transp + energ + recic >= $1 AND v.p >= $3
        ORDER BY v.p DESC;

-- Todas as filiais cujas emissões em um intervalo de data (DATERANGE) for oriundas 
-- majoritariamente (>=50%) de um único tipo de produto ou serviço.
--
-- Argumentos:
--  - Intervalo de data (DATERANGE)
PREPARE filiais_emissao_major(DATERANGE) AS
    WITH 
        emissao_grupo_produto(cnpj_filial_raiz, cnpj_filial_ordem, emissao_p, produto) AS (
            SELECT 
                r.cnpj_filial_raiz,
                r.cnpj_filial_ordem,
                sum(p.tco2_p_un * p.qtde) as emissao_p,
                p.ncm
            FROM relatorio AS r 
                JOIN relatorio_prod AS p ON r.id = p.id_relatorio
            WHERE $1 @> r.dt_pedido
            GROUP BY
                r.cnpj_filial_raiz,
                r.cnpj_filial_ordem,
                p.ncm
            ),
        emissao_produto(cnpj_filial_raiz, cnpj_filial_ordem, emissao_total_p, maior_emissao_p) AS (
            SELECT
                p.cnpj_filial_raiz, 
                p.cnpj_filial_ordem, 
                COALESCE(SUM(p.emissao_p), 0) emissao_total_p, 
                COALESCE(MAX(p.emissao_p), 0) maior_emissao_p
            FROM emissao_grupo_produto AS p
            GROUP BY
                p.cnpj_filial_raiz,
                p.cnpj_filial_ordem

            ),
        emissao_grupo_servico(cnpj_filial_raiz, cnpj_filial_ordem, emissao_s, servico) AS (
            SELECT 
                r.cnpj_filial_raiz,
                r.cnpj_filial_ordem,
                sum(s.tco2) as emissao_s, 
                s.nbs
            FROM relatorio AS r 
                JOIN relatorio_serv AS s ON r.id = s.id_relatorio
            WHERE $1 @> r.dt_pedido
            GROUP BY
                r.cnpj_filial_raiz,
                r.cnpj_filial_ordem,
                s.nbs
            ),
        emissao_servico(cnpj_filial_raiz, cnpj_filial_ordem, emissao_total_s, maior_emissao_s) AS (
            SELECT
                s.cnpj_filial_raiz, 
                s.cnpj_filial_ordem, 
                COALESCE(SUM(s.emissao_s), 0) emissao_total_s, 
                COALESCE(MAX(s.emissao_s), 0) maior_emissao_s
            FROM emissao_grupo_servico AS s
            GROUP BY
                s.cnpj_filial_raiz,
                s.cnpj_filial_ordem
        )
    SELECT 
        COALESCE(p.cnpj_filial_raiz, s.cnpj_filial_raiz), 
        COALESCE(p.cnpj_filial_ordem, s.cnpj_filial_ordem) 
    FROM emissao_produto AS p
        FULL OUTER JOIN emissao_servico AS s 
        ON (p.cnpj_filial_raiz, p.cnpj_filial_ordem) = (s.cnpj_filial_raiz, s.cnpj_filial_ordem)
    WHERE (s.maior_emissao_s/NULLIF((s.emissao_total_s + p.emissao_total_p),0) >= 0.5) 
        OR (p.maior_emissao_p/NULLIF((s.emissao_total_s + p.emissao_total_p),0) >= 0.5);

-- Todas as regras legislativas de incentivo fiscal cujas metas não foram atingidas por nenhuma filial nos últimos X meses
--
-- Argumento:
--  - tempo, em meses, a ser analisado 
PREPARE regra_if_nao_atingida(DATARANGE)
    SELECT
        -- Nome do ent
        rl.tipo, rl.ano, rl.nro, rl.dt_vigencia
    FROM reg_leg AS rl
        -- Chegar nas empresas que se envolveram os os produtos/serviços que tal lei cobre
        LEFT OUTER JOIN relatorio_prod AS rp
            ON rl.prod = rp.ncm AND rl.meta_if IS NOT NULL -- Isso que define um if (Ta aqui para otimizar)    
        LEFT OUTER JOIN relatorio_serv AS rs
            ON rl.serv = rs.nbs
        JOIN relatorio AS r
            ON r.id = rp.id_relatorio OR r.id = rs.id_relatorio
        JOIN filial AS f
            ON (r.cnpj_filial_raiz = f.cnpj_raiz
            AND r.cnpj_filial_ordem = f.cnpj_ordem)
        -- Precisa para determinar se a empresa que teve tal produto/serviço avaliado está no lugar onde a lei vale
        JOIN org_adm_mun AS mun
            ON f.mun_cod = mun.cod_ibge
        JOIN uf AS uf
            ON mun.sigla_uf = uf.sigla
    WHERE 
        (mun.cod_ibge = rl.ent OR uf.cod_ibge = rl.ent)
        AND $1 @> r.data_pub

        AND (
                (
                    rl.prod IS NOT NULL
                    AND rl.prod = rp.ncm
                    AND rp.tco2_p_un * rp.qtde <= rl.meta_if
                )

                OR

                (
                    rl.serv IS NOT NULL
                    AND rl.serv = rs.nbs
                    AND rs.tco2 <= rl.meta_if
                )
            )


-- Para todas as Instituições Cientificas do município X, listar a média do histórico de CO2
-- de cada empresa avaliadas por suas equipes, ordenadas pela média do histórico.
--
-- Argumento:
--  - nome do município 
PREPARE co2_por_inst_cient_em_municipio(TEXT) AS
    SELECT 
        h.cnpj_raiz AS Empresa, 
        avg(h.emissao_tot - h.compens_tot) AS Media
    FROM hist_co2 h
    WHERE EXISTS (
        SELECT 1
        FROM inst_cient AS ic 
            JOIN relatorio AS r 
            ON ic.cnpj = r.cnpj_inst_cient
            JOIN org_adm_mun AS mun 
            ON ic.mun_cod = mun.cod_ibge
        WHERE 
            mun.nome_mun = $1 
            AND h.cnpj_raiz = r.cnpj_filial_raiz
    )
    GROUP BY h.cnpj_raiz
    ORDER BY Media;
