---Fixing Data Errors---
ALTER TABLE ScrobblerProject.dbo.scrobbles
ALTER COLUMN DATE DATE

ALTER TABLE ScrobblerProject.dbo.scrobbles
ALTER COLUMN TIME TIME

ALTER TABLE ScrobblerProject.dbo.scrobbles
DROP COLUMN DayOfTheWeek

--- Previewing Data --- 
SELECT * FROM ScrobblerProject.dbo.scrobbles
	WHERE Title IS NOT NULL
ORDER BY Title

/* First Tables: Play Counts*/ 

---Plays on Individual Songs---
SELECT SongTitle,
       COUNT(*) AS PlayCount
FROM ScrobblerProject.dbo.scrobbles
GROUP BY SongTitle 

---Plays on Artists---
SELECT Artist,
	COUNT(*) AS ArtistPlays
FROM ScrobblerProject.dbo.scrobbles
GROUP BY Artist



---Plays by Season/Year---
/*Spring 2020*/
SELECT Artist, SongTitle, 
	COUNT(*) AS Spring20PlayCount 
FROM ScrobblerProject.dbo.scrobbles
	WHERE DATE BETWEEN '2020-04-12' AND '2020-06-20'
GROUP BY Artist, SongTitle
ORDER BY Spring20PlayCount desc

/*Summer 2020*/
SELECT Artist, SongTitle, 
	COUNT(*) AS Summer20PlayCount 
FROM ScrobblerProject.dbo.scrobbles
	WHERE DATE BETWEEN '2020-06-21' AND '2020-09-22'
GROUP BY Artist, SongTitle
ORDER BY Summer20PlayCount desc

/*Fall 2020*/
SELECT Artist, SongTitle, 
	COUNT(*) AS Fall20PlayCount 
FROM ScrobblerProject.dbo.scrobbles
	WHERE DATE BETWEEN '2020-09-23' AND '2020-12-20'
GROUP BY Artist, SongTitle
ORDER BY Fall20PlayCount desc

/*Winter 2020-2021*/
SELECT Artist, SongTitle, 
	COUNT(*) AS Winter21PlayCount 
FROM ScrobblerProject.dbo.scrobbles
	WHERE DATE BETWEEN '2020-12-21' AND '2021-03-20'
GROUP BY Artist, SongTitle
ORDER BY Winter21PlayCount desc



/*Spring 2021*/
SELECT Artist, SongTitle, 
	COUNT(*) AS Spring21PlayCount 
FROM ScrobblerProject.dbo.scrobbles
	WHERE DATE BETWEEN '2021-03-21' AND '2021-06-20'
GROUP BY Artist, SongTitle
ORDER BY Spring21PlayCount desc

/*Summer 2021*/
SELECT Artist, SongTitle, 
	COUNT(*) AS Summer21PlayCount 
FROM ScrobblerProject.dbo.scrobbles
	WHERE DATE BETWEEN '2021-06-21' AND '2021-09-22'
GROUP BY Artist, SongTitle
ORDER BY Summer21PlayCount desc

/*Fall 2021*/
SELECT Artist, SongTitle, 
	COUNT(*) AS Fall21PlayCount 
FROM ScrobblerProject.dbo.scrobbles
	WHERE DATE BETWEEN '2021-09-23' AND '2021-12-20'
GROUP BY Artist, SongTitle
ORDER BY Fall21PlayCount desc

/*Winter 2021-2022*/
SELECT Artist, SongTitle, 
	COUNT(*) AS Winter22PlayCount 
FROM ScrobblerProject.dbo.scrobbles
	WHERE DATE BETWEEN '2021-12-21' AND '2022-03-20'
GROUP BY Artist, SongTitle
ORDER BY Winter22PlayCount desc




/*Spring 2022*/
SELECT Artist, SongTitle, 
	COUNT(*) AS Spring22PlayCount 
