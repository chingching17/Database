select home_winh.homewin_homesc as homewin_homesc , home_wina.homewin_awaysc as homewin_awaysc
		, away_winh.awaywin_homesc as awaywin_homesc, away_wina.awaywin_awaysc as awaywin_awaysc
 		,win.homewin as home_win_times , tie.tie as tietimes ,loss.loss as home_loss_times
from
(
	select sum(home_win.overall_rating) as homewin_homesc
	from
	(
	select distinct win_id.team_id,round(avg(pr.overall_rating), 2)as overall_rating
	from
	(select p2.player_api_id, p2.date, p2.overall_rating
	from
		(
		select player_api_id, max(date) as date
		from player_attributes
		group by player_api_id
		)p
	inner join player_attributes p2
	on p2.player_api_id = p.player_api_id and p2.date = p.date)pr,

		(
			select home_team_id as team_id, home_player_1 as t_id ,date
				from match_info a
				where a.home_team_score > a.away_team_score
			union
			select home_team_id as team_id, home_player_2 as t_id,date
				from match_info a
				where a.home_team_score > a.away_team_score
			union
			select home_team_id as team_id, home_player_3 as t_id,date
				from match_info a
				where a.home_team_score > a.away_team_score
			union
			select home_team_id as team_id, home_player_4 as t_id,date
				from match_info a
				where a.home_team_score > a.away_team_score
			union
			select home_team_id as team_id, home_player_5 as t_id,date
				from match_info a
				where a.home_team_score > a.away_team_score
			union
			select home_team_id as team_id, home_player_6 as t_id,date
				from match_info a
				where a.home_team_score > a.away_team_score
			union
			select home_team_id as team_id, home_player_7 as t_id,date
				from match_info a
				where a.home_team_score > a.away_team_score
			union
			select home_team_id as team_id, home_player_8 as t_id,date
				from match_info a
				where a.home_team_score > a.away_team_score
			union
			select home_team_id as team_id, home_player_9 as t_id,date
				from match_info a
				where a.home_team_score > a.away_team_score
			union
			select home_team_id as team_id, home_player_10 as t_id,date
				from match_info a
				where a.home_team_score > a.away_team_score
			union
			select home_team_id as team_id, home_player_11 as t_id,date
				from match_info a
				where a.home_team_score > a.away_team_score
			
		)win_id
	where win_id.t_id = pr.player_api_id and win_id.date > pr.date
	group by win_id.team_id
	)home_win
)home_winh,

(
	select sum(home_win_awaysc.overall_rating) as homewin_awaysc
	from
	(
	select distinct homewin_awayloss_away.team_id,round(avg(pr.overall_rating), 2)as overall_rating
	from
	(select p2.player_api_id, p2.date, p2.overall_rating
	from
		(
		select player_api_id, max(date) as date
		from player_attributes
		group by player_api_id
		)p
	inner join player_attributes p2
	on p2.player_api_id = p.player_api_id and p2.date = p.date)pr,

	(
		select away_team_id as team_id, away_player_1 as t_id ,date
			from match_info a
			where a.home_team_score > a.away_team_score
		union
		select away_team_id as team_id, away_player_2 as t_id,date
			from match_info a
			where a.home_team_score > a.away_team_score
		union
		select away_team_id as team_id, away_player_3 as t_id,date
			from match_info a
			where a.home_team_score > a.away_team_score
		union
		select away_team_id as team_id, away_player_4 as t_id,date
			from match_info a
			where a.home_team_score > a.away_team_score
		union
		select away_team_id as team_id, away_player_5 as t_id,date
			from match_info a
			where a.home_team_score > a.away_team_score
		union
		select away_team_id as team_id, away_player_6 as t_id,date
			from match_info a
			where a.home_team_score > a.away_team_score
		union
		select away_team_id as team_id, away_player_7 as t_id,date
			from match_info a
			where a.home_team_score > a.away_team_score
		union
		select away_team_id as team_id, away_player_8 as t_id,date
			from match_info a
			where a.home_team_score > a.away_team_score
		union
		select away_team_id as team_id, away_player_9 as t_id,date
			from match_info a
			where a.home_team_score > a.away_team_score
		union
		select away_team_id as team_id, away_player_10 as t_id,date
			from match_info a
			where a.home_team_score > a.away_team_score
		union
		select away_team_id as team_id, away_player_11 as t_id,date
			from match_info a
			where a.home_team_score > a.away_team_score
		
	)homewin_awayloss_away
	where homewin_awayloss_away.t_id = pr.player_api_id and homewin_awayloss_away.date > pr.date
	group by homewin_awayloss_away.team_id
	)home_win_awaysc
)home_wina,

