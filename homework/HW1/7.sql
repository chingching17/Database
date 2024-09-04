select distinct pr.preferred_foot, round(avg(pr.long_shots), 2)as avg_long_shots
from 
(select p2.player_api_id, p2.date, p2.long_shots, p2.preferred_foot
from
	(
	select player_api_id, max(date) as date
	from player_attributes
	group by player_api_id
	)p
inner join player_attributes p2
on p2.player_api_id = p.player_api_id and p2.date = p.date)pr
,
(
	select home_player_1 as id
		from match_info
		where league_id = 10257 and season = '2015/2016'
	union	
	select home_player_2 as id
		from match_info
		where league_id = 10257 and season = '2015/2016'
	union
	select home_player_3 as id
		from match_info
		where league_id = 10257 and season = '2015/2016'
	union
	select home_player_4 as id
		from match_info
		where league_id = 10257 and season = '2015/2016'
	union
	select home_player_5 as id
		from match_info
		where league_id = 10257 and season = '2015/2016'
	union
	select home_player_6 as id
		from match_info
		where league_id = 10257 and season = '2015/2016'
	union
	select home_player_7 as id
		from match_info
		where league_id = 10257 and season = '2015/2016'
	union
	select home_player_8 as id
		from match_info
		where league_id = 10257 and season = '2015/2016'
	union
	select home_player_9 as id
		from match_info
		where league_id = 10257 and season = '2015/2016'
	union
	select home_player_10 as id
		from match_info
		where league_id = 10257 and season = '2015/2016'
	union
	select home_player_11 as id
		from match_info
		where league_id = 10257 and season = '2015/2016'
	union
	select away_player_1 as id
		from match_info
		where league_id = 10257 and season = '2015/2016'
	union
	select away_player_2 as id
		from match_info
		where league_id = 10257 and season = '2015/2016'
	union
	select away_player_3 as id
		from match_info
		where league_id = 10257 and season = '2015/2016'
	union
	select away_player_4 as id
		from match_info
		where league_id = 10257 and season = '2015/2016'
	union
	select away_player_5 as id
		from match_info
		where league_id = 10257 and season = '2015/2016'
	union
	select away_player_6 as id
		from match_info
		where league_id = 10257 and season = '2015/2016'
	union
	select away_player_7 as id
		from match_info
		where league_id = 10257 and season = '2015/2016'
	union
	select away_player_8 as id
		from match_info
		where league_id = 10257 and season = '2015/2016'
	union
	select away_player_9 as id
		from match_info
		where league_id = 10257 and season = '2015/2016'
	union
	select away_player_10 as id
		from match_info
		where league_id = 10257 and season = '2015/2016'
	union
	select away_player_11 as id
		from match_info
		where league_id = 10257 and season = '2015/2016'
)tmp
where tmp.id = pr.player_api_id
group by pr.preferred_foot
;