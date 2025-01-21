SELECT *
FROM layoffs_staging2;

SELECT company, industry, SUM(funds_raised_millions)
FROM layoffs_staging2
GROUP BY company, industry
ORDER BY 3 DESC; 

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

SELECT SUBSTRING(`date`, 1, 7) AS `month`, SUM(funds_raised_millions)
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1, 7)
GROUP BY `month`
ORDER BY 1 ASC;

WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`, 1, 7) AS `month`, SUM(funds_raised_millions) AS total_funds_raised
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1, 7)
GROUP BY `month`
ORDER BY 1 ASC
)
SELECT `month`, total_funds_raised,
SUM(total_funds_raised) OVER(ORDER BY `month`) AS rolling_total
FROM rolling_total;

SELECT company, YEAR(`date`), SUM(funds_raised_millions)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

WITH Company_Refunds_Year (company, years, funds_raised_millions) AS
(
SELECT company, YEAR(`date`), SUM(funds_raised_millions)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
), Company_Refunds_Year_RANK AS
(
SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY funds_raised_millions DESC) AS ranking
FROM Company_Refunds_Year
WHERE years IS NOT NULL
)
SELECT *
FROM Company_Refunds_Year_RANK
WHERE ranking <= 3;
-- Company TOP 3 Rank ↑

-- Industry TOP 3 Rank ↓
WITH Industry_Refunds_Year (industry, years, funds_raised_millions) AS
(
SELECT industry, YEAR(`date`), SUM(funds_raised_millions)
FROM layoffs_staging2
GROUP BY industry, YEAR(`date`)
), Industry_Refunds_Year_RANK AS
(
SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY funds_raised_millions DESC) AS ranking
FROM Industry_Refunds_Year
WHERE years IS NOT NULL
)
SELECT *
FROM Industry_Refunds_Year_RANK
WHERE ranking <= 3;