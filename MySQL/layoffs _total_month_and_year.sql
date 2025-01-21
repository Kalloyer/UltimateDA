-- Total de layoffs por ano
SELECT EXTRACT(YEAR FROM `date`) AS year, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE EXTRACT(YEAR FROM `date`) IS NOT NULL
GROUP BY EXTRACT(YEAR FROM `date`)
ORDER BY year;

-- Total de layoffs por mês
SELECT SUBSTRING(`date`, 1, 7) AS `month`, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE  SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY  SUBSTRING(`date`, 1, 7)
ORDER BY `month`;

