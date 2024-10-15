--- Define parameters for date ranges (3.5 years) ---
DECLARE @StartDate DATE = '2020-04-12';
DECLARE @EndDate DATE = '2024-10-12';  -- Updated End Date

--- Create a temporary table for filtered scrobbles with a unique identifier ---
CREATE TABLE #TempFilteredScrobbles (
    UniqueID VARCHAR(1000),  -- Increased size to 1000 characters to handle longer concatenated strings
    Artist VARCHAR(255),
    Album VARCHAR(255),
    Title VARCHAR(255),
    Date DATE,
    Time TIME
);

--- Insert data into the filtered temp table, combining Artist, Album, and Title as UniqueID ---
INSERT INTO #TempFilteredScrobbles (UniqueID, Artist, Album, Title, Date, Time)
SELECT 
    CONCAT(Artist, '_', Album, '_', Title) AS UniqueID,  -- Unique Identifier creation
    Artist, Album, Title, Date, Time
FROM ScrobblerProject.dbo.ScrobblesUpdated
WHERE Date BETWEEN @StartDate AND @EndDate
AND Title IS NOT NULL;

--- Create CTE for TimeOfDay and Season ---
WITH TimeOfDayAndSeason AS (
    SELECT
        Artist,
        Album,
        Title,
        UniqueID,  -- Include the unique identifier
        Date,
        Time,
        CASE
            WHEN DATEADD(HOUR, -5, TIME) BETWEEN '06:00' AND '11:59' THEN 'Morning'
            WHEN DATEADD(HOUR, -5, TIME) BETWEEN '12:00' AND '17:59' THEN 'Afternoon'
            WHEN DATEADD(HOUR, -5, TIME) BETWEEN '18:00' AND '23:59' THEN 'Night'
            WHEN DATEADD(HOUR, -5, TIME) BETWEEN '00:00' AND '05:59' THEN 'Late Night/Early Morning'
        END AS TimeOfDay,
        CASE
            -- Define seasons based on the Date column
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
            WHEN Date BETWEEN '2024-09-23' AND '2024-12-21' THEN 'Fall'
            ELSE 'Unknown'
        END AS Season
    FROM #TempFilteredScrobbles
)

--- Query to select the required columns ---
SELECT 
    UniqueID,
    Artist, 
    Album, 
    Title, 
    Date, 
    Time, 
    Season, 
    TimeOfDay
FROM TimeOfDayAndSeason
ORDER BY Date, Time;  -- Sort by Date and Time

--- Clean Temp Table ---
DROP TABLE #TempFilteredScrobbles;

