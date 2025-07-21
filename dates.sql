SELECT 
	now(),
	CURRENT_DATE,
	CURRENT_TIME,
	date_part('hours', now()) as hours,
	date_part('minutes', now()) as minutes,
	date_part('seconds', now()) as seconds,
	date_part('days', now()) as days,
	date_part('months', now()) as months,
	date_part('years', now()) as years;
	

SELECT * FROM employees
WHERE hire_date > '1998-02-05'
ORDER by hire_date desc;

SELECT MAX(hire_date) as mas_nuevo
FROM employees;

SELECT * FROM employees
WHERE hire_date BETWEEN '1999-01-01' AND '2000-01-01'
ORDER by hire_date desc;

SELECT 
	MAX(hire_date),
	MAX(hire_date) + INTERVAL '1 day' as days,
	MAX(hire_date) + INTERVAL '1 month' as months,
	MAX(hire_date) + INTERVAL '1 year' as years,
	MAX(hire_date) + INTERVAL '1 years' + INTERVAL'11 months' as years_months,
	date_part('year', now())
FROM employees;


SELECT
	hire_date,
	make_interval(years := 2023 - EXTRACT( years FROM hire_date)::INTEGER) as manual,
	make_interval(years := date_part('years', CURRENT_DATE)::INTEGER - EXTRACT(years from hire_date)::INTEGER) as computed
FROM employees
ORDER BY hire_date desc;

UPDATE employees
SET hire_date = hire_date + INTERVAL '23 years';


SELECT
  first_name,
  last_name,
  hire_date,
  CASE
  	WHEN hire_date > now() - INTERVAL '3 year' THEN '3 años o menos'
  	WHEN hire_date > now() - INTERVAL '5 year' THEN '3 a 5 años'
  	WHEN hire_date > now() - INTERVAL '8 year' THEN '5 a 8 años'
  	ELSE '+ de 8 años'
  END as rango_antiguedad
  
FROM
  employees
ORDER BY hire_date DESC;