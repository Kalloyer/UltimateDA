-- Relatório de empresas que mais demitiram em cada trimestre
SELECT company,
	EXTRACT(YEAR FROM `date`) AS year,
    CEIL(EXTRACT(MONTH FROM `date`) / 3) AS quarter,
    SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE EXTRACT(YEAR FROM `date`) IS NOT NULL 
GROUP BY company, year, quarter
ORDER BY year, quarter, total_laid_off DESC;