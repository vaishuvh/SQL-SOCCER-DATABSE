1-- Write a query in SQL to find the name of the venue with city where the EURO cup 2016 final match was played. (soccer_venue, soccer_city, match_mast)
USE[SOCCER_DB]

select venue_name , city from soccer_venue a
join soccer_city b ON a.city_id = b.city_id
join match_mast c ON c.venue_id = a.venue_id 
and c.play_stage ='F';

2-- Write a query in SQL to find the number of goal scored by each team in every match within normal play schedule.  (match_details, soccer_country)

select match_no , goal_score,country_name from match_details a 
join[dbo].[Soccer Country] b ON a.team_id = b.country_id
where decided_by = 'N'
order by match_no;

3-- Write a query in SQL to find the total number of goals scored by each player within normal play schedule and arrange the result set according to the heighest to lowest scorer.  (goal_details, player_mast, soccer_country)

select goal_score ,player_name, country_name 
from goal_details a , player_mast b , [dbo].[Soccer Country] c
JOIN player_mast b ON b.team_id = a.team_id
JOIN [dbo].[Soccer Country] 


4-- Write a query in SQL to find the highest individual scorer in EURO cup 2016.  (goal_details, player_mast, soccer_country)

select count(player_name),country_name ,player_name
from goal_details a 
JOIN player_mast b ON b.player_id = a.player_id
JOIN [dbo].[Soccer Country]c ON b.team_id =c.country_id 
group by country_name, player_name  Having count(player_name)>= all
(SELECT COUNT(player_name)
   FROM goal_details a
   JOIN player_mast b ON b.player_id =a.player_id
   JOIN [dbo].[Soccer Country]c ON b.team_id = c.country_id
   GROUP BY country_name,player_name);




5-- Write a query in SQL to find the scorer of only goal along with his country and jersey number in the final of EURO cup 2016.(goal_details,, player_mast, soccer_country)

select player_name , jersey_no , country_name from goal_details a
JOIN player_mast b ON b.player_id = a.player_id
JOIN [dbo].[Soccer Country]c ON b.team_id =c.country_id 
where play_stage = 'F'
order by player_name ;


6-- Write a query in SQL to find the country where Football EURO cup 2016 held.  (soccer_country, soccer_city, soccer_venue)
select country_name from [dbo].[Soccer Country] a
JOIN soccer_city b  ON a.country_id=b.country_id
JOIN soccer_venue c ON b.city_id=c.city_id
group by country_name ;


7--. Write a query in SQL to find the player who socred first goal of EURO cup 2016.  (soccer_country, player_mast, goal_details)
SELECT a.player_name,a.jersey_no,b.country_name,c.goal_time,
c.play_stage,c.goal_schedule, c.goal_half from player_mast a
JOIN goal_details c ON c.player_id = a.player_id
JOIN [dbo].[Soccer Country]b ON a.team_id =b.country_id
where goal_id =1;


8--. Write a query in SQL to find the name and country of the referee who managed the opening match. (soccer_country, match_mast, referee_mast)
 select c.referee_name , a.country_name from referee_mast c
 JOIN match_mast b ON b.referee_id =c.referee_id
 JOIN [dbo].[Soccer Country] a ON c.country_id = a.country_id
 where match_no=1;


9--. Write a query in SQL to find the name and country of the referee who managed the final match.  (soccer_country, match_mast, referee_mast)

select c.referee_name , a.country_name from referee_mast c
 JOIN match_mast b ON b.referee_id =c.referee_id
 JOIN [dbo].[Soccer Country] a ON c.country_id = a.country_id
 where play_stage='F';


10-- Write a query in SQL to find the name and country of the referee who assisted the referee in the opening match.  (asst_referee_mast, soccer_country, match_details)
select a.ass_ref_name , b.country_name from asst_referee_mast a
JOIN [dbo].[Soccer Country] b ON a.country_id= b.country_id
JOIN match_details c ON a.ass_ref_id= c.ass_ref
where match_no=1;



11--. Write a query in SQL to find the name and country of the referee who assisted the referee in the final match.  (asst_referee_mast, soccer_country, match_details)

select a.ass_ref_name , b.country_name from asst_referee_mast a
JOIN [dbo].[Soccer Country] b ON a.country_id= b.country_id
JOIN match_details c ON a.ass_ref_id= c.ass_ref
 where play_stage='F';


12--. Write a query in SQL to find the city where the opening match of EURO cup 2016 played.  (soccer_venue, soccer_city, match_mast)
select a.venue_name , b.city from soccer_venue a
JOIN soccer_city b ON b.city_id = a.city_id
JOIN match_mast c ON  c.venue_id = a.venue_id
where match_no=1;


13--. Write a query in SQL to find the stadium hosted the final match of EURO cup 2016 along with the capacity, and audance for that match.  (soccer_venue, soccer_city, match_mast)

select a.venue_name , b.city ,c.audence , a.aud_capacity from soccer_venue a 
JOIN soccer_city b ON b.city_id = a.city_id
JOIN match_mast c ON a.venue_id = c.venue_id
 where play_stage='F';

