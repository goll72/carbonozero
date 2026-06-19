-- Remove toda regra legislativa de incentivo fiscal que se encontra
-- em conflito com uma ou mais regras legislativas de multa.
CREATE OR REPLACE PROCEDURE remove_contradictory_rules() AS $$
    DELETE FROM reg_leg
        WHERE (ent, tipo, nro, ano) IN (
            SELECT b.ent, b.tipo, b.nro, b.ano
                FROM reg_leg AS a
                JOIN reg_leg AS b ON b.tipo = 'multa' AND a.ent = b.ent OR b.ent = substring(a.ent, 1, 2)
                WHERE a.tipo = 'if'
                    AND ((a.prod IS NULL AND a.serv IS NULL) OR (b.prod IS NULL AND b.serv IS NULL) OR (a.prod = b.prod AND a.serv = b.serv))
                    AND a.meta_if > b.lim_multa
        );
$$ LANGUAGE sql;
