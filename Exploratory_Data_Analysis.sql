-- Here we are jsut going to explore the data and find trends or patterns or anything interesting like outliers

-- normally when you start the EDA process you have some idea of what you're looking for

-- with this info we are just going to look around and see what we find!

SELECT 
    *
FROM
    layoffs_clean2;
    
-- 1. Findout Max total_laidz-off and max pecentage_laid_off

SELECT 
    MAX(total_laid_off) AS max_laidoff
FROM
    layoffs_clean2;
    
-- 2. Looking at Percentage to see how big these layoffs were

SELECT 
    MAX(percentage_laid_off), MIN(percentage_laid_off)
FROM
    layoffs_clean2;
    
-- 3. Which companies had 1 which is basically 100 percent of they company laid off

SELECT 
    *
FROM
    layoffs_clean2
WHERE
    percentage_laid_off = 1;

-- 4. if we order by funcs_raised_millions we can see how big some of these companies were

SELECT 
    *
FROM
    layoffs_clean2
WHERE
    percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- 5. Companies with the biggest single day Layoff

SELECT 
    company, total_laid_off
FROM
    layoffs_clean2
ORDER BY total_laid_off DESC
LIMIT 5;

-- 6.  Companies with the most Total Layoffs

SELECT 
    company, SUM(total_laid_off) AS total_layoffs
FROM
    layoffs_clean2
GROUP BY company
ORDER BY total_layoffs DESC
LIMIT 10;

-- 7. the most Total Layoffs BY location

SELECT 
    location, SUM(total_laid_off) AS total_layoffs
FROM
    layoffs_clean2
GROUP BY  location
ORDER BY total_layoffs DESC
LIMIT 10;

-- 8. most total layoffs by country

SELECT 
    country, SUM(total_laid_off) AS total_layoffs
FROM
    layoffs_clean2
GROUP BY  country
ORDER BY total_layoffs DESC;

-- 9. Most total layoffs by industry

SELECT 
    industry, SUM(total_laid_off) AS total_layoffs
FROM
    layoffs_clean2
GROUP BY  industry
ORDER BY total_layoffs DESC;

-- 10. Most total layoffs by stage

SELECT 
    stage, SUM(total_laid_off) AS total_layoffs
FROM
    layoffs_clean2
GROUP BY  stage
ORDER BY total_layoffs DESC;

-- 11. Most total lay off by Year

SELECT 
    YEAR(date), SUM(total_laid_off) AS total_layoffs
FROM
    layoffs_clean2
GROUP BY YEAR(date)
ORDER BY total_layoffs DESC;

-- 12. Earlier we looked at Companies with the most Layoffs. Now let's look at that per year. It's a little more difficult.

SELECT 
    company,
    YEAR(date) AS year,
    SUM(total_laid_off) AS total_liadoff
FROM
    layoffs_clean2
GROUP BY company , YEAR(date)
ORDER BY total_liadoff DESC;

WITH company_year_CTE AS (
SELECT 
    company,
    YEAR(date) AS year,
    SUM(total_laid_off) AS total_laid_off
FROM
    layoffs_clean2
GROUP BY company , YEAR(date)

),
company_year_rank AS (
select *, dense_rank() OVER(partition by year order by total_laid_off DESC) AS Ranking 
from company_year_CTE
where year IS NOT NULL
ORDER BY Ranking ASC
)
select *
from company_year_rank
where Ranking <= 3
AND year IS NOT NULL
ORDER BY year ASC, total_laid_off DESC;


-- 13. Rolling Total of Layoffs Per Month

SELECT 
        DATE_FORMAT(date, '%Y-%m') AS Month,  -- Extract year and month in 'YYYY-MM' format
        SUM(total_laid_off) AS total_layoffs
    FROM 
        layoffs_clean2
	WHERE DATE_FORMAT(date, '%Y-%m') IS NOT NULL
    GROUP BY 
        DATE_FORMAT(date, '%Y-%m');

-- now use it in a CTE so we can query off of it



WITH Rolling_total AS (
    SELECT 
        DATE_FORMAT(date, '%Y-%m') AS Month,  -- Extract year and month in 'YYYY-MM' format
        SUM(total_laid_off) AS total_layoffs
    FROM 
        layoffs_clean2
	WHERE DATE_FORMAT(date, '%Y-%m') IS NOT NULL
    GROUP BY 
        DATE_FORMAT(date, '%Y-%m')
)
SELECT 
    Month, total_layoffs,
    SUM(total_layoffs) OVER (ORDER BY Month ASC) AS rolling_total_layoffs
FROM 
    Rolling_total
ORDER BY 
    Month ASC;


-- 



