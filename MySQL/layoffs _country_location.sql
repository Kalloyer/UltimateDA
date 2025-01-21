-- Impacto dos layoffs por localização geográfica
SELECT country, location, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY country, location
ORDER BY total_laid_off DESC;