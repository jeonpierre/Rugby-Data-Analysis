-- Cleaning Rugby International Data

-- Profiled Data 
SELECT *
FROM rugby_data

-- Chose to investigate Six nations data from the year 2000 onwards. Used Where to filter for year and Like to filter for Competition Name 'Six Nations'

SELECT *
FROM rugby_data 
WHERE date >= '2000-01-01'
AND competition LIKE '%Six Nations Championship%';

-- Selecting and Re-formatting the Competition text to be 'Six Nations Championship' for all in this group.

SELECT *, REPLACE(competition, competition, 'Six Nations Championship') as competition_cleaned 
FROM rugby_data 
WHERE date >= '2000-01-01'
AND competition LIKE '%Six Nations Championship%';


-- Selecting and Re-formatting the Stadium Text- Scotland

SELECT *, REPLACE(stadium,stadium,'Murrayfield Stadium')
FROM six_nations
WHERE stadium LIKE '%Murrayfeild';

UPDATE six_nations
SET stadium = 'Murrayfield Stadium'
WHERE stadium = 'Murrayfeild Stadium';

SELECT *
FROM six_nations
WHERE country = 'Scotland';

-- Selecting and Re-formatting the Stadium Text - England

SELECT *
FROM six_nations
WHERE country = 'England';

UPDATE six_nations
SET stadium = 'Twickenham Stadium'
WHERE stadium LIKE '%Twickenham%';


-- Updating the Competition Column permenantly. 

UPDATE rugby_data
SET competition = 'Six Nations Championship'
WHERE competition LIKE '%Six Nations%';

-- Checking the Updates to the competition column. 

SELECT *
FROM rugby_data
WHERE competition NOT LIKE 'Six Nations Championship'

SELECT *
FROM rugby_data
WHERE competition LIKE 'Six Nations Championship'


-- Creating a new table six_nations for all the data from six nations. 

DROP TABLE IF EXISTS six_nations;

CREATE TABLE six_nations (
    home_team TEXT,
    away_team TEXT, 
    home_score INTEGER, 
    away_score INTEGER,
    competition TEXT, 
    date DATE,
    stadium TEXT, 
    city TEXT, 
    country TEXT
);

-- Inserting Six Nations data into six_nations table
INSERT INTO six_nations (home_team, away_team, home_score, away_score, competition, date,  stadium, city, country)
SELECT home_team, away_team, home_score, away_score, competition, date,  stadium, city, country
FROM rugby_data
WHERE date >= '2000-01-01'
AND competition LIKE '%Six Nations%';

-- Drop a column if needed
ALTER TABLE six_nations 
DROP COLUMN neutral, world_cup

-- Checking new Six nations table data.

Select *
FROM six_nations
ORDER BY home_score DESC;

-- Creating Winning Team

SELECT home_team, away_team, home_score, away_score, competition,date,
CASE 
	WHEN home_score > away_score Then home_team 
	WHEN away_score > home_score THEN away_team
ELSE 'Draw'
END AS winner
FROM six_nations
WHERE competition = 'Six Nations Championship'
GROUP BY Winner, home_team, away_team, home_score, away_score, competition,date

-- Creating Columns

ALTER TABLE six_nations
ADD COLUMN winner text;

-- insert into new column

UPDATE six_nations 
SET winner =
CASE 
	WHEN home_score > away_score Then home_team 
	WHEN away_score > home_score THEN away_team
ELSE 'Draw'
END

-- Creating Columns for home vs away wins

ALTER TABLE six_nations
ADD COLUMN home_or_away_win text;

-- insert into new 'home_or_away_win' column

UPDATE six_nations 
SET home_or_away_win =
CASE 
	WHEN home_score > away_score Then 'Home Win'
	WHEN away_score > home_score THEN 'Away Win'
ELSE 'Draw'
END

-- Checking Updates

SELECT * 
FROM six_nations

-- Preparing for Coaches Table

DROP TABLE IF EXISTS nation_coach;

CREATE TABLE nation_coach (
    Date date,
    England TEXT,
    France Text,
    Scotland TEXT, 
    Italy Text, 
    Ireland Text,
	Wales Text
);


/* Queries List
Still To Do:
-- Add coaches from Online Data? As separate table (use joins)

- 1. Count Home Wins vs. Count Away Wins -- DONE--
- 2. Biggest Points Difference - Home and Away Win --DONE
- 3. Total Score (Trends over Time?) --
- 4. Home & Away Wins Grouped by Nation --
- 5. Team Win Rate / %, Per Year -- 
- 6. Team Win Rate per Stadium (If Multi stadiums) --
*/

-- 1. Count Home Vs Away wins and Percentage

SELECT home_or_away_win, 
	COUNT(home_or_away_win) AS count_wins, 
	(SELECT COUNT(home_or_away_win) FROM six_nations) AS Total_Count,
	(COUNT(home_or_away_win) / CAST((SELECT COUNT(home_or_away_win) FROM six_nations)as float)*100) AS Percentage
