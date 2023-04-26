1 --Write a query in SQL to find the number of venues for EURO cup 2016. (soccer_venue)

select * from [SOCCER_DB].[dbo].[soccer_venue]

select count(venue_id) from soccer_venue
           OR
select count(*) from soccer_venue



2 -- Write a query in SQL to find the number OF countries participated in the EURO cup 2016. 

select * from [SOCCER_DB].[dbo].[player_mast]

SELECT COUNT(DISTINCT ((team_id)))
FROM player_mast;



3 -- Write a query in SQL to find the number goals scored in EURO cup 2016
 within normal play schedule.(goal_details)

select * from [SOCCER_DB].[dbo].[goal_details]

select count(*) as 'the number goals scored in EURO cup 2016' from goal_details
where goal_schedule ='NT'



4 --write a query in SQL to find the number of matches ended with a result. (match_mast)

select * from [SOCCER_DB].[dbo].[match_mast]

select count(*) as 'the number of matches ended with a result' 
from match_mast
where results = 'WIN';


5 -- Write a query in SQL to find the number of matches 
-- ended with draws. 
-- (match_mast)

select count(results) as 'the number of matches 
-- ended with draws' 
from match_mast
where results = 'draw';



6--Write a query in SQL to find the date when did Football EURO cup 2016 begin.(match_mast)

select * from [SOCCER_DB].[dbo].[match_mast]

select play_date as 'begining date' from [dbo].[match_mast] where match_no = 1;


7-- Write a query in SQL to find the number of self-goals scored in EURO cup 2016.( goal_details)

select * from [SOCCER_DB].[dbo].[goal_details]

select count(*) as ' the number of self-goals scored in EURO cup 2016'
from goal_details
where goal_type = 'Q';



8 -- Write a query in SQL to count the 'number' of matches
-- ended with a 'results' in 'group stage'. (match_mast)
select * from [SOCCER_DB].[dbo].[match_mast]

select count (*)  from match_mast
where play_stage = 'G' and results ='WIN';




9 -- Write a query in SQL to find the 'number' of matches
-- got a result by penalty shootout. (penalty_shootout)

select * from [SOCCER_DB].[dbo].[penalty_shootout]

SELECT COUNT(distint(match_no)) from penalty_shootout 
where score_goal = 'Y' ;


10 --. Write a query in SQL to find the number of matches were decided on penalties
-- decided on penalties
select * from [SOCCER_DB].[dbo].[match_mast]

select count(decided_by) from  match_mast where decided_by ='N' and Play_stage ='R';

SELECT COUNT(decided_by)
FROM match_mast
WHERE decided_by = 'P' AND play_stage = 'R'



11 --Write a query in SQL to find the number of goal scored (COUNT (*)) ,  in every match (match_no) 
-- within normal play schedule. (goal_details)

select * from [SOCCER_DB].[dbo].[goal_details]

select count(distinct(match_no)) as 'number of goal scored' from goal_details
group by match_no;



12--. Write a query in SQL to find the match no, date of play, and goal scored for that match
-- in which no stoppage time have been added in 1st half of play.

select match_no , play_date, goal_score from match_mast where stop1_sec =0 ;


13-- Write a query in SQL to find the number of matches
-- ending with a goalless draw in group stage of play. (match_details)

select * from [SOCCER_DB].[dbo].[match_details]

select count(distinct(match_no)) as 'the number of matches
ending with a goalless drawfrom match_details' from match_details where  win_lose = 'D' 
and goal_score = '0' and  play_stage = 'G';


14--Write a query in SQL to find the number of matches ending with 
-- only one goal
-- win 
--except those matches which were decided by penalty shootout.(match_details)

SELECT COUNT(*) from match_details where goal_score = '1' and win_lose ='W' and decided by ! = 'P'


15--Write a query in SQL to find the total number of players
-- replaced in the tournament. (player_in_out)

use SOCCER_DB

