-- Remove todas as contribuições feitas para uma ação
-- de compensação cujo valor limite já foi atingido.
CREATE OR REPLACE PROCEDURE remove_contrib_exceeding_lim() AS $$
    DELETE FROM vinc_contrib_co2
        WHERE (cnpj_organiz_socioamb, dt_inicio_acao_co2, nome_acao_co2) IN (
            SELECT cnpj, dt_inicio, nome
                FROM (
                    SELECT
                            a.cnpj,
                            a.dt_inicio,
                            a.nome,
                            SUM(valor) > a.valor_lim AS exceeded
                        FROM vinc_contrib_co2 AS v
                        JOIN contrib_co2 AS c ON c.id_contrib = v.id
                        JOIN acao_co2 AS a ON (a.cnpj, a.dt_inicio, a.nome) = (v.cnpj_organiz_socioamb, v.dt_inicio_acao_co2, v.nome_acao_co2)
                        GROUP BY a.cnpj, a.dt_inicio, a.nome, a.valor_lim
                )
                WHERE exceeded
        );
$$ LANGUAGE sql;
