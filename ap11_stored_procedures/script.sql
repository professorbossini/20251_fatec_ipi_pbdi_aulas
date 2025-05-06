CREATE OR REPLACE PROCEDURE sp_cadastrar_cliente
(IN p_nome VARCHAR(200), IN p_cod_cliente INT DEFAULT NULL)
LANGUAGE plpgsql
AS $$
BEGIN
  IF p_cod_cliente IS NULL THEN
    INSERT INTO tb_cliente (nome) VALUES (p_nome);
  ELSE
    INSERT INTO tb_cliente 
    (cod_cliente, nome) VALUES
    (p_cod_cliente, p_nome);
  END IF;
END;
$$

-- CREATE TABLE tb_item_pedido(
--   --surrogate key
--   cod_item_pedido SERIAL PRIMARY KEY,
--   cod_item INT NOT NULL,
--   cod_pedido INT NOT NULL,
--   CONSTRAINT fk_item FOREIGN KEY(cod_item) REFERENCES tb_item(cod_item),
--   CONSTRAINT fk_pedido FOREIGN KEY(cod_pedido) REFERENCES tb_pedido(cod_pedido)
-- );
-- 1,7
-- 1,7
-- INSERT INTO tb_item
-- (descricao, valor, cod_tipo)
-- VALUES
-- ('Refrigerante', 7, 1),
-- ('Suco', 8, 1),
-- ('Hamburguer', 12, 2),
-- ('Batata frita', 9, 2);


-- CREATE TABLE tb_item(
--   cod_item SERIAL PRIMARY KEY,
--   descricao VARCHAR(200) NOT NULL,
--   valor NUMERIC (10, 2) NOT NULL,
--   cod_tipo INT NOT NULL,
--   CONSTRAINT fk_tipo_item FOREIGN KEY (cod_tipo) REFERENCES tb_tipo_item(cod_tipo)
-- );


-- INSERT INTO tb_tipo_item
-- (descricao) VALUES
-- ('Bebida'), ('Comida');

-- CREATE TABLE tb_tipo_item(
--   cod_tipo SERIAL PRIMARY KEY,
--   descricao VARCHAR(200) NOT NULL
-- );

-- CREATE TABLE tb_pedido(
--   cod_pedido SERIAL PRIMARY KEY,
--   data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--   data_modificacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--   status VARCHAR (100) DEFAULT 'aberto',
--   cod_cliente INT NOT NULL,
--   CONSTRAINT fk_cliente FOREIGN KEY (cod_cliente) REFERENCES tb_cliente(cod_cliente)
-- );

-- CREATE TABLE tb_cliente(
--   cod_cliente SERIAL PRIMARY KEY,
--   nome VARCHAR(200) NOT NULL
-- );



-- CALL sp_calcula_media(1);

-- CALL sp_calcula_media(1, 2, 3);

-- CALL sp_calcula_media();

-- CREATE OR REPLACE PROCEDURE sp_calcula_media
-- (VARIADIC p_valores INT[])
-- LANGUAGE plpgsql
-- AS $$
-- DECLARE
--   v_media NUMERIC(10, 2) := 0;
--   v_valor INT;
-- BEGIN
--   FOREACH v_valor IN ARRAY p_valores LOOP
--     v_media := v_media + v_valor;
--   END LOOP;
--   RAISE NOTICE 
--     'A média é %', 
--     -- v_media / array_length(p_valores, 1); --1 é o slice
-- END;
-- $$

-- def somar(*valores):
--   ac = 0
--     for valor in valores:
--       ac += valor
--     return ac

-- somar(a, b, 2, 3, 1, 2, 1)
-- def somar (valores):
--   ac = 0
--   for valor in valores:
--     ac += valor
--   return ac

-- a = 2
-- b = 3
-- c = 4
-- print(somar([a, b, c]))



--colocando em execução (chamando ou invocando, jamais puxando)
-- DO $$
-- DECLARE
--   v_valor1 INT := 2;
--   v_valor2 INT := 3;
-- BEGIN
--   CALL sp_acha_maior(v_valor1, v_valor2);
--   RAISE NOTICE '% é o maior', v_valor1;
-- END;
-- $$

-- DROP PROCEDURE IF EXISTS sp_acha_maior;
-- CREATE OR REPLACE PROCEDURE sp_acha_maior
-- (INOUT p_valor1 INT, IN p_valor2 INT)
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--   IF $2 > $1 THEN
--     $1 := $2;
--   END IF;
-- END;
-- $$

-- DO $$
-- DECLARE
--   v_resultado INT;
-- BEGIN
--   CALL sp_acha_maior(v_resultado, 2, 3);
--   RAISE NOTICE '% é o maior', v_resultado;
-- END;
-- $$

-- DROP PROCEDURE IF EXISTS sp_acha_maior;
-- CREATE OR REPLACE PROCEDURE sp_acha_maior
-- (OUT p_resultado INT, IN p_valor1 INT, IN p_valor2 INT)
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--   CASE
--     WHEN p_valor1 > p_valor2 THEN
--       p_resultado := p_valor1;
--     ELSE
--       $1 := p_valor2;
--   END CASE;  
-- END;
-- $$

-- CALL sp_acha_maior(2, 3);

-- CREATE OR REPLACE PROCEDURE sp_acha_maior
-- (IN p_valor1 INT, p_valor2 INT) --IN é o modo padrão
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--   IF p_valor1 > p_valor2 THEN
--     RAISE NOTICE '% é o maior', $1;
--   ELSE
--     RAISE NOTICE '% é o maior', $2;
--   END IF;
-- END;
-- $$



-- CALL sp_ola_usuario('Pedro');

-- CREATE OR REPLACE PROCEDURE sp_ola_usuario(p_nome VARCHAR(200))
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--   --acessar o parâmetro pelo nome dele
--   RAISE NOTICE 'Olá, %', p_nome;
--   --acessar o parâmetro pelo seu "número identificador, começando do 1"
--   RAISE NOTICE 'Olá, %', $1;
-- END;
-- $$



-- CALL sp_ola_procedures();

-- CREATE OR REPLACE PROCEDURE sp_ola_procedures()
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--   RAISE NOTICE 'Olá, procedures';
-- END;
-- $$