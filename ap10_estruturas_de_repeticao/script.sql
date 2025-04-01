-- DO $$
-- BEGIN
--     RAISE NOTICE '%', 1 / 0;
--     RAISE NOTICE 'Acabou...';
-- EXCEPTION
--     WHEN division_by_zero THEN
--         RAISE NOTICE 'Não divida por zero';
-- END;

--FOREACH com fatias (slice)
-- DO $$
-- DECLARE
--     vetor INT[] := ARRAY[1, 2, 3];
--     matriz INT[] := ARRAY[
--         [1, 2, 3],
--         [4, 5, 6],
--         [7, 8, 9]
--     ];
--     var_aux INT;
--     vet_aux INT[];
-- BEGIN
--     RAISE NOTICE 'SLICE %, vetor', 0;
--     FOREACH var_aux IN ARRAY vetor LOOP
--         RAISE NOTICE '%', var_aux;    
--     END LOOP;

--     RAISE NOTICE 'SLICE %, vetor', 1;
--     FOREACH vet_aux SLICE 1 IN ARRAY vetor LOOP
--         RAISE NOTICE '%', vet_aux;
--     END LOOP;

--     RAISE NOTICE 'SLICE %, matriz', 0;
--     FOREACH var_aux IN ARRAY matriz LOOP
--         RAISE NOTICE '%', var_aux;    
--     END LOOP;

--     RAISE NOTICE 'SLICE %, matriz', 1;
--     FOREACH vet_aux SLICE 1 IN ARRAY matriz LOOP
--         RAISE NOTICE '%', vet_aux;
--     END LOOP;

--     RAISE NOTICE 'SLICE %, matriz', 2;
--     FOREACH vet_aux SLICE 2 IN ARRAY matriz LOOP
--         RAISE NOTICE '%', vet_aux;
--     END LOOP;

-- END;
-- $$

-- DO $$
-- DECLARE
--     valores INT[] := ARRAY[
--         valor_aleatorio_entre(1, 10),
--         valor_aleatorio_entre(1, 10),
--         valor_aleatorio_entre(1, 10),
--         valor_aleatorio_entre(1, 10),
--         valor_aleatorio_entre(1, 10)
--     ];
--     valor INT;
--     soma INT := 0;
-- BEGIN
--     FOREACH valor IN ARRAY valores LOOP
--         RAISE NOTICE 'Valor da vez: %', valor;
--         soma := soma + valor;
--     END LOOP;
--     RAISE NOTICE 'Soma: %', soma;

-- END;
-- $$


-- DO $$
-- DECLARE
--     aluno RECORD;
--     media NUMERIC(10, 2) := 0;
--     total_alunos INT;
-- BEGIN
--     FOR aluno IN
--         SELECT * FROM tb_aluno
--     LOOP
--         RAISE NOTICE 'Nota do aluno %: %',
--         aluno.cod_aluno, aluno.nota;
--         media := media + aluno.nota;
--     END LOOP;
--     SELECT COUNT(*) FROM tb_aluno INTO total_alunos;
--     RAISE NOTICE 'Média: %', media / total_alunos;
-- END;
-- $$
-- class Aluno:
--     __init__(self, codigo, nota):
--         self.codigo = codigo
--         self.nota = nota

-- a = Aluno(1, 10)

-- SELECT * FROM tb_aluno;

-- DO $$
-- BEGIN
--     FOR i IN 1..10 LOOP
--         INSERT INTO tb_aluno
--         (nota)
--         VALUES
--         (valor_aleatorio_entre(0, 10));
--     END LOOP;
-- END;
-- $$

--criando a tabela
-- CREATE TABLE tb_aluno(
--     cod_aluno SERIAL PRIMARY KEY,
--     nota INT
-- );

--FOR
-- DO $$
-- BEGIN
--     --contar de a 10, de 1 em um
--     --intervalo fechado[1, 10]
--     FOR i IN 1..10 LOOP
--         RAISE NOTICE '%', i;
--     END LOOP;
--     --não mostra nada...
--     FOR i IN 10..1 LOOP
--         RAISE NOTICE '%', i;
--     END LOOP;
--     --contagem regressiva
--     FOR i In REVERSE 10..1 LOOP
--         RAISE NOTICE '%', i;
--     END LOOP;

