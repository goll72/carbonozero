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

-- Todas as filiais que contribuíram mais do que $"R$X"$ em ações de compensação, nos últimos K meses, sendo pelo menos Y% de suas contribuições em uma area Z

-- Todas as filiais cujas emissões nos últimos X meses foram oriundas majoritariamente de um único tipo de produto ou serviço.
-- PREPARE filiais_emissao_concentrada_k(DECIMAL, INT)

-- Todas as regras legislativas de incentivo fiscal cujas metas não foram atingidas por nenhuma filial nos últimos X meses

-- Para todas as Instituições Cientificas do município X, listar a média do histórico de CO2 de cada empresa avaliadas por suas equipes, ordenadas pela média do histórico.
