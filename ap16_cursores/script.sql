--UPDATE e DELETE com cursores
-- remover tuplas em que video_count é desconhecido
-- exibir as tuplas remanescentes de baixo para cima
-- SELECT * FROM tb_top_youtubers 
-- WHERE video_count IS NULL;
DO $$
DECLARE
	--1. Declaração
	cur_delete REFCURSOR;
 	tupla RECORD;
BEGIN
	--2. Abertura
	OPEN cur_delete SCROLL FOR
	SELECT * FROM tb_top_youtubers;
	LOOP
		--3. Recuperação
		FETCH cur_delete INTO tupla;
		EXIT WHEN NOT FOUND;
		IF tupla.video_count IS NULL THEN
			DELETE FROM tb_top_youtubers 
			WHERE CURRENT OF cur_delete;
		END IF;
	END LOOP;
	LOOP
		--3. Recuperação de dados
		FETCH BACKWARD FROM cur_delete
		INTO tupla;
		EXIT WHEN NOT FOUND;
		RAISE NOTICE '%', tupla;
	END LOOP;
	--4. Fechamento
	CLOSE cur_delete;
END;
$$

--cursores com parâmetros nomeados e pela ordem
--começaram a partir de 2010 e tem pelo menos 60M de inscritos
-- DO $$
-- DECLARE
-- 	v_ano INT := 2010;
-- 	v_inscritos INT := 60000000;
-- 	v_youtuber VARCHAR(200);
-- 	--1. Declaração
-- 	cur_ano_inscritos 
-- 	CURSOR(ano INT, inscritos INT) 
-- 	FOR SELECT youtuber FROM 	
-- 	tb_top_youtubers WHERE
-- 	started >= ano 
-- 		AND subscribers >= inscritos;	
-- BEGIN
-- 	-- 2. Abertura
-- 	-- OPEN cur_ano_inscritos(
-- 	-- 	v_ano, v_inscritos
-- 	-- );
-- 	OPEN cur_ano_inscritos(
-- 		inscritos := v_inscritos,
-- 		ano := v_ano
-- 	);
-- 	LOOP
-- 		--3. Recuperação de dados
-- 		FETCH cur_ano_inscritos INTO v_youtuber;
-- 		EXIT WHEN NOT FOUND;
-- 		RAISE NOTICE '%', v_youtuber;
-- 	END LOOP;
-- 	-- 4. Fechamento
-- 	CLOSE cur_ano_inscritos;
-- END;
-- $$


--cursor vinculado(bound)
--concatenar nome e número de inscritos
-- DO $$
-- DECLARE
-- 	-- 1. Declaração
-- 	cur_nomes_e_inscritos CURSOR FOR
-- 	SELECT youtuber, subscribers FROM
-- 	tb_top_youtubers;
-- 	tupla RECORD;
-- 	resultado TEXT DEFAULT '';
-- BEGIN
-- 	--2. Abertura
-- 	OPEN cur_nomes_e_inscritos;
-- 	--3. Recuperação de dados
-- 	FETCH cur_nomes_e_inscritos INTO tupla;
-- 	WHILE FOUND LOOP
-- 		resultado := resultado || tupla.youtuber || ': ' || tupla.subscribers || ',';
-- 		--3. Recuperação de dados
-- 		FETCH cur_nomes_e_inscritos INTO tupla;
-- 	END LOOP;
-- 	--4. Fechamento
-- 	CLOSE cur_nomes_e_inscritos;
-- 	RAISE NOTICE '%', resultado;
-- END;
-- $$

--cursor não vinculado com query dinâmica
--exibir os nomes dos Youtubers que começaram a partir de um ano específico
-- DO $$
-- DECLARE
-- 	--1. Declaração do cursor
-- 	--não vinculado
-- 	cur_nomes_a_partir_de REFCURSOR;
-- 	v_youtuber VARCHAR(200);
-- 	v_ano INT := 2008;
-- 	v_nome_tabela VARCHAR(200) := 'tb_top_youtubers';
-- BEGIN
-- 	--2. Abertura do cursor
-- 	OPEN cur_nomes_a_partir_de FOR EXECUTE
-- 	-- f'SELECT... {v_nome_tabela}'
-- 	format(
-- 		'
-- 			SELECT youtuber
-- 			FROM
-- 			%s
-- 			WHERE started >= $1
-- 		',
-- 		v_nome_tabela
-- 	)USING v_ano;
-- 	LOOP
-- 		--3. Recuperação de dados
-- 		FETCH cur_nomes_a_partir_de INTO
-- 			v_youtuber;
-- 		EXIT WHEN NOT FOUND;
-- 		RAISE NOTICE '%', v_youtuber;
-- 	END LOOP;
-- 	--4. Fechar o cursor
-- 	CLOSE cur_nomes_a_partir_de;
-- END;
-- $$




-- DO $$
-- DECLARE
-- --1. declaração do cursor
-- --esse cursor é não vinculado (unbound), pois quando declaramos não especificamos o SELECT
-- cur_nomes_youtubers REFCURSOR;
-- v_youtuber VARCHAR(200);
-- BEGIN
-- --2. abertura do cursor
-- OPEN cur_nomes_youtubers FOR
-- SELECT youtuber 
-- FROM tb_top_youtubers;
-- LOOP
-- --3. recuperação de dados de interesse
-- 	FETCH cur_nomes_youtubers
-- 	INTO v_youtuber;
-- 	EXIT WHEN NOT FOUND;
-- 	RAISE NOTICE '%', v_youtuber;
-- END LOOP;
-- --4. Fechamento do cursor
-- CLOSE cur_nomes_youtubers;
-- END;
-- $$

-- SELECT * FROM tb_top_youtubers;

-- CREATE TABLE tb_top_youtubers(
-- 	cod_top_youtubers 
-- 		SERIAL PRIMARY KEY,
-- 	rank INT,
-- 	youtuber VARCHAR(200),
-- 	subscribers INT,
-- 	video_views INT,
-- 	video_count INT,
-- 	category VARCHAR(200),
-- 	started INT
-- );

-- ALTER TABLE tb_top_youtubers 
-- ALTER COLUMN video_views TYPE
-- BIGINT;