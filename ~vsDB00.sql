1-write a SQL query to find out which teams played the first match of the 2016 Euro Cup. Return match number, country name.

select * from [SOCCER_DB].[dbo].[match_details]
select * from [SOCCER_DB].[dbo].[Soccer Country]

use SOCCER_DB

SELECT match_no,country_name
FROM match_details a, [dbo].[Soccer Country] b
where a.team_id=b.country_id
and a.match_no =1;


2--Write a query in SQL to find the winner of EURO cup 2016. (soccer_country, match_details)
SELECT country_name as Team 
FROM  [dbo].[Soccer Country]
WHERE country_id in (
SELECT team_id 
FROM match_details 
WHERE play_stage='F' and win_lose='W');



3--Write a query in SQL to find the match with match no, play stage, goal scored, and the audence which was the heighest audence match. (match_mast)
use SOCCER_DB

SELECT match_no , play_stage ,audence , goal_score from match_mast
where audence = (SELECT MAX(audence) from match_mast);



4--Write a query in SQL to find the match no in which Germany played against Poland(match_details, soccer_country)
SELECT match_no 
FROM match_details 
WHERE team_id=(
SELECT country_id 
FROM [dbo].[Soccer Country]
WHERE country_name='Germany') 


5--Write a query in SQL to find the match no, play stage, date of match, number of gole scored, and the result of the match where Portugal played against Hungary


