SELECT 
    e.`year`,
    ROUND(e.GDP / LAG(e.GDP) OVER (ORDER BY e.`year`) * 100 - 100, 2) AS GDP_difference_perc,
    b.salary_variace_percentage,
    b.price_food_variace_percentage
FROM (
    SELECT 
        `year`,
        country,
        GDP
    FROM t_sophia_syrska_project_sql_secondary_final tsspssf 
    WHERE country = 'Czech Republic'
    GROUP BY YEAR, country, GDP
	) AS e
JOIN (
    SELECT 
        `year`, 
        ROUND(avg_salary / LAG(avg_salary) OVER (ORDER BY `year`) * 100 - 100, 2) AS salary_variace_percentage,
        ROUND(avg_food_value / LAG(avg_food_value ) OVER (ORDER BY `year`) * 100 - 100, 2) AS price_food_variace_percentage
    FROM (
        SELECT 
            `year`,
            AVG(avg_price_value) AS avg_food_value,
            AVG(avg_salary) AS avg_salary
        FROM t_sophia_syrska_project_sql_primary_final tsspspf 
        GROUP BY `year`
    ) AS a
) AS b ON e.`year` = b.`year`
WHERE
    e.`year` BETWEEN 2006 AND 2018
    AND e.country = 'Czech Republic'
    ORDER BY e.`year` DESC;
   
   

   
  