

-- UPDATE tb_teste_trigger SET texto='texto atualizado'
-- WHERE cod_teste_trigger IN (2,3);

-- SELECT * FROM tb_teste_trigger;

INSERT INTO tb_teste_trigger(texto) VALUES('oi de novo v3');

-- CREATE OR REPLACE FUNCTION fn_depois_de_um_insert()
-- RETURNS TRIGGER
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--   RAISE NOTICE 'Estamos no trigger AFTER!';
--   RAISE NOTICE 'OLD: %', OLD;
--   RAISE NOTICE 'NEW: %', NEW;
--   RAISE NOTICE 'OLD.texto: %', OLD.texto;
--   RAISE NOTICE 'NEW.texto: %', NEW.texto;
--   RAISE NOTICE 'TG_NAME: %', TG_NAME;
--   RAISE NOTICE 'TG_LEVEL: %', TG_LEVEL;
--   RAISE NOTICE 'TG_WHEN: %', TG_WHEN;
--   RAISE NOTICE 'TG_TABLE_NAME: %', TG_TABLE_NAME;
--   FOR i IN 0..TG_NARGS - 1 LOOP
--     RAISE NOTICE '%',TG_ARGV[i];
--   END LOOP;
--   RETURN NEW;
-- END;
$$

-- CREATE OR REPLACE FUNCTION fn_antes_de_um_insert()
-- RETURNS TRIGGER
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--   RAISE NOTICE 'Estamos no trigger BEFORE';
--   RAISE NOTICE 'OLD: %', OLD;
--   RAISE NOTICE 'NEW: %', NEW;
--   RAISE NOTICE 'OLD.texto: %', OLD.texto;
--   RAISE NOTICE 'NEW.texto: %', NEW.texto;
--   RAISE NOTICE 'TG_NAME: %', TG_NAME;
--   RAISE NOTICE 'TG_LEVEL: %', TG_LEVEL;
--   RAISE NOTICE 'TG_WHEN: %', TG_WHEN;
--   RAISE NOTICE 'TG_TABLE_NAME: %', TG_TABLE_NAME;
--   FOR i IN 0..TG_NARGS - 1 LOOP
--     RAISE NOTICE '%',TG_ARGV[i];
--   END LOOP;
--   RETURN NEW; --mais sobre isso em breve
-- END;
-- $$


CREATE OR REPLACE TRIGGER tg_depois_de_um_insert
AFTER INSERT OR UPDATE ON tb_teste_trigger
FOR EACH ROW
EXECUTE FUNCTION fn_depois_de_um_insert(
  'Depois: V1', 'Depois: V2', 'Depois: V3'
);

DROP TRIGGER IF EXISTS tg_antes_do_insert
ON tb_teste_trigger;
CREATE OR REPLACE TRIGGER tg_antes_de_um_insert
BEFORE INSERT OR UPDATE ON tb_teste_trigger
FOR EACH ROW
--aqui vc pode falar FUNCTION OU PROCEDURE (mas não ROUTINE)
EXECUTE FUNCTION fn_antes_de_um_insert('Antes: V1', 'Antes: V2');



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