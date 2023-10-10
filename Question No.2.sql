SELECT
	price_category_name,
	ROUND(AVG(avg_salary) / AVG(avg_price_value), 2) AS avg_amount,
	measurement_unit,
	`year` 
FROM t_sophia_syrska_project_sql_primary_final tsspspf 
WHERE `year`  IN('2006', '2018')
		AND category_code  IN (111301, 114201)
GROUP BY price_category_name, measurement_unit, `year`
ORDER BY price_category_name;