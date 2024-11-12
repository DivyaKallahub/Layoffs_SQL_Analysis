-- DATA CLEANING --------------------------------


SELECT 
    *
FROM
    layoffs;
    
-- 1. Remove Duplicates
-- 2. Standardized the data
-- 3. Null values or blank Values
-- 4. remove Any Columns if unnecessary 

CREATE TABLE layoffs_clean LIKE layoffs;

SELECT 
    *
FROM
    layoffs_clean;
    
insert layoffs_clean
Select * from layoffs;

-- 1. Remove Duplicates
WITH duplicate_CTE AS (
select *,
row_number() Over(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, 
funds_raised_millions) as row_num
from layoffs_clean
)
 select *  from 
 duplicate_CTE
where row_num > 1;


-- DELETE DUPLICATES -----------

CREATE TABLE `layoffs_clean2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into layoffs_clean2
select *,
row_number() Over(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, 
funds_raised_millions) as row_num
from layoffs_clean;

SELECT 
    *
FROM
    layoffs_clean2;
    
    select * from 
    layoffs_clean2
    where row_num >1;
    
DELETE FROM layoffs_clean2 
WHERE
    row_num > 1;

-- 2. Standardized the data
-- i found that coamny column having space isuuse
SELECT DISTINCT
    company
FROM
    layoffs_clean2;

-- Removing spaces

UPDATE layoffs_clean2
SET company = TRIM(company);
 
SELECT DISTINCT
    industry
FROM
    layoffs_clean2;
    
select * from 
layoffs_clean2
where industry LIKE 'Crypto%';

SELECT DISTINCT
    country
FROM
    layoffs_clean2
ORDER BY 1;

SELECT DISTINCT
    country, TRIM(TRAILING '.' FROM country)
FROM
    layoffs_clean2
ORDER BY 1;



UPDATE layoffs_clean2
SET industry = 'Crypto'
where industry LIKE 'Crypto%';

select date,
STR_TO_DATE(date, '%m/%d/%Y')
from layoffs_clean2;

update layoffs_clean2
SET date = STR_TO_DATE(date, '%m/%d/%Y');

ALTER TABLE layoffs_clean2
MODIFY date date;
-- -------------------------------------------------------------------------

-- 3. Null values or blank Values

select *
from layoffs_clean2;

select *
from layoffs_clean2
where industry IS NULL 
OR industry = '';

select *
from layoffs_clean2
where company = 'Airbnb';

select *
from layoffs_clean2
where company = 'Juul';

select *
from layoffs_clean2
where company = 'Carvana';

update layoffs_clean2
SET industry = NULL
where industry = '';

SELECT 
    t1.industry, t2.industry
FROM
    layoffs_clean2 t1
        JOIN
    layoffs_clean2 t2 ON t1.company = t2.company
WHERE
    t1.industry IS NULL
        AND t2.industry IS NOT NULL;


UPDATE layoffs_clean2 t1
        JOIN
    layoffs_clean2 t2 ON t1.company = t2.company 
SET 
    t1.industry = t2.industry
WHERE
    t1.industry IS NULL 
        AND t2.industry IS NOT NULL;
        
SELECT 
    *
FROM
    layoffs_clean2
WHERE
    total_laid_off IS NULL
        AND percentage_laid_off IS NULL;
        
        

        
DELETE FROM
    layoffs_clean2
WHERE
    total_laid_off IS NULL
        AND percentage_laid_off IS NULL;
        
        
-- 4. remove Any Columns if unnecessary 

ALTER TAble layoffs_clean2
DROP column row_num;
