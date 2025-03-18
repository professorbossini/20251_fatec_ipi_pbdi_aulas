DO $$
DECLARE
    n1 NUMERIC (5, 2);
    n2 INT;
    limite_inferior INT := 1;
    limite_superior INT := 3;
BEGIN
    -- 0 <= n1 < 1 (real) [0, 1)
    n1 := random();
    RAISE NOTICE 'n1: %', n1;
    -- 1 <= n1 < 10 (real) [1, 10)
    n1 := 1 + random() *  9;
    RAISE NOTICE '%', n1;
    -- 0.42
    -- 1.78
    n2 := floor(random() * 10 + 1)::INT;
    RAISE NOTICE 'n2: %', n2;
    n2 := floor(random() * (limite_superior - limite_inferior + 1) + limite_inferior)::INT;
    RAISE NOTICE 'Intervalo qualquer: %', n2;
END;
$$

--variáveis
-- DO
-- $$
-- DECLARE
--     v_codigo INTEGER := 1;
--     v_nome_completo VARCHAR(200) := 'João';
--     v_salario NUMERIC (11, 2) := 20.5;
-- BEGIN
-- -- nome = 'Ana'
-- -- print(f'Me chamo {nome}')
--     RAISE NOTICE 'Meu código é %, me chamo % e meu salário é %.', v_codigo, v_nome_completo, v_salario;
-- END;
-- $$

--placeholders de expressões em strings
-- DO
-- $$
-- BEGIN
--     RAISE NOTICE '% + % = %', 2, 2, 2 + 2; 
-- END;
-- $$


-- DO
-- $$
-- BEGIN
--     RAISE NOTICE 'Meu primeiro bloquinho anônimo';
-- END;
-- $$
-- CREATE DATABASE "20251_fatec_ipi_pbdi_rodrigo";