FROM six_nations
GROUP BY home_or_away_win, Total_Count
ORDER BY percentage DESC;

-- 2. Biggest point difference home_away win 

SELECT date, home_score, away_score, home_team,away_team, winner, 
CASE 
	WHEN home_score > away_score THEN home_score - away_score
	WHEN away_score > home_score THEN away_score - home_score
ELSE 0
END AS points_difference							  	
FROM six_nations
ORDER BY points_difference DESC
LIMIT 5;

-- OR

SELECT date, home_score, away_score, home_team,away_team, winner, 
ABS(home_score - away_score) as points_difference
FROM six_nations;

-- Repeat of the above but concatinating the winner string onto the points difference.

SELECT date, home_score, away_score, home_team,away_team, winner, 
CASE 
	WHEN home_score > away_score THEN winner ||'by'|| (home_score - away_score)
	WHEN away_score > home_score THEN winner ||'by'|| (away_score - home_score)
ELSE 'Draw'
END AS points_difference							  	
FROM six_nations
WHERE 
GROUP BY home_score, away_score
ORDER BY points_difference DESC
LIMIT 5;

-- Adding the point_difference as a Column

ALTER TABLE six_nations 
DROP COLUMN IF EXISTS points_difference

ALTER TABLE six_nations
ADD COLUMN points_difference integer;

UPDATE six_nations 
SET points_difference =
CASE 
	WHEN home_score > away_score THEN home_score - away_score
	WHEN away_score > home_score THEN away_score - home_score
ELSE 0
END

-- Checking changes to table. 

SELECT *
FROM six_nations;

-- Biggest Home & Away Points Difference:

SELECT home_or_away_win, home_team, away_team, winner, points_difference
FROM six_nations
ORDER BY points_difference DESC
LIMIT 3;

-- (Using Date Part to extract Year from date and finding - Average Points Difference Per Year)

SELECT DATE_PART('Year' ,date) AS Year
FROM six_nations
ORDER BY date ASC;

SELECT DATE_PART('Year' ,date) AS Year,
ROUND(AVG(points_difference),0) AS average
FROM six_nations
GROUP BY year
ORDER BY average DESC;

-- Average Points Difference Per Team

SELECT country, 
	ROUND(AVG(points_difference),0) as average
FROM six_nations
GROUP BY country
ORDER BY average DESC;

-- Noted that Points difference can actually be negative, this is something we need to account for to make this more accurate. 


-- 3. Total Score / Trends over Time. 

SELECT DATE_PART('Year',date) AS YEAR, ROUND(AVG(home_score + away_score),2) AS YearAvgScore
FROM six_nations
GROUP BY Year
ORDER BY YearAvgScore DESC;


-- 4. Home & Away Wins Grouped By Nation 

SELECT winner, COUNT(winner) AS CountPerNation, home_or_away_win
FROM six_nations
GROUP BY Winner, home_or_away_win
ORDER BY home_or_away_win, CountPerNation DESC;

-- 5. Team Win Rate % by Year. 

SELECT CAST(COUNT(winner) as float)/5*100 AS WinsPerYearPercentage, DATE_PART('Year',date) AS year, winner
FROM six_nations
GROUP BY winner, year,winner
ORDER BY Year,WinsPerYearPercentage DESC;

-- 6. Win rate per statium for each team. 

    -- Create two temporary tables, one for Games at home and one for Wins at home.

DROP TABLE IF EXISTS #temp_GamesAtHome
CREATE TABLE #temp_GamesAtHome (
Home_team nvarchar(50),
Stadium nvarchar(50),
GamesAtHome int)

DROP TABLE IF EXISTS #temp_WinsAtHome
CREATE TABLE #temp_WinsAtHome (
Home_team nvarchar(50),
Stadium nvarchar(50),
WinsAtHome int)

    -- Inserting the data from SixNationsData into the temporary tables.

INSERT INTO #temp_GamesAtHome
SELECT Home_team, Stadium, COUNT(Stadium) as GamesAtHome
FROM SixNationsData
GROUP BY Home_team, Stadium
ORDER BY Home_team

INSERT INTO #temp_WinsAtHome
SELECT Home_team, Stadium, COUNT(Stadium)as WinsAtHome
FROM SixNationsData
WHERE HomeOrAwayWin = 'Home'
GROUP BY Stadium, Home_team
ORDER BY Home_team

    -- Join the two temporary tables by the same stadium name, select the wanted columns and calculate the win rate per stadium.

SELECT GAH.Home_team, GAH.Stadium, WinsAtHome, GamesAtHome,
    (SELECT ROUND((WinsAtHome/CAST(GamesAtHome as float))*100, 2)) as Percentage
FROM #temp_GamesAtHome GAH
LEFT OUTER JOIN #temp_WinsAtHome WAH
    ON GAH.Stadium = WAH.Stadium
	