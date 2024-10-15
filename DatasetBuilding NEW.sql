
--- Define parameters for date ranges (3.5 years) ---
DECLARE @StartDate DATE = '2020-04-12';
DECLARE @EndDate DATE = '2024-04-12';

--- Create a temporary table for filtered scrobbles ---
CREATE TABLE #TempFilteredScrobbles (
    Artist VARCHAR(255),
    Album VARCHAR(255),
    Title VARCHAR(255),
    Date DATE
);

--- Insert data into the filtered temp table ---
INSERT INTO #TempFilteredScrobbles (Artist, Album, Title, Date)
SELECT Artist, Album, Title, Date
FROM ScrobblerProject.dbo.ScrobblesUpdated
WHERE Date BETWEEN @StartDate AND @EndDate
AND Title IS NOT NULL;

/*Play (aka Scrobble) Counts*/

---Total Plays for Each Album---
SELECT Artist, Album, COUNT(Album) AS AlbumPlays
FROM #TempFilteredScrobbles
GROUP BY Artist, Album
ORDER BY AlbumPlays DESC;

---Total Plays for Each Song---
SELECT Artist, Title, COUNT(Title) AS SongPlays
FROM #TempFilteredScrobbles
GROUP BY Artist, Title
ORDER BY SongPlays DESC;

---Total Plays for Each Artist---
SELECT Artist, COUNT(Artist) AS ArtistPlays
FROM #TempFilteredScrobbles
GROUP BY Artist
ORDER BY ArtistPlays DESC;

---Total Plays on Song by Season---
SELECT Artist, Title, ISNULL(Season, 'Unknown') AS Season, COUNT(Title) AS SeasonPlayCount
FROM (
    SELECT Artist, Title, 
           CASE
		WHEN Date BETWEEN '2020-03-19' AND '2020-06-20' THEN 'Spring'
		WHEN Date BETWEEN '2020-06-21' AND '2020-09-21' THEN 'Summer'
		WHEN Date BETWEEN '2020-09-22' AND '2020-12-21' THEN 'Fall'
		WHEN Date BETWEEN '2020-12-22' AND '2021-03-20' THEN 'Winter'
		WHEN Date BETWEEN '2021-03-21' AND '2021-06-20' THEN 'Spring'
		WHEN Date BETWEEN '2021-06-21' AND '2021-09-22' THEN 'Summer'
		WHEN Date BETWEEN '2021-09-23' AND '2021-12-21' THEN 'Fall'
		WHEN Date BETWEEN '2021-12-22' AND '2022-03-20' THEN 'Winter'
		WHEN Date BETWEEN '2022-03-21' AND '2022-06-21' THEN 'Spring'
		WHEN Date BETWEEN '2022-06-22' AND '2022-09-22' THEN 'Summer'
		WHEN Date BETWEEN '2022-09-23' AND '2022-12-21' THEN 'Fall'
		WHEN Date BETWEEN '2022-12-22' AND '2023-03-20' THEN 'Winter'
		WHEN Date BETWEEN '2023-03-21' AND '2023-06-21' THEN 'Spring'
		WHEN Date BETWEEN '2023-06-22' AND '2023-09-23' THEN 'Summer'
		WHEN Date BETWEEN '2023-09-24' AND '2023-12-21' THEN 'Fall'
		WHEN Date BETWEEN '2023-12-22' AND '2024-03-19' THEN 'Winter'
		WHEN Date BETWEEN '2024-03-20' AND '2024-06-20' THEN 'Spring'
		WHEN Date BETWEEN '2024-06-21' AND '2024-09-22' THEN 'Summer'
		WHEN Date BETWEEN '2024-09-23' AND '2024-12-21' THEN 'Winter'
		ELSE 'Unknown'
           END AS Season,
           YEAR(Date) AS Year
    FROM #TempFilteredScrobbles
) AS SeasonalScrobbles
GROUP BY Artist, Title, Season
ORDER BY SeasonPlayCount DESC;


---Clean Temp Table---
DROP TABLE #TempFilteredScrobbles;
