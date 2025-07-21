ALTER TABLE city
	ADD CONSTRAINT fk_country_code
	FOREIGN KEY (countrycode)
	REFERENCES country( code ); -- ON DELETE CASCADE
	
ALTER TABLE countrylanguage
	ADD CONSTRAINT fk_country_code
	FOREIGN KEY (countrycode)
	REFERENCES country( code );
	
	
SELECT * from country where code = 'NAM';

SELECT * from city where countrycode = 'NAM';

INSERT INTO
  country
values
  (
    'AFG',
    'Afghanistan',
    'Asia',
    'Southern Asia',
    652860,
    1919,
    40000000,
    62,
    69000000,
    NULL,
    'Afghanistan',
    'Totalitarian',
    NULL,
    NULL,
    'AF'
  );
		
insert into
  country
values
  (
    'NAM',
    'Namibia',
    'Africa',
    'Africa Austral',
    825625,
    1990,
    2606971,
    65.1,
    12800000.00,
    13300000.00,
    'Namibia',
    'Presidencialist Republic',
    'Hage Geingob',
    2,
    'NA'
  );