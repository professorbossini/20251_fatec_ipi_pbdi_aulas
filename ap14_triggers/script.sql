-- fazer o trigger

UPDATE tb_pessoa
SET saldo = 3000
WHERE cod_pessoa = 12;

SELECT * FROM tb_pessoa;

SELECT * FROM tb_auditoria;

CREATE OR REPLACE TRIGGER tg_log_pessoa_update
AFTER UPDATE ON tb_pessoa
FOR EACH ROW
    EXECUTE PROCEDURE fn_log_pessoa_update();

-- fazer o update

-- CREATE OR REPLACE FUNCTION fn_log_pessoa_update()
-- RETURNS TRIGGER
-- LANGUAGE plpgsql AS $$
-- BEGIN
-- -- insert na tabela auditoria
-- -- registrando os dados novos, e incluindo o saldo antigo
--   INSERT INTO tb_auditoria(
--     cod_pessoa, nome, idade, saldo_antigo, saldo_atual
--   ) VALUES(
--     NEW.cod_pessoa, NEW.nome, NEW.idade, OLD.saldo, NEW.saldo
--   );
--   RETURN NEW;
-- END;
-- $$


-- INSERT INTO tb_pessoa(nome, idade, saldo) VALUES
-- ('Ana', 20, 100),
-- ('Paula', 30, 200),
-- ('Isabela', 20, 500);

SELECT * FROM tb_auditoria;

-- ALTER TABLE tb_auditoria ADD COLUMN 
--   IF NOT EXISTS nome VARCHAR(200) NOT NULL;

-- CREATE OR REPLACE TRIGGER tg_log_pessoa_insert
-- AFTER INSERT ON tb_pessoa
-- FOR EACH ROW
--   EXECUTE PROCEDURE fn_log_pessoa_insert();

-- SELECT * FROM tb_auditoria;

-- CREATE OR REPLACE FUNCTION fn_log_pessoa_insert()
-- RETURNS TRIGGER
-- LANGUAGE plpgsql AS $$
-- BEGIN
--   INSERT INTO tb_auditoria
--   (cod_pessoa, nome, idade, saldo_antigo, saldo_atual)
--   VALUES
--   (NEW.cod_pessoa, NEW.nome, NEW.idade, NULL, NEW.saldo);
--   RETURN NULL;
-- END;
-- $$




-- SELECT * FROM tb_pessoa;


-- INSERT INTO tb_pessoa
-- (nome, idade, saldo) VALUES
-- ('João', 20, 100),
-- ('Pedro', 22, -100),
-- ('Maria', 22, 400);

-- DELETE FROM tb_pessoa WHERE 1 = 1;
-- escrever uma function que devolve trigger
-- é uma função de validação de saldo
-- se o saldo for pelo menos zero, deixar a operação acontecer
-- caso contrário, não deixar
-- além disso, exibir o saldo, caso ele seja inválido
-- CREATE OR REPLACE FUNCTION fn_validador_de_saldo()
-- RETURNS TRIGGER
-- LANGUAGE plpgsql AS $$
-- BEGIN
--   IF NEW.saldo >= 0 THEN
--     RETURN NEW;
--   ELSE
--     RAISE NOTICE 'Valor de saldo R$% inválido!', NEW.saldo;
--     RETURN NULL;
--   END IF;
-- END;
-- $$


-- criar um trigger para vincular a função à tabela
-- ele deve executar antes de insert e de update tbm
-- CREATE TRIGGER tg_validador_de_saldo
-- BEFORE INSERT OR UPDATE ON tb_pessoa
-- FOR ROW
-- EXECUTE FUNCTION fn_validador_de_saldo();

-- DROP TABLE IF EXISTS tb_pessoa;
-- CREATE TABLE IF NOT EXISTS tb_pessoa(
--   cod_pessoa SERIAL PRIMARY KEY,
--   nome VARCHAR(200) NOT NULL,
--   idade INT NOT NULL,
--   saldo NUMERIC(10, 2) NOT NULL
-- );

-- CREATE TABLE IF NOT EXISTS tb_auditoria(
--   cod_auditoria SERIAL PRIMARY KEY,
--   cod_pessoa INT NOT NULL,
--   idade INT NOT NULL,
--   saldo_antigo NUMERIC(10, 2),
--   saldo_atual NUMERIC(10, 2)
-- );





-- -- UPDATE tb_teste_trigger SET texto='texto atualizado'
-- -- WHERE cod_teste_trigger IN (2,3);

-- -- SELECT * FROM tb_teste_trigger;

-- INSERT INTO tb_teste_trigger(texto) VALUES('oi de novo v3');

-- -- CREATE OR REPLACE FUNCTION fn_depois_de_um_insert()
-- -- RETURNS TRIGGER
-- -- LANGUAGE plpgsql
-- -- AS $$
-- -- BEGIN
-- --   RAISE NOTICE 'Estamos no trigger AFTER!';
-- --   RAISE NOTICE 'OLD: %', OLD;
-- --   RAISE NOTICE 'NEW: %', NEW;
-- --   RAISE NOTICE 'OLD.texto: %', OLD.texto;
-- --   RAISE NOTICE 'NEW.texto: %', NEW.texto;
-- --   RAISE NOTICE 'TG_NAME: %', TG_NAME;
-- --   RAISE NOTICE 'TG_LEVEL: %', TG_LEVEL;
-- --   RAISE NOTICE 'TG_WHEN: %', TG_WHEN;
-- --   RAISE NOTICE 'TG_TABLE_NAME: %', TG_TABLE_NAME;
-- --   FOR i IN 0..TG_NARGS - 1 LOOP
-- --     RAISE NOTICE '%',TG_ARGV[i];
-- --   END LOOP;
-- --   RETURN NEW;
-- -- END;
-- $$

