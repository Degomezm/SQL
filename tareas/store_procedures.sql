SELECT country_id,
    country_name,
    region_name
FROM countries
    INNER JOIN regions on countries.region_id = regions.region_id;

CREATE OR REPLACE FUNCTION country_region() RETURNS TABLE (
        id CHARACTER(2),
        name VARCHAR(40),
        region VARCHAR(25)
    ) AS $$ BEGIN RETURN query
SELECT country_id,
    country_name,
    region_name
FROM countries
    INNER JOIN regions on countries.region_id = regions.region_id;
END;
$$ LANGUAGE plpgsql;


SELECT *
FROM country_region();

-- Procedimiento almacenado
-- Insertar una nueva region
CREATE OR REPLACE PROCEDURE insert_region_proc(INT, VARCHAR)
AS $$

BEGIN
	INSERT INTO regions(region_id, region_name)
	VALUES( $1, $2);
	
	raise notice 'Variable 1: %, %', $1, $2;
	
	--ROLLBACK;
	COMMIT;
END;

$$
LANGUAGE plpgsql;

CALL insert_region_proc(5, 'Central America');

SELECT * FROM regions;


SELECT max_raise(100);

SELECT max_raise(employee_id), salary, job_id from employees;

SELECT 
	CURRENT_DATE as "date",
	employee_id,
	salary,
	max_raise(employee_id) * 0.05 as amount,
	5 as percentage
FROM employees;


CREATE OR REPLACE PROCEDURE controlled_raise(percentage NUMERIC)
AS $$
DECLARE
	real_percentage NUMERIC(8,2);
	total_employees int;

BEGIN
	real_percentage = percentage / 100; --5% = 0.05;
	
	--Mantener el historico
	INSERT INTO raise_history(date, employee_id, base_salary, amount, percentage)
	SELECT 
		CURRENT_DATE as "date",
		employee_id,
		salary,
		max_raise(employee_id) * real_percentage as amount,
		percentage 
	FROM employees;
		
	-- Impactar la tabla de empleados
	UPDATE employees
		SET salary = (max_raise(employee_id) * real_percentage) + salary;
		
	COMMIT;
	
	SELECT count(*) INTO total_employees FROM employees;
	
	raise notice 'Afectados % empleados' , total_employees;
END;

$$
LANGUAGE plpgsql;

CALL controlled_raise(1);

SELECT * FROM raise_history;