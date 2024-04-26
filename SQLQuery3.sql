-- Correct Date and Time Formats
ALTER TABLE ScrobblerProject.dbo.ScrobblesUpdated
ALTER COLUMN DATE DATE;

ALTER TABLE ScrobblerProject.dbo.ScrobblesUpdated
ALTER COLUMN TIME TIME;

-- Create a Temporary Table for Corrected Data
SELECT Artist, Album, Title, DATE, TIME
INTO #TempCorrectedData
FROM ScrobblerProject.dbo.ScrobblesUpdated;

-- Create Tables for Song Plays by Time of Day (UTC to EST Conversion) - 
-- Each Time Of Day (i.e. Morning, Afternoon, etc.) is commented/uncommented when used
WITH TimeOfDayClass AS (
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

/* -- Morning (6am to 12pm)
SELECT Artist, Title, TimeOfDay, COUNT(*) AS TotalTimeSongPlays
INTO #MorningPlays
FROM TimeOfDayClass
WHERE TimeOfDay = 'Morning'
GROUP BY Artist, Title, TimeOfDay; */

/* -- Afternoon (12pm to 6pm) 
SELECT Artist, Title, TimeOfDay, COUNT(*) AS TotalTimeSongPlays
INTO #AfternoonPlays
FROM TimeOfDayClass
WHERE TimeOfDay = 'Afternoon'
GROUP BY Artist, Title, TimeOfDay; */

/* -- Night (6pm to 12am) 
SELECT Artist, Title, TimeOfDay, COUNT(*) AS TotalTimeSongPlays
INTO #NightPlays
FROM TimeOfDayClass
WHERE TimeOfDay = 'Night'
GROUP BY Artist, Title, TimeOfDay; */

/* -- Late Night/Early Morning (12am to 6am) 
SELECT Artist, Title, TimeOfDay, COUNT(*) AS TotalTimeSongPlays
INTO #LateNightPlays
FROM TimeOfDayClass
WHERE TimeOfDay = 'Late Night/Early Morning'
GROUP BY Artist, Title, TimeOfDay; */

-- Preview Data for Each Time of Day
SELECT * FROM #MorningPlays
ORDER BY TotalTimeSongPlays DESC;

SELECT * FROM #AfternoonPlays
ORDER BY TotalTimeSongPlays DESC;

SELECT * FROM #NightPlays
ORDER BY TotalTimeSongPlays DESC;

SELECT * FROM #LateNightPlays
ORDER BY TotalTimeSongPlays DESC;

-- Creating a new table for Time of Day plays  
CREATE TABLE ScrobblerProject.dbo.DayPlays (
    Artist NVARCHAR(255),
    Title NVARCHAR(255),
    TimeOfDay NVARCHAR(255),
    TotalTimeSongPlays INT
);

-- Merging each Time of Day into One Table
INSERT INTO ScrobblerProject.dbo.DayPlays (Artist, Title, TimeOfDay, TotalTimeSongPlays)
SELECT Artist, Title, TimeOfDay, TotalTimeSongPlays
FROM #MorningPlays
UNION ALL
SELECT Artist, Title, TimeOfDay, TotalTimeSongPlays
FROM #AfternoonPlays
UNION ALL
SELECT Artist, Title, TimeOfDay, TotalTimeSongPlays
FROM #NightPlays
UNION ALL
SELECT Artist, Title, TimeOfDay, TotalTimeSongPlays
FROM #LateNightPlays;


SELECT * FROM dbo.FullDayPlays
	ORDER BY TimeOfDay, TotalTimeSongPlays desc;

-- Clean up temporary tables
DROP TABLE #TempCorrectedData;
DROP TABLE #MorningPlays;
DROP TABLE #AfternoonPlays;
DROP TABLE #NightPlays;
DROP TABLE #LateNightPlays;