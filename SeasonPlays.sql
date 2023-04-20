---Plays by Season---
SELECT Artist, Title, Season, SUM(SeasonPlayCount) AS TotSznPlys
FROM ScrobblerProject.dbo.SeasonPlays
GROUP BY Artist, Title, Season
ORDER BY TotSznPlys desc

---Yearly Plays---
SELECT Artist, Title, Year, SUM(SeasonPlayCount) AS TotYrPlys
FROM ScrobblerProject.dbo.SeasonPlays
GROUP BY Artist, Title, Year
ORDER BY Year asc, TotYrPlys desc