---Correcting Date Formats---
ALTER TABLE ScrobblerProject.dbo.ScrobblesUpdated
ALTER COLUMN DATE DATE

ALTER TABLE ScrobblerProject.dbo.ScrobblesUpdated
ALTER COLUMN TIME TIME

---Previewing Data and Checking For Format Correction---
SELECT * 
FROM ScrobblerProject.dbo.ScrobblesUpdated
ORDER BY DATE desc, TIME desc

/*Create Tables*/
---Morning (6am to 12pm)---
SELECT Artist, Title, SongTitle, 'Morning' AS TimeOfDay, COUNT(SongTitle) AS TimeSongPlays
FROM ScrobblerProject.dbo.ScrobblesUpdated
	WHERE Time BETWEEN '11:00' AND '16:59'
	GROUP BY Artist, Title, SongTitle
	ORDER BY TimeSongPlays desc

---Afternoon (12pm to 6pm)---
SELECT Artist, Title, SongTitle, 'Afternoon' AS TimeOfDay, COUNT(SongTitle) AS TimeSongPlays
FROM ScrobblerProject.dbo.scrobbles
	WHERE Time BETWEEN '17:00' AND '22:59'
	GROUP BY Artist, Title, SongTitle
	ORDER BY TimeSongPlays desc

---Night (6pm to 12am)*---
/*Note: Dateadd(hour,-5, Time) is to workaround UTC -> Looking for plays between approx 6 to 11:59pm EST*/ 
SELECT Artist, Title, SongTitle, 'Night' AS TimeOfDay, COUNT(SongTitle) AS TimeSongPlays
FROM ScrobblerProject.dbo.scrobbles
	WHERE Dateadd(hour, -5, Time) BETWEEN '18:00' AND '23:59'
	GROUP BY Artist, Title, SongTitle
	ORDER BY TimeSongPlays desc

---Late Night/Early Morning (12am to 6am)---
/*Ditto note from above -> Looking for plays between approx 12am to 6am*/
SELECT Artist, Title, SongTitle, 'Late Night' AS TimeOfDay, COUNT(SongTitle) AS TimeSongPlays
FROM ScrobblerProject.dbo.scrobbles
	WHERE Dateadd(hour, -5, Time) BETWEEN '00:00' AND '05:59'
	GROUP BY Artist, Title, SongTitle
	ORDER BY TimeSongPlays desc

---