--- Previewing Data --- 
SELECT * FROM ScrobblerProject.dbo.scrobbles
WHERE Title IS NOT NULL
ORDER BY Title

/* First Tables: Play Counts*/ 

---Plays on Individual Songs---
SELECT SongTitle,
       COUNT(*) AS PlayCount
FROM scrobbles
GROUP BY SongTitle 

---Plays on Artists---
SELECT Artist,
	COUNT(*) AS ArtistPlays
FROM scrobbles
GROUP BY Artist

---Plays by Season/Year---
/*Spring 2020*/
SELECT Artist, SongTitle, 
COUNT(*) AS PlayCount 
FROM scrobbles
WHERE DATE BETWEEN '2020-04-12' AND '2020-06-20'
GROUP BY Artist, SongTitle
ORDER BY PlayCount desc

/*Summer 2020*/
SELECT Artist, SongTitle, 
COUNT(*) AS PlayCount 
FROM scrobbles
WHERE DATE BETWEEN '2020-06-21' AND '2020-09-22'
GROUP BY Artist, SongTitle
ORDER BY PlayCount desc

/*Fall 2020*/
SELECT Artist, SongTitle, 
COUNT(*) AS PlayCount 
FROM scrobbles
WHERE DATE BETWEEN '2020-09-23' AND '2020-12-20'
GROUP BY Artist, SongTitle
ORDER BY PlayCount desc

/*Winter 2020-2021*/
SELECT Artist, SongTitle, 
COUNT(*) AS PlayCount 
FROM scrobbles
WHERE DATE BETWEEN '2020-12-21' AND '2021-03-20'
GROUP BY Artist, SongTitle
ORDER BY PlayCount desc

---

/*Spring 2021*/
SELECT Artist, SongTitle, 
COUNT(*) AS PlayCount 
FROM scrobbles
WHERE DATE BETWEEN '2021-03-21' AND '2021-06-20'
GROUP BY Artist, SongTitle
ORDER BY PlayCount desc

/*Summer 2021*/
SELECT Artist, SongTitle, 
COUNT(*) AS PlayCount 
FROM scrobbles
WHERE DATE BETWEEN '2021-06-21' AND '2021-09-22'
GROUP BY Artist, SongTitle
ORDER BY PlayCount desc

/*Fall 2021*/
SELECT Artist, SongTitle, 
COUNT(*) AS PlayCount 
FROM scrobbles
WHERE DATE BETWEEN '2021-09-23' AND '2021-12-20'
GROUP BY Artist, SongTitle
ORDER BY PlayCount desc

/*Winter 2021-2022*/
SELECT Artist, SongTitle, 
COUNT(*) AS PlayCount 
FROM scrobbles
WHERE DATE BETWEEN '2021-12-21' AND '2022-03-20'
GROUP BY Artist, SongTitle
ORDER BY PlayCount desc

---

/*Spring 2022*/
SELECT Artist, SongTitle, 
COUNT(*) AS PlayCount 
FROM scrobbles
WHERE DATE BETWEEN '2022-03-21' AND '2022-06-21'
GROUP BY Artist, SongTitle
ORDER BY PlayCount desc

/*Summer 2022*/
SELECT Artist, SongTitle, 
COUNT(*) AS PlayCount 
FROM scrobbles
WHERE DATE BETWEEN '2022-06-22' AND '2022-09-22'
GROUP BY Artist, SongTitle
ORDER BY PlayCount desc

/*Fall 2022*/
SELECT Artist, SongTitle, 
COUNT(*) AS PlayCount 
FROM scrobbles
WHERE DATE BETWEEN '2022-09-23' AND '2022-12-21'
GROUP BY Artist, SongTitle
ORDER BY PlayCount desc

/*Winter 2022-2023*/
SELECT Artist, SongTitle, 
COUNT(*) AS PlayCount 
FROM scrobbles
WHERE DATE BETWEEN '2022-12-22' AND '2023-03-20'
GROUP BY Artist, SongTitle
ORDER BY PlayCount desc


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


/*Most Played by Time- Date is in UTC need to get EST? Need to Fix!!!...*/

SELECT TOP 50 Artist, SongTitle, Date, Time, dateadd(hour, -5, Time) AS CorrectedTime
FROM ScrobblerProject.dbo.scrobbles
GROUP BY Artist, SongTitle, Date, Time
Order by Date desc, Time desc

---Morning (6am to 12pm)---
SELECT TOP 50 Artist, SongTitle, COUNT(SongTitle) AS SongPlays
FROM ScrobblerProject.dbo.scrobbles
	WHERE dateadd(hour, +5, Time) BETWEEN '06:00' AND '11:59'
	GROUP BY Artist, SongTitle
	ORDER BY SongPlays desc

/*Checking Previous Query*/
SELECT TOP 50 Artist, SongTitle, COUNT(SongTitle) AS SongPlays 
FROM ScrobblerProject.dbo.scrobbles
	WHERE Time BETWEEN '01:00' AND '06:59'
	GROUP BY Artist, SongTitle 
	ORDER BY SongPlays desc

/*Afternoon (12pm to 6pm)
SELECT TOP 50 Artist, SongTitle, COUNT(SongTitle) AS SongPlays 
FROM ScrobblerProject.dbo.scrobbles
	WHERE dateadd(hour, -5, Time) BETWEEN '12:00' AND '17:59'
	GROUP BY Artist, SongTitle 
	ORDER BY SongPlays desc

---Night (6pm to 12am)---
SELECT TOP 50 Artist, SongTitle, COUNT(SongTitle) AS SongPlays 
FROM ScrobblerProject.dbo.scrobbles
	WHERE dateadd(hour, -5, Time) BETWEEN '18:00' AND '23:59'
	GROUP BY Artist, SongTitle 
	ORDER BY SongPlays desc

---Late Night (12am to 6am)---
SELECT TOP 50 Artist, SongTitle, COUNT(SongTitle) AS SongPlays 
FROM ScrobblerProject.dbo.scrobbles
	WHERE dateadd(hour, -5, Time) BETWEEN '00:00' AND '05:59'
	GROUP BY Artist, SongTitle 
	ORDER BY SongPlays desc
*/