14-- Write a query in SQL to compute a report that contain the number of matches played in each venue along with their city.  (soccer_venue, soccer_city, match_mast)
select a.venue_name , b.city , count(c.match_no) from soccer_venue a
JOIN soccer_city b ON b.city_id = a.city_id
JOIN match_mast c ON a.venue_id = c.venue_id
group by venue_name , city 
order by venue_name ;

 
15-- Write a query in SQL to find the player who was the first player to be sent off at the tournament EURO cup 2016.  ( player_booked, player_mast, soccer_country)

select a.match_no,c.country_name , b.player_name , b.jersey_no ,a.play_schedule , a.booking_time from player_booked a
JOIN player_mast b ON b.player_id = a.player_id 
JOIN [dbo].[Soccer Country] c ON a.team_id = c.country_id 
where match_no=1 and sent_off = 'Y';


16-- Write a query in SQL to find the teams that scored only one goal to the torunament.  (soccer_team, soccer_country)

select b.country_name as 'Team' , a.team_group , a.goal_for from soccer_team a
JOIN [dbo].[Soccer Country] b ON b.country_id =a.team_id
where goal_for =1
group by country_name, team_group, goal_for 
order by country_name;


17-- Write a query in SQL to find the yellow cards received by each country. (soccer_country, player_booked)

select a.country_name , count(*)
from [dbo].[Soccer Country] a
JOIN player_booked b ON a.country_id = b.team_id 
group by country_name;

SELECT country_name, COUNT(*)
FROM [dbo].[Soccer Country] a
JOIN player_booked b
ON a.country_id=b.team_id
GROUP BY country_name
ORDER BY COUNT(*) DESC;

18--- Write a query in SQL to find the venue with number of goals that has seen. (soccer_country, goal_details, match_mast, soccer_venue)
use [SOCCER_DB]

select venue_name ,count(venue_name ) from soccer_venue
JOIN match_mast c ON c.venue_id = d.venue_id
JOIN [dbo].[Soccer Country] a ON b.player_id = a.country_id
JOIN goal_details b ON b.match_no = c.match_no



19-- Write a query in SQL to find the match where no stoppage time added in 1st half of play. (match_details, match_mast, soccer_country)

select a.match_no, c.country_name from match_mast a
JOIN match_details b ON b.match_no =a.match_no 
JOIN [dbo].[Soccer Country] c ON b.team_id = c.country_id
where stop1_sec = 0;


20-- Write a query in SQL to find the team(s) who conceded the most goals in EURO cup 2016. (soccer_team, soccer_country)

SELECT country_name,team_group,match_played,
won,lost,goal_for,goal_agnst
FROM soccer_team a
JOIN [dbo].[Soccer Country]b ON a.team_id = b.country_id
where goal_agnst =(select max(goal_agnst) from soccer_team);

21--. Write a query in SQL to find the match where highest stoppege time added in 2nd half of play. (match_details, match_mast, soccer_country)

select b.match_no , c.country_name , b.stop2_sec from match_details a
JOIN match_mast b  ON a.match_no = b.match_no 
JOIN [dbo].[Soccer Country] c ON a.team_id = c.country_id 
where stop2_sec = (select max(stop2_sec) from match_mast b)
order by country_name; 



22--. Write a query in SQL to find the matchs ending with a goalless draw in group stage of play. (match_details, soccer_country)

select a.match_no ,b.country_name from  match_details a
JOIN [dbo].[Soccer Country] b ON a.team_id = b.country_id 
where play_stage = 'G' and win_lose = 'D' and goal_score = 0
order by match_no;



23.--Write a query in SQL to find the match no. and the teams played in that match where the 2nd highest stoppage time had been added in the 2nd half of play. (match_mast, match_details, soccer_country)

select a.match_no , c.country_name , a.stop2_sec from match_details b
JOIN match_mast a  ON a.match_no = b.match_no 
JOIN [dbo].[Soccer Country] c ON b.team_id = c.country_id 
where (2-1) =(select count(distinct(b.stop2_sec)) from match_mast b
where b.stop2_sec > a.stop2_sec);




24.-- Write a query in SQL to find the player and his team and how many matches he kept goal for his team.  (player_mast, match_details, soccer_country)

select c.country_name , a.player_name ,count(b.player_gk) count_gk from match_details b
JOIN player_mast a ON a.player_id =b.player_gk
JOIN [dbo].[Soccer Country] c  ON a.team_id = c.country_id
group by c.country_name ,a. player_name 
order by country_name , player_name , count_gk desc ; 



25.-- Write a query in SQL to find the venue that has seen the most goals.  (goal_details, soccer_country, match_mast, soccer_venue)

select venue_name , count(venue_name) from goal_details a
JOIN [dbo].[Soccer Country] b ON  b.country_id = a.team_id
JOIN soccer_venue d ON c.venue_id = d.venue_id
JOIN match_mast c ON a.match_no = c.match_no
group by venue_name
having count (venue_name)=(SELECT MAX(mycount) 
FROM ((select venue_name , count(venue_name),mycount  from goal_details a
JOIN [dbo].[Soccer Country] b ON  b.country_id = a.team_id
JOIN soccer_venue d ON c.venue_id = d.venue_id
JOIN match_mast c ON a.match_no = c.match_no
group by venue_name)gd);