--     --de 1 a 50 de 2 em 2
--     FOR i IN 1..50 BY 2 LOOP
--         RAISE NOTICE '%', i;
--     END LOOP;

--     --de 1 a 50 de 2 em 2
--     FOR i IN REVERSE 50..1 BY 2 LOOP
--         RAISE NOTICE '%', i;
--     END LOOP;
-- END;
-- $$

-- while
-- DO $$
-- DECLARE
--     nota INT;
--     media NUMERIC(10, 2) := 0;
--     contador INT := 1;
--     total_alunos INT := 5;
-- BEGIN
--     --[n, m]
--     -- [-1, 10]
--     --SELECT valor_aleatorio_entre(0, 11) - 1 INTO nota;
--     WHILE contador <= total_alunos LOOP
--         SELECT valor_aleatorio_entre(0, 10) INTO nota;
--         RAISE NOTICE '%', nota;
--         media := media + nota;
--         contador := contador + 1;
--     END LOOP;
--     RAISE NOTICE 'Média: %', media / contador;
--     -- IF contador > 0 THEN
--     --     RAISE NOTICE 'Média: %', media / contador;
--     -- ELSE
--     --     RAISE NOTICE 'Nenhuma nota gerada';
--     -- END IF;
-- END;
-- $$

-- CREATE OR REPLACE FUNCTION valor_aleatorio_entre (lim_inferior INT, lim_superior
-- INT) RETURNS INT AS
-- $$
-- BEGIN
-- RETURN FLOOR(RANDOM() * (lim_superior - lim_inferior + 1) + lim_inferior)::INT;
-- END;
-- -- $$ LANGUAGE plpgsql;

-- loops aninhados e rótulos
-- DO $$
-- DECLARE
--     i INT;
--     j INT;
-- BEGIN
--     i := 0;
--     <<externo>>
--     LOOP
--         i := i + 1;
--         EXIT WHEN i > 10;
--         j := 1;
--         <<interno>>
--         LOOP
--             RAISE NOTICE '% %', i, j;
--             j := j + 1;
--             CONTINUE externo WHEN j > 5;
--         END LOOP;
--     END LOOP;
-- END;
-- $$

-- DO $$
-- DECLARE
--     i INT;
--     j INT;
-- BEGIN
--     i := 0;
--     <<externo>>
--     LOOP
--         i := i + 1;
--         EXIT WHEN i > 10;
--         j := 1;
--         <<interno>>
--         LOOP
--             RAISE NOTICE '% %', i, j;
--             j := j + 1;
--             EXIT interno WHEN j > 5;
--         END LOOP;
--     END LOOP;
-- END;
-- $$


-- ignorando iterações com CONTINUE
-- DO $$
-- DECLARE
--     contador INT := 0;
-- BEGIN
--     LOOP
--         contador := contador + 1;
--         EXIT WHEN contador > 100;

--         IF contador % 7 = 0 THEN
--             CONTINUE;
--         END IF;

--         CONTINUE WHEN contador % 11 = 0;
        
--         RAISE NOTICE '%', contador;
--     END LOOP;
-- END;
-- $$




--EXIT/WHEN
-- DO $$
-- DECLARE
--     contador INT := 1;
-- BEGIN
--     LOOP
--         RAISE NOTICE '%', contador;
--         contador := contador + 1;
--         EXIT WHEN contador > 10;
--     END LOOP;
-- END;
-- $$



-- DO $$
-- DECLARE
--     contador INT := 1;
-- BEGIN
--     LOOP
--         RAISE NOTICE '%', contador;
--         contador := contador + 1;
--         IF contador > 10 THEN
--             EXIT;
--         END IF;
--     END LOOP;
-- END;
-- $$


-- DO $$
-- BEGIN
--     --esse é um loop infinito, não execute!
--     LOOP
--         RAISE NOTICE 'Um loop simples...';
--     END LOOP;
-- END;
-- $$