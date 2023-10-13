--- Correct Date and Time Formats ---
ALTER TABLE ScrobblerProject.dbo.ScrobblesUpdated
ALTER COLUMN DATE DATE;

ALTER TABLE ScrobblerProject.dbo.ScrobblesUpdated
ALTER COLUMN TIME TIME;

--- Create a Temporary Table for Corrected Data ---
SELECT Artist, Album, Title, DATE, TIME
INTO #TempCorrectedData
FROM ScrobblerProject.dbo.ScrobblesUpdated;

--- Create Tables for Song Plays by Time of Day (UTC to EST Conversion) ---
WITH TimeOfDayClassification AS (
    SELECT
        Artist,
        Title,
        CASE
            WHEN DATEADD(HOUR, -5, TIME) BETWEEN '06:00' AND '11:59' THEN 'Morning'
            WHEN DATEADD(HOUR, -5, TIME) BETWEEN '12:00' AND '17:59' THEN 'Afternoon'
            WHEN DATEADD(HOUR, -5, TIME) BETWEEN '18:00' AND '23:59' THEN 'Night'
            WHEN DATEADD(HOUR, -5, TIME) BETWEEN '00:00' AND '05:59' THEN 'Late Night/Early Morning'
        END AS TimeOfDay
    FROM #TempCorrectedData
)

--- Select the Plays for each time period ---
SELECT 'Morning' AS TimeOfDay, Artist, Title, COUNT(*) AS TotalTimeSongPlays
FROM TimeOfDayClassification
WHERE TimeOfDay = 'Morning'
GROUP BY Artist, Title
UNION ALL
SELECT 'Afternoon' AS TimeOfDay, Artist, Title, COUNT(*) AS TotalTimeSongPlays
FROM TimeOfDayClassification
WHERE TimeOfDay = 'Afternoon'
GROUP BY Artist, Title
UNION ALL
SELECT 'Night' AS TimeOfDay, Artist, Title, COUNT(*) AS TotalTimeSongPlays
FROM TimeOfDayClassification
WHERE TimeOfDay = 'Night'
GROUP BY Artist, Title
UNION ALL
SELECT 'Late Night/Early Morning' AS TimeOfDay, Artist, Title, COUNT(*) AS TotalTimeSongPlays
FROM TimeOfDayClassification
WHERE TimeOfDay = 'Late Night/Early Morning'
GROUP BY Artist, Title
ORDER BY TimeOfDay, TotalTimeSongPlays DESC;

--- Clean up temporary tables ---
DROP TABLE #TempCorrectedData;
