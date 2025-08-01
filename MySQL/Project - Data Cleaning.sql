-- imprtant steps in DATA CLEANING
-- 1. Remove duplicates
-- 2. standardized the data
-- 3. Find null and blank values
-- 4. remove any columns (as working on raw data is not the best practice so in advance we have to create a copy table (staging)) 


select *
from layoffs;

-- create a copy table
create table layoffs_staging like layoffs;
-- this wll creat a table as layoff but empty

-- now we will imprt the data of layoff via
insert layoffs_staging
select *
from layoffs;

-- now lets check layoffs_staging data
select *
from layoffs_staging;

-- now we will get the number of each row occures 
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

-- create a CTE to find out whether a row is repeated or not
with duplicate_cte as
(
	SELECT *,
	ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
	FROM layoffs_staging
)
select *
from duplicate_cte
where row_num >1;


-- now lets confirm for a specific company that wheter it is duplicate or not
select *
from layoffs_staging
where company = 'Oda'
;
-- so ODA is nearly duplicate except the fund raised
-- lets confirm for Casper
select *
from layoffs_staging
where company = 'Casper'
;
-- the first and third row is a duplicate












