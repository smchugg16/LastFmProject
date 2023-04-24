---Selecting Dates and Combining Artist and Title for Count---
SELECT Artist, Album, Title, Date
FROM ScrobblerProject.dbo.scrobbles2
	WHERE DATE BETWEEN '2020-04-12' AND '2023-04-12'
	AND Title IS NOT NULL
	ORDER BY DATE desc



/* First Tables: Play Counts*/ 

---Plays on Albums---
SELECT Artist, Album, COUNT(Album) AS AlbumPlays
FROM ScrobblerProject.dbo.scrobbles2
	WHERE DATE BETWEEN '2020-04-12' AND '2023-04-13'
	AND Title IS NOT NULL
GROUP BY Artist, Album
ORDER BY AlbumPlays desc

---Plays on Songs---
SELECT Artist, Title, COUNT(Title) AS SongPlays
FROM ScrobblerProject.dbo.scrobbles2
	WHERE DATE BETWEEN '2020-04-12' AND '2023-04-13'
	AND Title IS NOT NULL
GROUP BY Artist, Title
ORDER BY SongPlays desc

---Plays on Artists---
SELECT Artist, COUNT(Artist) AS ArtistPlays
FROM ScrobblerProject.dbo.scrobbles2
	WHERE Title IS NOT NULL
GROUP BY Artist
ORDER BY ArtistPlays desc



---Plays by Season/Year---

---2020---
/*Spring 2020*/
SELECT Artist, Title, 'Spring' AS Season, '2020' AS Year, COUNT(Title) AS SeasonPlayCount
FROM ScrobblerProject.dbo.scrobbles2
	WHERE DATE BETWEEN '2020-04-12' AND '2020-06-20'
		AND Title IS NOT NULL
GROUP BY Artist, Title
ORDER BY SeasonPlayCount desc

/*Summer 2020*/
SELECT Artist, Title, 'Summer' AS Season, '2020' AS Year, COUNT(Title) AS SeasonPlayCount
FROM ScrobblerProject.dbo.scrobbles2
	WHERE DATE BETWEEN '2020-06-21' AND '2020-09-22'
		AND Title IS NOT NULL
GROUP BY Artist, Title
ORDER BY SeasonPlayCount desc

/*Fall 2020*/
SELECT Artist, Title, 'Fall' AS Season, '2020' AS Year, COUNT(Title) AS SeasonPlayCount
FROM ScrobblerProject.dbo.scrobbles2
	WHERE DATE BETWEEN '2020-09-23' AND '2020-12-20'
		AND Title IS NOT NULL
GROUP BY Artist, Title
ORDER BY SeasonPlayCount desc

/*Winter 2020-2021*/
SELECT Artist, Title, 'Winter' AS Season, '2020' AS Year, COUNT(Title) AS SeasonPlayCount
FROM ScrobblerProject.dbo.scrobbles2
	WHERE DATE BETWEEN '2020-12-21' AND '2021-03-20'
		AND Title IS NOT NULL
GROUP BY Artist, Title
ORDER BY SeasonPlayCount desc


---2021---
/*Spring 2021*/
SELECT Artist, Title, 'Spring' AS Season, '2021' AS Year, COUNT(Title) AS SeasonPlayCount
FROM ScrobblerProject.dbo.scrobbles2
	WHERE DATE BETWEEN '2021-03-21' AND '2021-06-20'
		AND Title IS NOT NULL
GROUP BY Artist, Title
ORDER BY SeasonPlayCount desc

/*Summer 2021*/
SELECT Artist, Title, 'Summer' AS Season, '2021' AS Year, COUNT(Title) AS SeasonPlayCount
FROM ScrobblerProject.dbo.scrobbles2
	WHERE DATE BETWEEN '2021-06-21' AND '2021-09-22'
		AND Title IS NOT NULL
GROUP BY Artist, Title
ORDER BY SeasonPlayCount desc

/*Fall 2021*/
SELECT Artist, Title, 'Fall' AS Season, '2021' AS Year, COUNT(Title) AS SeasonPlayCount
FROM ScrobblerProject.dbo.scrobbles2
	WHERE DATE BETWEEN '2021-09-23' AND '2021-12-20'
		AND Title IS NOT NULL
GROUP BY Artist, Title
ORDER BY SeasonPlayCount desc

/*Winter 2021-2022*/
SELECT Artist, Title, 'Winter' AS Season, '2021' AS Year, COUNT(Title) AS SeasonPlayCount
FROM ScrobblerProject.dbo.scrobbles2
	WHERE DATE BETWEEN '2021-12-21' AND '2022-03-20'
		AND Title IS NOT NULL
GROUP BY Artist, Title
ORDER BY SeasonPlayCount desc


---2022---
/*Spring 2022*/
SELECT Artist, Title, 'Spring' AS Season, '2022' AS Year, COUNT(Title) AS SeasonPlayCount
FROM ScrobblerProject.dbo.scrobbles2
	WHERE DATE BETWEEN '2022-03-21' AND '2022-06-21'
		AND Title IS NOT NULL
GROUP BY Artist, Title
ORDER BY SeasonPlayCount desc

/*Summer 2022*/
SELECT Artist, Title, 'Summer' AS Season, '2022' AS Year, COUNT(Title) AS SeasonPlayCount
FROM ScrobblerProject.dbo.scrobbles2
	WHERE DATE BETWEEN '2022-06-22' AND '2022-09-22'
		AND Title IS NOT NULL
GROUP BY Artist, Title
ORDER BY SeasonPlayCount desc

/*Fall 2022*/
SELECT Artist, Title, 'Fall' AS Season, '2022' AS Year, COUNT(Title) AS SeasonPlayCount
FROM ScrobblerProject.dbo.scrobbles2
	WHERE DATE BETWEEN '2022-09-23' AND '2022-12-21'
		AND Title IS NOT NULL
GROUP BY Artist, Title
ORDER BY SeasonPlayCount desc

/*Winter 2022-2023*/
SELECT Artist, Title, 'Winter' AS Season, '2022' AS Year, COUNT(Title) AS SeasonPlayCount
FROM ScrobblerProject.dbo.scrobbles2
	WHERE DATE BETWEEN '2022-12-22' AND '2023-03-20'
		AND Title IS NOT NULL
GROUP BY Artist, Title
ORDER BY SeasonPlayCount desc


---2023---
/*Spring 2023*/
SELECT Artist, Title, 'Spring' AS Season, '2023' AS Year, COUNT(Title) AS SeasonPlayCount
FROM ScrobblerProject.dbo.scrobbles2
	WHERE DATE BETWEEN '2023-03-21' AND '2023-04-12'
		AND Title IS NOT NULL
GROUP BY Artist, Title
ORDER BY SeasonPlayCount desc


---
