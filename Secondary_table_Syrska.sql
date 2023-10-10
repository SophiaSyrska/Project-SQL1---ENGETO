	SELECT 
		c.country,
		c.region_in_world,
		c.capital_city,
		e.`year`,
		e.population,
		ROUND(e.gdp, 2) AS GDP,
		e.gini AS `Gini_index` 
	FROM countries c 
	JOIN economies e 
		ON c.country = e.country 
	WHERE continent = 'Europe' 
		AND `year` BETWEEN 2006 AND 2018
	ORDER BY country, `year`;



	
	