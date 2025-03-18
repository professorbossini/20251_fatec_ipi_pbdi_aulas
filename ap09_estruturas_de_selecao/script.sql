DO $$
DECLARE
    v_valor INT;
BEGIN
    v_valor := valor_aleatorio_entre(1, 50);
    IF v_valor <= 20 THEN
        RAISE NOTICE 'A metade de % é %', v_valor, v_valor / 2::FLOAT;
    END IF;
END;
$$



-- CREATE OR REPLACE FUNCTION valor_aleatorio_entre (lim_inferior INT, lim_superior
-- INT) RETURNS INT AS
-- $$
-- BEGIN
-- RETURN FLOOR(RANDOM() * (lim_superior - lim_inferior + 1) + lim_inferior)::INT;
-- END;
-- $$ LANGUAGE plpgsql;