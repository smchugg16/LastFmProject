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

---Plays by Day---
