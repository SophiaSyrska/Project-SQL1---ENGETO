SELECT
    economic_sector,
    AVG(CASE WHEN year = 2006 THEN avg_salary  END) AS avg_salary_2006,
    AVG(CASE WHEN year = 2018 THEN avg_salary END) AS avg_salary_2018,
    ROUND(((AVG(CASE WHEN year = 2018 THEN avg_salary END) - AVG(CASE WHEN year = 2006 THEN avg_salary END)) / AVG(CASE WHEN year = 2006 THEN avg_salary END)) * 100, 2) AS salary_variance_percentage,
    CASE
        WHEN AVG(avg_salary) > AVG(CASE WHEN year = 2006 THEN avg_salary END) THEN 'upward'
        WHEN AVG(avg_salary) < AVG(CASE WHEN year = 2006 THEN avg_salary END) THEN 'downward'
        ELSE 'invariable'
    END AS tendency
FROM
     t_sophia_syrska_project_sql_primary_final tsspspf 
WHERE
    `year`BETWEEN 2006 AND 2018
GROUP BY 
    economic_sector;
    
 
 WITH salary_fluctuation AS (
	SELECT
   		economic_sector,
   		`year`,
    	ROUND(AVG(avg_salary), 0) AS avg_avg_salary,    
    	ROUND(AVG(avg_salary) / LAG(ROUND(AVG(avg_salary), 0)) OVER (PARTITION BY economic_sector ORDER BY economic_sector, `year`) * 100 - 100, 2) AS salary_variance_percentage
		FROM t_sophia_syrska_project_sql_primary_final tsspspf
		WHERE YEAR BETWEEN 2006 AND 2018
		GROUP BY economic_sector, `year`
)
SELECT
    economic_sector,
   `year`,
    avg_avg_salary,
    salary_variance_percentage
 FROM
    salary_fluctuation
WHERE
     salary_variance_percentage IS NOT NULL
ORDER BY
  salary_variance_percentage, `year`
  ;




   
   