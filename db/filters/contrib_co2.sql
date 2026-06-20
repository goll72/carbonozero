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

-- Impede que contribuições para uma ação que excederiam o valor limite sejam feitas.
-- Se possível, realiza a contribuição, porém reduzindo o valor para o máximo permitido.
CREATE OR REPLACE FUNCTION contrib_co2_below_lim() RETURNS TRIGGER AS $$
    DECLARE
        diff DECIMAL;
    BEGIN
        diff := (
            SELECT a.valor_lim - SUM(c.valor)
                FROM vinc_contrib_co2 AS u
                JOIN acao_co2 AS a ON (a.cnpj, a.dt_inicio, a.nome) = (new.cnpj_organiz_socioamb, new.dt_inicio_acao_co2, new.nome_acao_co2)
                JOIN contrib_co2 AS c ON c.id_contrib = u.id
                WHERE (u.cnpj_organiz_socioamb, u.dt_inicio_acao_co2, u.nome_acao_co2) = (new.cnpj_organiz_socioamb, new.dt_inicio_acao_co2, new.nome_acao_co2)
                GROUP BY a.valor_lim
        );

        IF tg_op = 'UPDATE' THEN
            diff := diff + old.valor;
        END IF;

        IF diff <= 0 THEN
            RETURN NULL;
        END IF;
        
        IF diff < new.valor THEN
            new.valor := diff;
        END IF;

        RETURN new;
    END;
$$ LANGUAGE plpgsql;

-- Impede que vínculos de contribuição sejam criados para ações que já atingiram o valor limite.
CREATE OR REPLACE FUNCTION vinc_contrib_co2_below_lim() RETURNS TRIGGER AS $$
    BEGIN
        IF (
            SELECT SUM(c.valor) < a.valor_lim
                FROM acao_co2 AS a
                JOIN vinc_contrib_co2 AS u ON (u.cnpj_organiz_socioamb, u.dt_inicio_acao_co2, u.nome_acao_co2) = (a.cnpj, a.dt_inicio, a.nome)
                JOIN contrib_co2 AS c ON u.id = c.id_contrib
                WHERE (new.cnpj_organiz_socioamb, new.dt_inicio_acao_co2, new.nome_acao_co2) = (a.cnpj, a.dt_inicio, a.nome)
        ) THEN
            RETURN new;
        ELSE
            RETURN NULL;
        END IF;
    END;
$$ LANGUAGE plpgsql;
