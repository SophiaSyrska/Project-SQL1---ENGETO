SELECT DISTINCT
    a.`year` ,
    ROUND((a.avg_food_value - b.avg_food_value) / b.avg_food_value* 100, 2) AS avg_food_variace_percentage,
   	ROUND((a.avg_salary - b.avg_salary) / b.avg_salary * 100, 2) AS avg_salary_variace_percentage,
    ROUND(((a.avg_food_value - b.avg_food_value) / b.avg_food_value * 100) - ((a.avg_salary - b.avg_salary) / b.avg_salary * 100), 2) AS difference
FROM (
    SELECT 
        YEAR,
        AVG(avg_price_value) AS avg_food_value,
        AVG(avg_salary) AS avg_salary
    FROM t_sophia_syrska_project_sql_primary_final tsspspf 
    GROUP BY YEAR
	 ) AS a
 JOIN (
    SELECT 
        YEAR,
        AVG(avg_price_value) AS avg_food_value,
        AVG(avg_salary) AS avg_salary
    FROM t_sophia_syrska_project_sql_primary_final tsspspf 
    GROUP BY YEAR
	) AS b 
 ON a.`year` = b.`year` + 1
 AND a.`year` < 2019
ORDER BY difference DESC;





