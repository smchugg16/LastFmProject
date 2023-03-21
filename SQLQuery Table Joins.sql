/*Checking for Import Sucess*/
SELECT * 
FROM ScrobblerProject.dbo.Fall20Plays



/*Join #1- Joining all "Spring" tables*/
SELECT Sp20.Artist, Sp20.SongTitle, COALESCE(Sp20.Spring20PlayCount, 0) AS Spring20Plays, 
COALESCE(Sp21.Spring21PlayCount, 0) AS Spring21Plays, 
COALESCE(Sp22.Spring22PlayCount, 0) AS Spring22Plays
FROM ScrobblerProject.dbo.Spring20Plays Sp20
LEFT JOIN ScrobblerProject.dbo.Spring21Plays Sp21
	ON Sp20.Artist = Sp21.Artist
	AND Sp20.SongTitle = Sp21.SongTitle
LEFT JOIN ScrobblerProject.dbo.Spring22Plays Sp22
	ON Sp20.Artist = Sp22.Artist
	AND Sp20.SongTitle = Sp22.SongTitle
ORDER BY Sp20.SongTitle



/*Join #2- Joining all "Summer" tables*/
SELECT Su20.Artist, Su20.SongTitle, COALESCE(Su20.Summer20PlayCount, 0) AS Summer20Plays, 
COALESCE(Su21.Summer21PlayCount, 0) AS Summer21Plays, 
COALESCE(Su22.Summer22PlayCount, 0) AS Summer22Plays
FROM ScrobblerProject.dbo.Summer20Plays Su20
LEFT JOIN ScrobblerProject.dbo.Summer21Plays Su21
	ON Su20.Artist = Su21.Artist
	AND Su20.SongTitle = Su21.SongTitle
LEFT JOIN ScrobblerProject.dbo.Summer22Plays Su22
	ON Su20.Artist = Su22.Artist
	AND Su20.SongTitle = Su22.SongTitle
ORDER BY Su20.SongTitle



/*Join #3- Joining all "Fall" tables*/
SELECT F20.Artist, F20.SongTitle, COALESCE(F20.Fall20PlayCount, 0) AS Fall20Plays, 
COALESCE(F21.Fall21PlayCount, 0) AS Fall21Plays, 
COALESCE(F22.Fall22PlayCount, 0) AS Fall22Plays
FROM ScrobblerProject.dbo.Fall20Plays F20
LEFT JOIN ScrobblerProject.dbo.Fall21Plays F21
	ON F20.Artist = F21.Artist
	AND F20.SongTitle = F21.SongTitle
LEFT JOIN ScrobblerProject.dbo.Fall22Plays F22
	ON F20.Artist = F22.Artist
	AND F20.SongTitle = F22.SongTitle
ORDER BY F20.SongTitle



/*Join #4- Joining all "Winter" tables*/
SELECT W21.Artist, W21.SongTitle, COALESCE(W21.Winter21PlayCount, 0) AS Winter21Plays, 
COALESCE(W22.Winter22PlayCount, 0) AS Winter22Plays, 
COALESCE(W23.Winter23PlayCount, 0) AS Winter23Plays
FROM ScrobblerProject.dbo.Winter21Plays W21
LEFT JOIN ScrobblerProject.dbo.Winter22Plays W22
	ON W21.Artist = W22.Artist
	AND W21.SongTitle = W22.SongTitle
LEFT JOIN ScrobblerProject.dbo.Winter23Plays W23
	ON W21.Artist = W23.Artist
	AND W21.SongTitle = W23.SongTitle
ORDER BY W21.SongTitle

/*Figure out how to include SUM column for total of each?*/