-- -- CREATE OR REPLACE FUNCTION fn_antes_de_um_insert()
-- -- RETURNS TRIGGER
-- -- LANGUAGE plpgsql
-- -- AS $$
-- -- BEGIN
-- --   RAISE NOTICE 'Estamos no trigger BEFORE';
-- --   RAISE NOTICE 'OLD: %', OLD;
-- --   RAISE NOTICE 'NEW: %', NEW;
-- --   RAISE NOTICE 'OLD.texto: %', OLD.texto;
-- --   RAISE NOTICE 'NEW.texto: %', NEW.texto;
-- --   RAISE NOTICE 'TG_NAME: %', TG_NAME;
-- --   RAISE NOTICE 'TG_LEVEL: %', TG_LEVEL;
-- --   RAISE NOTICE 'TG_WHEN: %', TG_WHEN;
-- --   RAISE NOTICE 'TG_TABLE_NAME: %', TG_TABLE_NAME;
-- --   FOR i IN 0..TG_NARGS - 1 LOOP
-- --     RAISE NOTICE '%',TG_ARGV[i];
-- --   END LOOP;
-- --   RETURN NEW; --mais sobre isso em breve
-- -- END;
-- -- $$


-- CREATE OR REPLACE TRIGGER tg_depois_de_um_insert
-- AFTER INSERT OR UPDATE ON tb_teste_trigger
-- FOR EACH ROW
-- EXECUTE FUNCTION fn_depois_de_um_insert(
--   'Depois: V1', 'Depois: V2', 'Depois: V3'
-- );

-- DROP TRIGGER IF EXISTS tg_antes_do_insert
-- ON tb_teste_trigger;
-- CREATE OR REPLACE TRIGGER tg_antes_de_um_insert
-- BEFORE INSERT OR UPDATE ON tb_teste_trigger
-- FOR EACH ROW
-- --aqui vc pode falar FUNCTION OU PROCEDURE (mas não ROUTINE)
-- EXECUTE FUNCTION fn_antes_de_um_insert('Antes: V1', 'Antes: V2');



-- DROP TRIGGER IF EXISTS tg_antes_do_insert2
-- ON tb_teste_trigger;
-- DROP TRIGGER IF EXISTS tg_depois_do_insert2
-- ON tb_teste_trigger;


-- ALTER SEQUENCE tb_teste_trigger_cod_teste_trigger_seq RESTART WITH 1;



-- SELECT * FROM tb_teste_trigger_cod_teste_trigger_seq;

-- DELETE FROM tb_teste_trigger;

-- SELECT * FROM tb_teste_trigger;

-- INSERT INTO tb_teste_trigger
-- (texto) VALUES ('testando trigger');


-- CREATE OR REPLACE TRIGGER tg_depois_do_insert2
-- AFTER INSERT ON tb_teste_trigger
-- FOR EACH STATEMENT
-- EXECUTE PROCEDURE fn_depois_de_um_insert();

-- CREATE OR REPLACE TRIGGER tg_antes_do_insert2
-- BEFORE INSERT ON tb_teste_trigger
-- FOR EACH STATEMENT
-- EXECUTE PROCEDURE fn_antes_de_um_insert();


-- INSERT INTO tb_teste_trigger
-- (texto) VALUES ('testando trigger');

-- CREATE OR REPLACE TRIGGER tg_depois_de_um_insert
-- AFTER INSERT ON tb_teste_trigger
-- FOR STATEMENT
-- EXECUTE FUNCTION fn_depois_de_um_insert();

-- CREATE OR REPLACE FUNCTION fn_depois_de_um_insert()
-- RETURNS TRIGGER
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--   RAISE NOTICE 'Trigger foi chamado depois do INSERT!';
--   RETURN NULL; -- mais sobre isso em breve
-- END;
-- $$

-- INSERT INTO tb_teste_trigger (texto)
-- VALUES('testando trigger');

-- CREATE OR REPLACE TRIGGER tg_antes_do_insert
-- BEFORE INSERT ON tb_teste_trigger
-- FOR EACH STATEMENT
-- --aqui vc pode falar FUNCTION OU PROCEDURE (mas não ROUTINE)
-- EXECUTE FUNCTION fn_antes_de_um_insert();




-- CREATE OR REPLACE FUNCTION fn_antes_de_um_insert()
-- RETURNS TRIGGER
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--   RAISE NOTICE 'Trigger foi chamado antes do INSERT!';
--   RETURN NULL; --mais sobre isso em breve
-- END;
-- $$

-- CREATE TABLE tb_teste_trigger(
--   cod_teste_trigger SERIAL PRIMARY KEY,
--   texto VARCHAR(200)
-- );