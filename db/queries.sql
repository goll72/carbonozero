-- N filiais com o menor histórico de emissão de carbono nos últimos K meses.

-- Todas as filiais que contribuíram mais do que R$ 500.000,00 em ações de compensação
-- nos últimos K meses, sendo pelo menos 30% de suas contribuições na área de energia.

-- Todas as filiais que não receberam nenhuma multa no último ano.

-- Todas as filiais que possuem dois ou menos relatórios sobre si gerados no último ano.

-- Todas as filiais que foram investigadas por três ou mais instituições científicas
-- diferentes nos últimos dois anos.

-- Todas as filiais com saldo de emissão positivo nos últimos Y anos, incluindo o valor total
-- investido em cada área das ações de compensação.

-- (complexa)
-- Todas as filiais cujas emissões nos últimos X meses foram oriundas
-- predominantemente (> 50%) de um único tipo de produto ou serviço.

-- Para todas as Instituições Cientificas do Rio de Janeiro, listar a média do histórico
-- de CO2 de cada empresa avaliadas por suas equipes, ordenadas pela média do histórico.

-- (útil)
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

-- (útil)
-- Todas as regras legislativas que se aplicam a uma determinada filial, em um determinado mês.

-- Todas as empresas que financiaram alguma ação de compensação de uma determinada
-- organização socioambiental, incluindo o valor total contribuído por cada empresa.

-- As top K filiais que mais investiram em ações de compensação, agrupadas por
-- área da ação.

-- Todas as regras legislativas de incentivo fiscal cujas metas não foram atingidas por
-- nenhuma filial nos últimos X meses.

-- Todas as regras legislativas de incentivo fiscal cujas metas foram alcançadas por pelo
-- menos uma filial todo mês, em um período de três meses subsequentes.

-- 1) Todas as filiais que não receberam nenhuma multa em um intervalo
PREPARE filial_sem_multa_p(DATE, DATE) AS
    SELECT cnpj_raiz, cnpj_ordem FROM filial 
        EXCEPT 
        SELECT 
            f.cnpj_raiz, 
            f.cnpj_ordem
        FROM filial AS f
            JOIN relatorio AS r 
                ON f.cnpj_raiz = r.cnpj_filial_raiz 
                AND f.cnpj_ordem = r.cnpj_filial_ordem
        WHERE r.dt_pedido BETWEEN $1 AND $2 AND r.multa_aplic > 0; 

-- 2) Todas as filiais que contribuíram mais do que $"R$X"$ em ações de compensação, nos últimos K meses, sendo pelo menos Y% de suas contribuições em uma area Z

-- 3) Todas as filiais cujas emissões nos últimos X meses foram oriundas majoritariamente de um único tipo de produto ou serviço. -- Implementar

-- 4) Todas as regras legislativas de incentivo fiscal cujas metas não foram atingidas por nenhuma filial nos últimos X meses

-- 5) Para todas as Instituições Cientificas do município X, listar a média do histórico de CO2 de cada empresa avaliadas por suas equipes, ordenadas pela média do histórico.
