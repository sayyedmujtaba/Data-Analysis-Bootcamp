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

-- now if we want to fdo explorartory data analysis
-- we will to convert the date column from text datatype to actual date datatype
-- so for that we will use the following method

select `date`,
str_to_date(`date`, '%m/%d/%Y') -- this is the best format for date
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');
-- lets check dates now
select `date`
from layoffs_staging2;

-- you will see that the date is still in text data type so for that
alter table layoffs_staging2
modify column `date` date;
-- now the data is in date datatype

-- stage 2 completed

-- stage 3
-- lets work with null and blank data
-- lets take a look at null industries
select *
from layoffs_staging2
where industry is null
or industry = ''
;

-- we have 3 blank while 1 null
-- first of all lets convert blank data to null, so we will easily populate the null area then

update layoffs_staging2
set industry = null
where industry = ''
;

-- so if we check for null or blank industries now we will get all the industries nul
-- lets update null industries one by one


-- lets check for Airbnb
select *
from layoffs_staging2
where company='Airbnb'
;

select t1.industry, t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

update layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null
and t2.industry is not null;

-- now lets check again if there is another null in industry
select *
from layoffs_staging2
where industry is null
or industry = ''
;
-- so bally is still null, lets find similar company to bally
select *
from layoffs_staging2
where company like 'Bally%';
-- we can see that bally has no other row

-- stage 3 completed

-- stage 4: rmoving unneccessary columns

select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

-- as in the data we are going to work with total_laid_off and percentage_laid-off,
-- so we will remove all the rows where data from these two columns is missing

delete 
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;
-- the delete is use to ionly remove data from rows not the entire column
select *
from layoffs_staging2;

-- now the row_num is an extra column we created amd we will not use it ahead
-- so let delete that also
alter table layoffs_staging2
drop column row_num;