SELECT * FROM SOCCER_DB.dbo.[player_in_out]

select count(*) from player_in_out where in_out = 'I'



16-- Write a query in SQL to find the total number of palyers replaced
-- within normal time of play.(player_in_out)
use SOCCER_DB
SELECT * FROM SOCCER_DB.dbo.[player_in_out] 

SELECT COUNT(*) FROM player_in_out where play_schedule ='NT'and in_out = 'I';


17--Write a query in SQL to find the number of players
-- replaced in the stoppage time. (player_in_out)

SELECT COUNT(*) FROM player_in_out where play_schedule='ST' and in_out = 'I'

18--Write a query in SQL to find 
-- the total number of players
-- replaced
-- in the first half of play. (player_in_out)
SELECT COUNT(*) from player_in_out where in_out = 'I' and play_half = '1';

19--Write a query in SQL to find  the total number of 
-- goalless draws
-- have there in the entire tournament. (match_details)

select count(distinct(match_no))  AS 'the total number of 
goalless draws'from match_details where win_lose = 'D'AND goal_score='0'




--	20. Write a query in SQL to find 
--	the total number 
--	of players replaced
-- in the extra time of play. (player_in_out)
SELECT * FROM SOCCER_DB.dbo.[player_in_out] 

select count(*)from player_in_out where in_out='I' and play_schedule = 'ET';



21. Write a query in SQL to compute a list to show the number of substitute happened in various stage of play for the entire tournament. (player_in_out)
select count(*)from player_in_out where play_schedule = 'ST';


22. Write a query in SQL to find the number of shots taken in penalty shootout matches.(penalty_shootout)

select * from SOCCER_DB.dbo.penalty_shootout

SELECT		COUNT(*) 'Number of Penalty Kicks'
	FROM		penalty_shootout

23. Write a query in SQL to find the number of shots socred goal in penalty shootout matches. (penalty_shootout)

select * from SOCCER_DB.dbo.penalty_shootout

select count(*)from penalty_shootout where score_goal = 'Y' ;


24. Write a query in SQL to find the number of shots missed or saved in penalty shootout matches. (penalty_shootout)

SELECT COUNT(*) AS 'NUMBER OF SHOTS MISSED' from penalty_shootout where score_goal = 'N' 


25. Write a query in SQL to prepare a list of players with number of shots they taken in penalty shootout matches.

select * from [SOCCER_DB].[dbo].[player_mast]
select * from [SOCCER_DB].[dbo].[Soccer Country]
select * from [SOCCER_DB].[dbo].[penalty_shootout]

				SELECT	c.match_no,c.country_name as 'Team'
						b.player_name,
						b.jersey_no, c.score_goal,
						c.kick_no

						from Soccer Country a ,
						     player_mast b,
							 penalty_shootout c,

				WHERE	c.team_id = a.country_id
						AND 
						c.player_id = b.player_id;



26. Write a query in SQL to find the number of penalty shots taken by the teams. (soccer_country, penalty_shootout)

SELECT		b.country_name, a.team_id, COUNT(a.kick_no)
FROM		penalty_shootout a,Soccer Country b
WHERE		a.team_id = b.country_id
GROUP BY	a.team_id, b.Country_id, b.country_name
ORDER BY	b.Country_id



27. Write a query in SQL to find the number of booking happened in each half of play within normal play schedule. (player_booked)
select * from SOCCER_DB.dbo.player_booked


SELECT		play_half, COUNT(*) AS	'number of booking happened'
	FROM		player_booked
	WHERE		play_schedule	=	'NT'
	GROUP BY	play_half
	ORDER BY	play_half



28. Write a query in SQL to find the number of booking happened in stoppage time. (player_booked)
select count(*) as 'the number of booking happened' from player_booked where play_schedule = 'ST'



29. Write a query in SQL to find the number of booking happened in extra time. (player_booked)

select count(*) as 'the number of booking happened' from player_booked where play_schedule = 'ET'