FROM ScrobblerProject.dbo.scrobbles
	WHERE DATE BETWEEN '2022-03-21' AND '2022-06-21'
GROUP BY Artist, SongTitle
ORDER BY Spring22PlayCount desc

/*Summer 2022*/
SELECT Artist, SongTitle, 
	COUNT(*) AS Summer22PlayCount 
FROM ScrobblerProject.dbo.scrobbles
	WHERE DATE BETWEEN '2022-06-22' AND '2022-09-22'
GROUP BY Artist, SongTitle
ORDER BY Summer22PlayCount desc

/*Fall 2022*/
SELECT Artist, SongTitle, 
	COUNT(*) AS Fall22PlayCount 
FROM ScrobblerProject.dbo.scrobbles
	WHERE DATE BETWEEN '2022-09-23' AND '2022-12-21'
GROUP BY Artist, SongTitle
ORDER BY Fall22PlayCount desc

/*Winter 2022-2023*/
SELECT Artist, SongTitle, 
	COUNT(*) AS Winter23PlayCount 
FROM ScrobblerProject.dbo.scrobbles
	WHERE DATE BETWEEN '2022-12-22' AND '2023-03-20'
GROUP BY Artist, SongTitle
ORDER BY Winter23PlayCount desc


---


/*Top 50 Artists by Number of Plays*/
SELECT TOP 50 Artist, COUNT(Artist) AS ArtistPlays
FROM ScrobblerProject.dbo.scrobbles
GROUP BY Artist
ORDER BY ArtistPlays desc

/*Top 50 Albums by Number of Plays*/
SELECT TOP 50 Artist, Album, COUNT(Album) AS AlbumPlays
FROM ScrobblerProject.dbo.scrobbles
GROUP BY Artist, Album
ORDER BY AlbumPlays desc


---


/*Most Played by Time of Day- 
Note: Date is in UTC ("CorrectedTime" is an approximation for EST- not accounting for Daylight Savings)*/

---"Time Correction" test--- 
SELECT Artist, SongTitle, Date, Time, dateadd(hour, -5, Time) AS CorrectedTime
FROM ScrobblerProject.dbo.scrobbles
	WHERE Time BETWEEN '11:00' AND '16:59'
GROUP BY Artist, SongTitle, Date, Time
Order by Date desc, Time desc


---

---Morning (6am to 12pm)---
SELECT Artist, SongTitle, COUNT(SongTitle) AS MorningSongPlays
FROM ScrobblerProject.dbo.scrobbles
	WHERE Time BETWEEN '11:00' AND '16:59'
	GROUP BY Artist, SongTitle
	ORDER BY MorningSongPlays desc

---Afternoon (12pm to 6pm)---
SELECT Artist, SongTitle, COUNT(SongTitle) AS AfternoonSongPlays 
FROM ScrobblerProject.dbo.scrobbles
	WHERE Time BETWEEN '17:00' AND '22:59'
	GROUP BY Artist, SongTitle 
	ORDER BY AfternoonSongPlays desc

---Night (6pm to 12am)*---
/*Note: Dateadd(hour,-5, Time) is to workaround UTC -> Looking for plays between approx 6 to 11:59pm EST*/ 
SELECT Artist, SongTitle, COUNT(SongTitle) AS NightSongPlays
FROM ScrobblerProject.dbo.scrobbles
	WHERE Dateadd(hour, -5, Time) BETWEEN '18:00' AND '23:59'
	GROUP BY Artist, SongTitle
	ORDER BY NightSongPlays desc

---Late Night/Early Morning (12am to 6am)---
/*Ditto note from above -> Looking for plays between approx 12am to 6am*/
SELECT Artist, SongTitle, COUNT(SongTitle) AS LateNightSongPlays
FROM ScrobblerProject.dbo.scrobbles
	WHERE dateadd(hour, -5, Time) BETWEEN '00:00' AND '05:59'
	GROUP BY Artist, SongTitle
	ORDER BY LateNightSongPlays desc
