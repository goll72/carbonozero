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
--  - Intervalo de data, na qual queira saber quais filiais levaram multa
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

-- Todas as filiais que contribuíram mais do que $"R$X"$ em ações de compensação,
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
                        (current_date - make_interval(months => $2))::DATE,
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

-- Todas as filiais cujas emissões nos últimos X meses foram oriundas majoritariamente de um único tipo de produto ou serviço.
-- PREPARE filiais_emissao_concentrada_k(DECIMAL, INT)

-- Todas as regras legislativas de incentivo fiscal cujas metas não foram atingidas por nenhuma filial nos últimos X meses

-- Para todas as Instituições Cientificas do município X, listar a média do histórico de CO2 de cada empresa avaliadas por suas equipes, ordenadas pela média do histórico.
