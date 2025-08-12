CREATE OR REPLACE VIEW comments_per_week_v AS
SELECT date_trunc('week', a.created_at) as weeks,
	SUM(b.counter) as total_claps,
	COUNT(DISTINCT a.post_id) AS number_of_posts,
	COUNT(*) as number_of_claps
FROM posts a
INNER JOIN claps b ON a.post_id = b.post_id
GROUP BY weeks
ORDER BY weeks DESC;

DROP VIEW comments_per_week_v;

DROP MATERIALIZED VIEW comments_per_week_mat;

SELECT * FROM posts WHERE post_id = 1;



CREATE MATERIALIZED VIEW comments_per_week_mat AS
 SELECT date_trunc('week'::text, a.created_at) AS weeks,
    sum(b.counter) AS total_claps,
    count(DISTINCT a.post_id) AS number_of_posts,
    count(*) AS number_of_claps
   FROM (posts a
     JOIN claps b ON ((a.post_id = b.post_id)))
  GROUP BY (date_trunc('week'::text, a.created_at))
  ORDER BY (date_trunc('week'::text, a.created_at)) DESC;
  
  
SELECT * FROM comments_per_week_v;

SELECT * FROM comments_per_week_mat;
REFRESH MATERIALIZED VIEW comments_per_week_mat;


WITH posts_week_2024 AS (
 SELECT date_trunc('week'::text, a.created_at) AS weeks,
    sum(b.counter) AS total_claps,
    count(DISTINCT a.post_id) AS number_of_posts,
    count(*) AS number_of_claps
   FROM (posts a
     JOIN claps b ON ((a.post_id = b.post_id)))
  GROUP BY (date_trunc('week'::text, a.created_at))
  ORDER BY (date_trunc('week'::text, a.created_at)) DESC
)

SELECT
  *
FROM
  posts_week_2024
WHERE
  weeks BETWEEN '2024-01-01' AND '2024-12-31' AND total_claps >600;


WITH claps_per_posts AS(
	SELECT post_id, sum(counter) FROM claps
	GROUP BY post_id
), posts_from_2023 AS (
	SELECT * FROM posts 
	WHERE created_at BETWEEN '2023-01-01' AND '2023-12-31'
)
SELECT * FROM claps_per_posts
WHERE claps_per_posts.post_id in (SELECT post_id FROM posts_from_2023);


-- nombre de la tabla en memoria
-- campos que vamos a tener
WITH RECURSIVE countdown(val) AS (
	--initialization => el primer nivel, o valores iniciales
	-- 	VALUES(5)
	select 5 as val
	UNION ALL
	-- Query recursivo
	SELECT val - 1 FROM countdown WHERE val > 1
)
-- Select de los campos
SELECT * FROM countdown;