DO $$
DECLARE
--1. declaração do cursor
--esse cursor é não vinculado (unbound), pois quando declaramos não especificamos o SELECT
cur_nomes_youtubers REFCURSOR;
v_youtuber VARCHAR(200);
BEGIN
--2. abertura do cursor
OPEN cur_nomes_youtubers FOR
SELECT youtuber 
FROM tb_top_youtubers;
LOOP
--3. recuperação de dados de interesse
	FETCH cur_nomes_youtubers
	INTO v_youtuber;
	EXIT WHEN NOT FOUND;
	RAISE NOTICE '%', v_youtuber;
END LOOP;
--4. Fechamento do cursor
CLOSE cur_nomes_youtubers;
END;
$$

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