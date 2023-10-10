CREATE OR REPLACE TABLE t_Sophia_Syrska_project_SQL_primary_final AS
SELECT 
	cpc.name AS price_category_name,
	a.price_category_code AS category_code,
	cpib.name AS economic_sector,
	b.industry_branch_code AS code,
	a.price_year AS `year`,
	a.avg_price_value,
	cpc.price_unit AS measurement_unit,
	b.avg_salary 	
FROM 
(
	SELECT
	cp.category_code AS price_category_code,
	year(cp.date_from) AS price_year,
	ROUND(AVG(cp.value),2) AS avg_price_value
	FROM czechia_price cp 
	WHERE region_code IS NULL 
	GROUP BY price_category_code,price_year
) a
JOIN czechia_price_category cpc 
	ON a.price_category_code = cpc.code 
JOIN 
(
	SELECT
	cp2.payroll_year, 
	cp2.industry_branch_code, 
	ROUND(AVG(cp2.value),2)AS avg_salary
	FROM czechia_payroll cp2 
	WHERE industry_branch_code IS NOT NULL 
		AND value_type_code = 5958
		AND calculation_code = 200
	GROUP BY payroll_year,industry_branch_code
) b
	ON a.price_year = b.payroll_year
JOIN czechia_payroll_industry_branch cpib 
	ON industry_branch_code = cpib.code
ORDER BY price_category_name,`year`, economic_sector;


	

















SELECT 
	t1.category_code AS category_code,
	cpc.name AS food_category,
	t1.food_year AS year,
	t1.avg_value_food AS avg_value_food,
	cpc.price_unit AS food_price_unit,
	t2.industry_brach_code AS code,
	cpib.name AS industry_name,
	t2.year_payroll_value AS payroll_value	
FROM( 
	SELECT 
      cp.category_code AS category_code,
      YEAR(cp.date_to) AS food_year,
      ROUND(AVG (cp.value)) AS avg_value_food
      FROM czechia_price cp 
      WHERE region_code IS NULL 
      GROUP BY food_year, category_code
    ) t1
JOIN czechia_price_category cpc 
	ON t1.category_code = cpc.code 
JOIN 
    (
        SELECT
		cp2.payroll_year,
		cp2.industry_branch_code AS industry_brach_code,
		ROUND (AVG (cp2.value))AS year_payroll_value
		FROM czechia_payroll cp2  
		WHERE industry_branch_code IS NOT NULL
		AND value_type_code = 5958
		AND calculation_code = 200 
		GROUP BY payroll_year, industry_branch_code
    ) t2
	ON t1.food_year = t2.payroll_year
JOIN czechia_payroll_industry_branch cpib 
	ON t2.industry_brach_code = cpib.code;


SELECT *
FROM czechia_payroll cp 

select	
ROUND(AVG(cp2.value),2)AS avg_salary
	FROM czechia_payroll cp2 
	
	
	
	
	SELECT
	a.code_food,
    a.category_food,
    a.average_price,
    a.price_value,
    a.price_unit,
    b.average_payroll,
    b.payroll_year AS 'year',
	b.industry_branch_code,
	b.name AS industry_branch_name
FROM
(SELECT
    cp.category_code AS code_food,
    cpc.name AS category_food,
    ROUND(AVG(value),2) AS average_price,
    cpc.price_value,
    cpc.price_unit,
    YEAR(cp.date_to) AS year_food
FROM czechia_price cp
LEFT JOIN czechia_price_category cpc 
	ON cp.category_code = cpc.code 
WHERE region_code IS NULL
GROUP BY cp.category_code, YEAR(cp.date_to),cpc.price_unit, cpc.price_value
) a
JOIN (SELECT 
	ROUND(AVG(cp2.value),2) AS average_payroll,
	cp2.payroll_year,
	cp2.industry_branch_code,
	cpib.name
FROM czechia_payroll cp2
LEFT JOIN czechia_payroll_industry_branch cpib 
	ON cp2.industry_branch_code = cpib.code 
	WHERE cp2.value_type_code = 5958
	AND cp2.calculation_code = 100
	AND cp2.industry_branch_code IS NOT NULL
GROUP BY cp2.payroll_year, cp2.industry_branch_code, cpib.name) b
	ON a.year_food = b.payroll_year
ORDER BY year