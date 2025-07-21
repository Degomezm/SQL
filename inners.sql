SELECT code, name FROM continent where code in (3, 5)
UNION
SELECT code, name FROM continent where "name" LIKE '%America%'
ORDER BY "name" ASC;

SELECT
  a."name" as country,
  b."name" as continent
FROM
  country a,
  continent b
WHERE
  a.continent = b.code
ORDER BY
  a."name" ASC;

SELECT
  a.name as country,
  b.name as continent
from
  country a
  INNER JOIN continent b on a.continent = b.code
ORDER BY
  a.name ASC;
 
 ALTER SEQUENCE continent_code_seq RESTART with 8; 
 

SELECT
  a.name as country,
  a.continent as continentCode,
  b.name as continentName
FROM
  country a
  FULL OUTER JOIN continent b on a.continent = b.code
 ORDER BY 
 	b."name", a.name ASC;
 	
 SELECT
  a.name as country,
  b.name as continentName
FROM
  country a
  RIGHT JOIN continent b on a.continent = b.code
WHERE
  a.continent IS NULL;
  
(SELECT
  COUNT(*) as total,
  b."name"
FROM
  country a
  INNER JOIN continent b on a.continent = b.code
GROUP BY
  b.name)
UNION
(SELECT
  0 as total,
  b."name"
FROM
  country a
  RIGHT JOIN continent b on a.continent = b.code
WHERE
  a.continent IS NULL
GROUP BY
  b.name
)
ORDER BY name asc;
  
-- ORDER BY
--   b.name,
--   COUNT(*) ASC;


(SELECT
  COUNT(*) as Total,
  b.name as Continent
from
  country a
  INNER JOIN continent b ON a.continent = b.code
WHERE b.name NOT LIKE '%America'
GROUP BY b.name)
UNION
(SELECT
  COUNT(*) as Total,
 'America' as Continent
from
  country a
  INNER JOIN continent b ON a.continent = b.code
WHERE b.name LIKE '%America')
ORDER by total asc;

SELECT
  COUNT(*) as total,
  b.name as country
FROM
  city a
  INNER JOIN country b on a.countrycode = b.code
GROUP BY
  b.name
ORDER BY
	count(*) DESC
LIMIT 1;

SELECT
  "language"."name" as "language",
  continent."name" as continent
FROM
  countrylanguage countrylanguage
INNER JOIN country country on countrylanguage.countrycode = country.code
INNER JOIN continent continent on country.continent = continent.code
INNER JOIN "language" "language" on countrylanguage.languagecode = "language".code
WHERE
  countrylanguage.isofficial = TRUE;
  
SELECT
  COUNT(*),
  continent
FROM
  (
    SELECT
      "language"."name" as "language",
      continent."name" as continent
    FROM
      countrylanguage countrylanguage
      INNER JOIN country country on countrylanguage.countrycode = country.code
      INNER JOIN continent continent on country.continent = continent.code
      INNER JOIN "language" "language" on countrylanguage.languagecode = "language".code
    WHERE
      countrylanguage.isofficial = TRUE
  ) as totales
GROUP BY
  continent
ORDER BY
  COUNT(*) DESC;