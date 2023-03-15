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
