-- Remove toda regra legislativa de incentivo fiscal que se encontra
-- em conflito com uma ou mais regras legislativas de multa.
CREATE OR REPLACE PROCEDURE remove_contradictory_rules() AS $$
    DELETE FROM reg_leg
        WHERE (ent, tipo, nro, ano) IN (
            SELECT a.ent, a.tipo, a.nro, a.ano
                FROM reg_leg AS a
                JOIN reg_leg AS b ON b.tipo = 'multa' AND a.ent = b.ent OR b.ent = substring(a.ent, 1, 2)
                WHERE a.tipo = 'if'
                    AND ((a.prod IS NULL AND a.serv IS NULL) OR (b.prod IS NULL AND b.serv IS NULL) OR (a.prod = b.prod AND a.serv = b.serv))
                    AND a.meta_if > b.lim_multa
                    AND tsrange(a.dt_vigencia, a.dt_revogacao) && tsrange(b.dt_vigencia, b.dt_revogacao)
        );
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION reg_leg_no_contradictory_rules() RETURNS TRIGGER AS $$
    BEGIN
        IF new.prod IS NOT NULL AND new.serv IS NOT NULL THEN
            RETURN NULL;
        END IF;
        
        IF new.tipo = 'if' AND (
            (
                new.lim_multa IS NOT NULL
                OR new.base_calc_multa IS NOT NULL
                OR new.meta_if IS NULL
                OR new.aliq_if IS NULL
            )
            OR
            EXISTS (
                SELECT 1
                    FROM reg_leg
                    WHERE
                        tipo = 'multa'
                        AND (ent = new.ent OR ent = substring(new.ent, 1, 2))
                        AND ((new.prod IS NULL AND new.serv IS NULL) OR (prod IS NULL and serv IS NULL) OR (new.prod = prod AND new.serv = serv))
                        AND new.meta_if > lim_multa
                        AND tsrange(new.dt_vigencia, new.dt_revogacao) && tsrange(dt_vigencia, dt_revogacao)
            )
        ) THEN
            RETURN NULL;
        END IF;

        IF new.tipo = 'multa' AND (
            (
                new.lim_multa IS NULL
                OR new.base_calc_multa IS NULL
                OR new.meta_if IS NOT NULL
                OR new.aliq_if IS NOT NULL
            )
            OR
            EXISTS (
                SELECT 1
                    FROM reg_leg
                    WHERE
                        tipo = 'if'
                        AND (ent = new.ent OR ent = substring(new.ent, 1, 2))
                        AND ((new.prod IS NULL AND new.serv IS NULL) OR (prod IS NULL and serv IS NULL) OR (new.prod = prod AND new.serv = serv))
                        AND new.lim_multa < meta_if
                        AND tsrange(new.dt_vigencia, new.dt_revogacao) && tsrange(dt_vigencia, dt_revogacao)
            )
        ) THEN
            RETURN NULL;
        END IF;
        
        RETURN new;
    END;
$$ LANGUAGE plpgsql;