Select match_no , play_stage ,play_date, goal_score from match_mast
where match_no IN(select match_no from match_details where team_id =(SELECT country_id 
	FROM [dbo].[Soccer Country]
	WHERE country_name='Portugal');
	or
SELECT match_no, play_stage, play_date, results, goal_score
FROM match_mast
WHERE match_no 
IN(
SELECT match_no 
FROM match_details 
WHERE team_id=(
		SELECT country_id 
		FROM  [dbo].[Soccer Country]
		WHERE country_name='Hungary') 
GROUP BY match_no 
HAVING COUNT(DISTINCT team_id)=2);

6--Write a query in SQL to display the list of players scored number of goals in every matches(goal_details, soccer_country, player_mast)

SELECT match_no,country_name, player_name, COUNT(match_no) as'number of goals scored'
FROM goal_details a,[dbo].[Soccer Country] b, player_mast c
WHERE a.team_id=b.country_id
AND a.player_id=c.player_id
GROUP BY match_no,country_name,player_name
ORDER BY match_no;

7--From the following tables, write a SQL query to find the highest audience match. 

SELECT country_name
FROM [dbo].[Soccer Country]
WHERE country_id IN(
   SELECT team_id 
   FROM goal_details 
   WHERE match_no=(
     SELECT match_no 
     FROM match_mast 
     WHERE audence=(
       SELECT max(audence) 
       FROM match_mast)


8--From the following tables, write a SQL query to find the player who scored the last goal for Portugal against Hungary. Return player name

SELECT player_name 
FROM player_mast 
WHERE player_id=(
  SELECT player_id 
  FROM goal_details 
    where match_no=(SELECT match_no FROM match_details 
WHERE team_id=(
SELECT country_id FROM soccer_country 
WHERE country_name='Hungary') 


9--Write a query in SQL to find the 2nd highest stoppage time which had been added in 2nd half of play. (match_mast)
select * from [SOCCER_DB].[dbo].[match_mast]

select max(stop2_sec) from match_mast where stop2_sec<>(select max(stop2_sec) from match_mast);


10--Write a query in SQL to find the teams played the match where 2nd highest stoppage time had been added in 2nd half of play. (soccer_country, match_details, match_mast)
select country_name from[dbo].[Soccer Country] where country_id IN(
select team_id from match_details where match_no IN(
 select match_no from match_mast where stop2_sec=
 (select max(stop2_sec) from match_mast where stop2_sec<>(select max(stop2_sec) from match_mast))));


11--Write a query in SQL to find the match no, date of play and the 2nd highest stoppage time which have been added in the 2nd half of play.(match_mast)
select match_no , play_date,stop2_sec from match_mast where stop2_sec=(
select max(stop2_sec)from match_mast where stop2_sec<>(select max(stop2_sec)from match_mast));


13--Write a query in SQL to find the club which supplied the most number of players to the 2016 EURO cup. player_mast

select playing_club ,count(playing_club) from player_mast
group by playing_club
having count(playing_club)



14--Write a query in SQL to find the player and his jersey number Who scored the first penalty of the tournament. (player_mast, goal_details)
select player_name , jersey_no from player_mast
where player_id =(select player_id from goal_details where goal_type ='p' and match_no=(
select min(match_no) FROM goal_details 
WHERE goal_type='P' AND play_stage='G'));


15--Write a query in SQL to find the player along with his team and jersey number who scored the first penalty of the tournament (player_mast, goal_details, soccer_country)
SELECT a.player_name,a.jersey_no,d.country_name
FROM player_mast a, goal_details b, goal_details c, [dbo].[Soccer Country] d
WHERE a.player_id=b.player_id AND a.team_id=d.country_id AND 
a.player_id=(
SELECT b.player_id 
FROM goal_details b
WHERE b.goal_type='P' AND b.match_no=(
SELECT MIN(c.match_no) 
FROM goal_details c
WHERE c.goal_type='P' AND c.play_stage='G'))
GROUP BY player_name,jersey_no,country_name;

16--Write a query in SQL to find the player who was the goalkeeper for Italy in penalty shootout against Germany in Football EURO cup 2016. (player_mast, penalty_gk, soccer_country)
SELECT player_name 
FROM player_mast 
WHERE player_id=(
SELECT player_gk 
FROM penalty_gk 
WHERE match_no=(
SELECT match_no 
FROM penalty_gk
WHERE team_id=(
SELECT country_id 
FROM soccer_country 
WHERE country_name='Italy'))


17--Write a query in SQL to find the number of germany scored at the tournament. (goal_details, soccer_country)

select  count(player_id) as 'goals'
from goal_details
where team_id =(select country_id from[dbo].[Soccer Country] where country_name = 'Germany');


18--Write a query in SQL to find the players along with their jersey no., and playing club, who were the goalkeepers for the England squad for 2016 EURO cup. (player_mast, soccer_country)
use [SOCCER_DB]
select player_name , jersey_no , playing_club from player_mast
where posi_to_play ='GK' AND team_id =(select country_id from [dbo].[Soccer Country]
where country_name ='England');


19--Write a query in SQL to find the players with other information under contract to Liverpool were in the Squad of England in 2016 EURO cup.  (player_mast, soccer_country)

select player_name , jersey_no , posi_to_play, age from player_mast
where playing_club = 'Liverpool' and team_id =(select country_id from [dbo].[Soccer Country]
where country_name ='England');


20--Write a query in SQL to find the player with other infromation Who scored the last goal in the 2nd semi final i.e. 50th match in EURO cub 2016.  (player_mast, goal_details, soccer_country)
SELECT a.player_name, b.goal_time, b.goal_half, c.country_name
FROM player_mast a, goal_details b,[dbo].[Soccer Country]c
WHERE a.player_id=b.player_id
AND b.team_id=c.country_id
AND match_no=50
AND goal_time= (
SELECT MAX(goal_time) 
FROM  goal_details 
WHERE match_no=50);


21--Write a query in SQL to find the player Who was the captain of the EURO cup 2016 winning team from Portugal. (player_mast, match_captain, match_details)
select player_name from player_mast 
where player_id IN( select player_captain from match_captain
where team_id =(select team_id from match_details where play_stage ='F' and win_lose ='w');


22--Write a query in SQL to find the number of players played for france in the final. (player_in_out, match_mast, soccer_country)

Select count(*)+11 as 'number of players shared field' from player_in_out
where match_no=(select match_no from match_mast where play_stage = 'F' AND in_out='I' and
team_id =(select country_id from [dbo].[Soccer Country] where country_name = 'france'));


23--Write a query in SQL to find the goalkeeper of the team Germany who didt concede any goal in their group stage matches.  (player_mast, match_details, soccer_country)
select player_name , jersey_no from player_mast 
 where team_id = (select match_no from match_details where posi_to_play = 'GK' AND goal_score ='0' and
 match_no  =(select country_id from [dbo].[Soccer Country] where country_name = 'Germany' ));

SELECT player_name,jersey_no 
FROM player_mast 
WHERE player_id IN(
SELECT player_gk 
FROM match_details 
WHERE  play_stage='G' and team_id IN(
SELECT country_id 
FROM
WHERE country_name='Germany'));



24--Write a query in SQL to find the runners-up in Football EURO cup 2016.  (match_details, soccer_country)
select country_name from [dbo].[Soccer Country]
where country_id =(select team_id from match_details where play_stage = 'F' AND win_lose ='L'AND
team_id<>(select country_id from [dbo].[Soccer Country] where country_name = 'portugal'));

25--Write a query in SQL to find the maximum penalty shots taken by the teams.  (soccer_country, penalty_shootout)

select country_name from [dbo].[Soccer Country]
where country_id =(select max(team_id) from penalty_shootout where score_goal='y');

SELECT a.country_name, COUNT(*) shots 
FROM [dbo].[Soccer Country] a, penalty_shootout b
WHERE b.team_id=a.country_id
GROUP BY a.country_name
having COUNT(*) = (
SELECT MAX(shots) FROM (
SELECT COUNT(*) shots 
FROM penalty_shootout
GROUP BY team_id) inner_result);



26-- Write a query in SQL to find the maximum number of penalty shots taken by the players.  (player_mast, penalty_shootout, soccer_country)

Select a.player_name , a.jersey_no , c.country_name ,COUNT(*) shots 
from player_mast a , [dbo].[Soccer Country] c ,penalty_shootout b
where b.player_id = a.player_id
and b.team_id = c.country_id
group by a.player_name , a.jersey_no , c.country_name
having count(*)=
(select max(shots) from
(select count(*)shots from penalty_shootout
group by player_id) inner_result);


27--Write a query in SQL to find the match no. where highest number of penalty shots taken.  (penalty_shootout)

SELECT match_no,
       COUNT(*) shots
FROM penalty_shootout
GROUP BY match_no
HAVING COUNT(*)=
  (SELECT MAX(shots)
   FROM
     (SELECT COUNT(*) shots
      FROM penalty_shootout
      GROUP BY match_no) inner_result);

28-- Write a query in SQL to find the match no. and teams who played the match where highest number of penalty shots had been taken.  (penalty_shootout)
select *  from [dbo].[Soccer Country]
select * from [dbo].[penalty_shootout]

select b.match_no,
       a.country_name
from penalty_shootout b , [dbo].[Soccer Country] a
where a.country_id = b.team_id
AND match_no=
    (SELECT match_no
     FROM penalty_shootout
group by match_no
having count(*)=
(select max(shots) from (select count(*)shots from penalty_shootout
group by match_no)inner_result))
GROUP BY b.match_no,
         a.country_name;


29-- Write a query in SQL to find the player of portugal who taken the 7th kick against poland.  (penalty_shootout, soccer_country)

SELECT a.match_no,
       b.player_name,
       a.kick_no
FROM penalty_shootout a,
     player_mast b
	 where b.player_id =a.player_id 
 and match_no=(select match_no from penalty_shootout where team_id=(select country_id from [dbo].[Soccer Country] where country_name = 'portugal')
 group by match_no)
 GROUP BY match_no,
         player_name,
         kick_id;


30-- Write a query in SQL to find the stage of match where the penalty kick number 23 had been taken.  (match_mast, penalty_shootout)




31-- Write a query in SQL to find the venues where penalty shootout matches played. (soccer_venue, match_mast, penalty_shootout)
32-- Write a query in SQL to find the date when penalty shootout matches played.  (match_mast, penalty_shootout)
33-- Write a query in SQL to find the most quickest goal at the EURO cup 2016, after 5 minutes.  (goal_details)