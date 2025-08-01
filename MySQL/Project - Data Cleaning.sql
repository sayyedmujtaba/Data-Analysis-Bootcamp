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
	ROW_NUMBER() OVER (
    PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
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
-- to remove the extra rows lets create a new table exactly as the layoffs_stagig but with an additional column row_num

CREATE TABLE `layoffs_staging2` (
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

-- now as the table is created lets INSERT data
insert into layoffs_staging2
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;
-- here all the columns from layoffs_staging are mentioned

-- now lets delete if any rows are apperared more than once
delete
from layoffs_staging2
where row_num>1
;

-- now lets check if the there are still rows apperaed more than once
select *
from layoffs_staging2
where row_num>1
;
-- now we can see that there are no extra rows

-- stage 1 completed

-- stage 2: standardization; finding and fixing issues in data
-- it is best practice if we look at all the columns of a table
select *
from layoffs_staging2;

-- checking for companies
select company, trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

-- -- checking for industries
select distinct industry
from layoffs_staging2
order by 1;

select *
from layoffs_staging2
where industry like 'Crypto%';

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

-- checking for countries
select distinct country
from layoffs_staging2
order by 1;

select distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1;

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';

select *
from layoffs_staging2
order by country;


-- continue from 27:49