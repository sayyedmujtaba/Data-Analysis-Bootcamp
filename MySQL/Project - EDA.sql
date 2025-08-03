-- Exploratory Data Analysis

-- in explorary data analysis most of the time we will know what we are doing
-- sometime EDA and data cleaning take place together
-- as we had already cleaned the data lets start the EDA

-- in EDA we have to look at a column for most relevency
-- if the column isnt relevent we have to ignore that

select *
from layoffs_staging2;

select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging2;

-- we can also filter companies by the laid off percentage
select *
from layoffs_staging2
where percentage_laid_off > 0.95
order by percentage_laid_off asc;

-- if we want company like Google
select *
from layoffs_staging2
where company like 'Goo%';

select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by sum(total_laid_off) desc;

select industry, sum(total_laid_off)
from layoffs_staging2
group by industry
order by sum(total_laid_off) desc;

-- layoffs i a specific countrty
select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by sum(total_laid_off) desc;

-- order via date
select `date`, sum(total_laid_off)
from layoffs_staging2
group by `date`
order by 1 desc;

-- find laid off in a specific year
select year(`date`), sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 1 desc;

-- now lets find out layoffs per each month
select substring(`date`, 1, 7) as `month`, sum(total_laid_off) 
from layoffs_staging2
where substring(`date`, 1, 7) is not null
group by `month`
order by 1
;

-- lets dinf rolling sum per each month
with Rolling_Total as
(
-- now lets find out layoffs per each month
select substring(`date`, 1, 7) as `month`, sum(total_laid_off) as fired
from layoffs_staging2
where substring(`date`, 1, 7) is not null
group by `month`
order by 1
)
select `month`, fired, sum(fired) over(order by `month`) as rolling_total
from Rolling_Total;

select country, sum(total_laid_off), sum(funds_raised_millions)
from layoffs_staging2
group by country
order by country ;

select substring(`date`, 1, 4) as YearNo, sum(total_laid_off), sum(funds_raised_millions)
from layoffs_staging2
group by YearNo
order by YearNo ;

select *
from layoffs_staging2;