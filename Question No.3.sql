
WITH price_growth AS (
	SELECT DISTINCT 
		tsspspf.price_category_name AS category_name, 
		tsspspf.category_code AS category_code, 
		ROUND((tsspspf.avg_price_value - tsspspf2.avg_price_value) / tsspspf2.avg_price_value * 100, 2) AS price_growth_percent,
		tsspspf.`year`, 
		tsspspf.avg_price_value AS price,
		tsspspf2.`year`AS previous_year,
		tsspspf2.avg_price_value AS price_previous_year
	FROM t_sophia_syrska_project_sql_primary_final tsspspf
	JOIN t_sophia_syrska_project_sql_primary_final tsspspf2
		ON tsspspf.category_code  = tsspspf2.category_code
		AND tsspspf.`year` = tsspspf2.`year` + 1
	GROUP BY category_code, category_name, tsspspf.`year`, price,tsspspf2.`year`,price_previous_year
	ORDER BY tsspspf.category_code , tsspspf.`year` DESC
)
SELECT
	category_name,
	category_code,
	ROUND(AVG(price_growth_percent), 2) AS avg_growth
FROM price_growth
GROUP BY category_code,category_name
ORDER BY avg_growth
LIMIT 10;





