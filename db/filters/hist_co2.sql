CREATE OR REPLACE FUNCTION hist_co2_update_from_relatorio_prod() RETURNS TRIGGER AS $$
    DECLARE
        r relatorio;
        h hist_co2;
    BEGIN
        IF tg_op = 'delete' THEN
            r := (SELECT * FROM relatorio WHERE id = old.id_relatorio);
        ELSE
            r := (SELECT * FROM relatorio WHERE id = new.id_relatorio);
        END IF;
        
        h := (
            r.cnpj_filial_raiz,
            r.cnpj_filial_ordem,
            date_part('year', r.dt_pedido + INTERVAL '1 month'),
            date_part('month', r.dt_pedido + INTERVAL '1 month'),
            0,
            0
        );
        
        -- Sem SELECT, não sobrescreve se resultados não forem encontrados
        h := FROM hist_co2 WHERE (r.cnpj_filial_raiz, r.cnpj_filial_ordem) = (h.cnpj_raiz, h.cnpj_ordem) AND ano = h.ano AND mes = h.mes;

        IF tg_op = 'insert' THEN
            h.emissao_tot := h.emissao_tot + new.qtde * new.tco2_p_un;
        ELSIF tg_op = 'update' THEN
            h.emissao_tot := h.emissao_tot + new.qtde * new.tco2_p_un - old.qtde * old.tco2_p_un;
        ELSIF tg_op = 'delete' THEN
            h.emissao_tot := h.emissao_tot - old.qtde * old.tco2_p_un;            
        END IF;

        INSERT INTO hist_co2 (SELECT h.*) ON CONFLICT DO UPDATE SET emissao_tot = h.emissao_tot;
        RETURN new;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION hist_co2_update_from_relatorio_serv() RETURNS TRIGGER AS $$
    DECLARE
        r relatorio;
        h hist_co2;
    BEGIN
        IF tg_op = 'delete' THEN
            r := (SELECT * FROM relatorio WHERE id = old.id_relatorio);
        ELSE
            r := (SELECT * FROM relatorio WHERE id = new.id_relatorio);
        END IF;

        h := (
            r.cnpj_filial_raiz,
            r.cnpj_filial_ordem,
            date_part('year', r.dt_pedido + INTERVAL '1 month'),
            date_part('month', r.dt_pedido + INTERVAL '1 month'),
            0,
            0
        );
        
        -- Sem SELECT, não sobrescreve se resultados não forem encontrados
        h := FROM hist_co2 WHERE (r.cnpj_filial_raiz, r.cnpj_filial_ordem) = (h.cnpj_raiz, h.cnpj_ordem) AND ano = h.ano AND mes = h.mes;

        IF tg_op = 'insert' THEN
            h.emissao_tot := h.emissao_tot + new.tco2;
        ELSIF tg_op = 'update' THEN
            h.emissao_tot := h.emissao_tot + new.tco2 - old.tco2;
        ELSIF tg_op = 'delete' THEN
            h.emissao_tot := h.emissao_tot - old.tco2;
        END IF;

        INSERT INTO hist_co2 (SELECT h.*) ON CONFLICT DO UPDATE SET emissao_tot = h.emissao_tot;
        RETURN new;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION hist_co2_update_from_contrib_co2() RETURNS TRIGGER AS $$
    DECLARE
        a acao_co2;
        h hist_co2;

        dt DATE;
    BEGIN
        a := (
            SELECT acao_co2.*
                FROM vinc_contrib_co2 AS v
                JOIN acao_co2 ON (cnpj, dt_inicio, nome) = (v.cnpj_organiz_socioamb, v.dt_inicio_acao_co2, v.nome_acao_co2)
                WHERE id = (
                    CASE
                        WHEN tg_op = 'delete' THEN old.id_contrib
                        ELSE new.id_contrib
                    END
                )
        );

        dt := CASE
            WHEN tg_op = 'delete' THEN old.dt
            ELSE new.dt
        END;

        h := (
            r.cnpj_filial_raiz,
            r.cnpj_filial_ordem,
            date_part('year', dt),
            date_part('month', dt),
            0,
            0
        );

        -- Sem SELECT, não sobrescreve se resultados não forem encontrados
        h := FROM hist_co2 WHERE (r.cnpj_filial_raiz, r.cnpj_filial_ordem) = (h.cnpj_raiz, h.cnpj_ordem) AND ano = h.ano AND mes = h.mes;

        IF tg_op = 'insert' THEN
            h.compens_tot := h.compens_tot + new.valor * a.razao_comp_custo;
        ELSIF tg_op = 'update' THEN
            h.compens_tot := h.compens_tot + contrib_co2_calulate_compens(new, a) - contrib_co2_calculate_compens(old, a);
        ELSIF tg_op = 'delete' THEN
            h.compens_tot := h.compens_tot - contrib_co2_calculate_compens(old, a);
        END IF;

        INSERT INTO hist_co2 (SELECT h.*) ON CONFLICT DO UPDATE SET compens_tot = h.compens_tot;
        RETURN new;
    END;
$$ LANGUAGE plpgsql;
