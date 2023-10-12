
--- Define parameters for date ranges (3 years) ---
DECLARE @StartDate DATE = '2020-04-12';
DECLARE @EndDate DATE = '2023-04-12';

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
               WHEN Date BETWEEN '2020-04-12' AND '2020-06-20' THEN 'Spring 2020'
               WHEN Date BETWEEN '2020-06-21' AND '2020-09-22' THEN 'Summer 2020'
               WHEN Date BETWEEN '2020-09-23' AND '2020-12-20' THEN 'Fall 2020'
               WHEN Date BETWEEN '2020-12-21' AND '2021-03-20' THEN 'Winter 2020'
               WHEN Date BETWEEN '2021-03-21' AND '2021-06-20' THEN 'Spring 2021'
               WHEN Date BETWEEN '2021-06-21' AND '2021-09-22' THEN 'Summer 2021'
               WHEN Date BETWEEN '2021-09-23' AND '2021-12-20' THEN 'Fall 2021'
               WHEN Date BETWEEN '2021-12-21' AND '2022-03-20' THEN 'Winter 2021'
               WHEN Date BETWEEN '2022-03-21' AND '2022-06-20' THEN 'Spring 2022'
               WHEN Date BETWEEN '2022-06-21' AND '2022-09-22' THEN 'Summer 2022'
               WHEN Date BETWEEN '2022-09-23' AND '2022-12-20' THEN 'Fall 2022'
               WHEN Date BETWEEN '2022-12-21' AND '2023-03-20' THEN 'Winter 2022'
               WHEN Date BETWEEN '2023-03-21' AND '2023-06-20' THEN 'Spring 2023'
               ELSE 'Unknown'
           END AS Season,
           YEAR(Date) AS Year
    FROM #TempFilteredScrobbles
) AS SeasonalScrobbles
GROUP BY Artist, Title, Season
ORDER BY SeasonPlayCount DESC;


---Clean Temp Table---
DROP TABLE #TempFilteredScrobbles;
