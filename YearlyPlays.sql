---Yearly Plays---
SELECT
    Artist, Title, DATEPART(YEAR, Date) AS Year, SUM(1) AS YearlyPlays
FROM ScrobblerProject.dbo.ScrobblesUpdated
WHERE ARTIST IS NOT NULL
GROUP BY Artist, Title, DATEPART(YEAR, Date)
ORDER BY Year ASC, YearlyPlays DESC

