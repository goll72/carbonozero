CREATE OR REPLACE FUNCTION relatorio_valid_mun() RETURNS TRIGGER AS $$
    BEGIN
        IF new.cod_mun IS NULL THEN
            new.cod_mun := (
                SELECT mun_cod
                    FROM filial
                    WHERE (cnpj_raiz, cnpj_ordem) = (new.cnpj_filial_raiz, new.cnpj_filial_ordem)
            );
        END IF;

        RETURN new;
    END;
$$ LANGUAGE plpgsql;