(
	select sum(away_win.overall_rating) as awaywin_homesc
	from
	(
	select distinct home_loss_team_id.team_id,round(avg(pr.overall_rating), 2)as overall_rating
	from
	(select p2.player_api_id, p2.date, p2.overall_rating
	from
		(
		select player_api_id, max(date) as date
		from player_attributes
		group by player_api_id
		)p
	inner join player_attributes p2
	on p2.player_api_id = p.player_api_id and p2.date = p.date)pr,

	(
		select home_team_id as team_id, home_player_1 as t_id ,date
			from match_info a
			where a.home_team_score < a.away_team_score
		union
		select home_team_id as team_id, home_player_2 as t_id,date
			from match_info a
			where a.home_team_score < a.away_team_score
		union
		select home_team_id as team_id, home_player_3 as t_id,date
			from match_info a
			where a.home_team_score < a.away_team_score
		union
		select home_team_id as team_id, home_player_4 as t_id,date
			from match_info a
			where a.home_team_score < a.away_team_score
		union
		select home_team_id as team_id, home_player_5 as t_id,date
			from match_info a
			where a.home_team_score < a.away_team_score
		union
		select home_team_id as team_id, home_player_6 as t_id,date
			from match_info a
			where a.home_team_score < a.away_team_score
		union
		select home_team_id as team_id, home_player_7 as t_id,date
			from match_info a
			where a.home_team_score < a.away_team_score
		union
		select home_team_id as team_id, home_player_8 as t_id,date
			from match_info a
			where a.home_team_score < a.away_team_score
		union
		select home_team_id as team_id, home_player_9 as t_id,date
			from match_info a
			where a.home_team_score < a.away_team_score
		union
		select home_team_id as team_id, home_player_10 as t_id,date
			from match_info a
			where a.home_team_score < a.away_team_score
		union
		select home_team_id as team_id, home_player_11 as t_id,date
			from match_info a
			where a.home_team_score < a.away_team_score
		
	)home_loss_team_id
	where home_loss_team_id.t_id = pr.player_api_id and home_loss_team_id.date > pr.date
	group by home_loss_team_id.team_id
	)away_win
)away_winh,

(
	select sum(awaywin_awaysc.overall_rating) as awaywin_awaysc
	from
	(
	select distinct awaywin_away.team_id,round(avg(pr.overall_rating), 2)as overall_rating
	from
	(select p2.player_api_id, p2.date, p2.overall_rating
	from
		(
		select player_api_id, max(date) as date
		from player_attributes
		group by player_api_id
		)p
	inner join player_attributes p2
	on p2.player_api_id = p.player_api_id and p2.date = p.date)pr,

	(
		select away_team_id as team_id, away_player_1 as t_id ,date
			from match_info a
			where a.home_team_score < a.away_team_score
		union
		select away_team_id as team_id, away_player_2 as t_id,date
			from match_info a
			where a.home_team_score < a.away_team_score
		union
		select away_team_id as team_id, away_player_3 as t_id,date
			from match_info a
			where a.home_team_score < a.away_team_score
		union
		select away_team_id as team_id, away_player_4 as t_id,date
			from match_info a
			where a.home_team_score < a.away_team_score
		union
		select away_team_id as team_id, away_player_5 as t_id,date
			from match_info a
			where a.home_team_score < a.away_team_score
		union
		select away_team_id as team_id, away_player_6 as t_id,date
			from match_info a
			where a.home_team_score < a.away_team_score
		union
		select away_team_id as team_id, away_player_7 as t_id,date
			from match_info a
			where a.home_team_score < a.away_team_score
		union
		select away_team_id as team_id, away_player_8 as t_id,date
			from match_info a
			where a.home_team_score < a.away_team_score
		union
		select away_team_id as team_id, away_player_9 as t_id,date
			from match_info a
			where a.home_team_score < a.away_team_score
		union
		select away_team_id as team_id, away_player_10 as t_id,date
			from match_info a
			where a.home_team_score < a.away_team_score
		union
		select away_team_id as team_id, away_player_11 as t_id,date
			from match_info a
			where a.home_team_score < a.away_team_score
		
	)awaywin_away
	where awaywin_away.t_id = pr.player_api_id and awaywin_away.date > pr.date
	group by awaywin_away.team_id
	)awaywin_awaysc
)away_wina,

(select count(win_id.t_id) as homewin
from 
	(
		select home_team_id as t_id
		from match_info a
		where a.home_team_score > a.away_team_score

	)win_id
)win,

	(select count(tie_id.t_id) as tie
	from 
	(
		select home_team_id as t_id
		from match_info a
		where a.home_team_score = a.away_team_score
	
	)tie_id
)tie,
(select count(loss_id.t_id) as loss
from 
	(
		select home_team_id as t_id
		from match_info a
		where a.home_team_score < a.away_team_score
	
	)loss_id
)loss;