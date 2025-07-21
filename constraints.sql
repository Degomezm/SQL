SELECT *
FROM country
WHERE code = 'CRI';
ALTER TABLE country
ADD PRIMARY KEY (code);
SELECT *
FROM country;
DELETE FROM country
where code = 'NLD'
    and code2 = 'NA';
ALTER TABLE country
add CHECK (surfacearea >= 0);
SELECT DISTINCT(continent)
FROM country;
ALTER TABLE country
ADD CHECK(
        (continent = 'Asia'::text)
        or (continent = 'South America'::text)
        or (continent = 'North America'::text)
        or (continent = 'Oceania'::text)
        or (continent = 'Antarctica'::text)
        or (continent = 'Africa'::text)
        or (continent = 'Europe'::text)
        or (continent = 'Central America'::text)
    );
ALTER TABLE country DROP CONSTRAINT "country_continent_check1";
CREATE TABLE "country" (
    "code" CHAR(3) NOT NULL,
    "name" TEXT NOT NULL,
    "continent" TEXT NOT NULL,
    "region" TEXT NOT NULL,
    "surfacearea" REAL NOT NULL,
    "indepyear" SMALLINT NULL DEFAULT NULL,
    "population" INTEGER NOT NULL,
    "lifeexpectancy" REAL NULL DEFAULT NULL,
    "gnp" NUMERIC(10, 2) NULL DEFAULT NULL,
    "gnpold" NUMERIC(10, 2) NULL DEFAULT NULL,
    "localname" TEXT NOT NULL,
    "governmentform" TEXT NOT NULL,
    "headofstate" TEXT NULL DEFAULT NULL,
    "capital" INTEGER NULL DEFAULT NULL,
    "code2" CHAR(2) NOT NULL,
    PRIMARY KEY ("code"),
    CONSTRAINT "country_surfacearea_check" CHECK (((surfacearea >= (0)::double precision))),
    CONSTRAINT "country_continent_check" CHECK (
        (
            (
                (continent = 'Asia'::text)
                OR (continent = 'South America'::text)
                OR (continent = 'North America'::text)
                OR (continent = 'Oceania'::text)
                OR (continent = 'Antarctica'::text)
                OR (continent = 'Africa'::text)
                OR (continent = 'Europe'::text)
                OR (continent = 'Central America'::text)
            )
        )
    )
);
SELECT conname AS constraint_name,
    contype AS constraint_type,
    pg_get_constraintdef(c.oid) AS definition
FROM pg_constraint c
    JOIN pg_class t ON c.conrelid = t.oid
WHERE t.relname = 'country';