select distinct year_team.team_long_name, round(win_team.avg_winsc,2) as avg_win_score
from 
	(
        select win_score.id, avg(win_sc) as avg_winsc
        from (
            select a.home_team_id as id , a.home_team_score - a.away_team_score as win_sc
            from match_info a
            where  a.season = '2015/2016'
            union all
            select a.away_team_id as id , a.away_team_score - a.home_team_score as win_sc
            from match_info a
            where a.season = '2015/2016'
        ) win_score
        group by win_score.id
    ) win_team,

	(
		select T.id, T.team_long_name,
		(
			(
				(
					select count(tie_team_id.team_id)
					from (
						select home_team_id as team_id
						from match_info a
						where a.home_team_score = a.away_team_score and a.season = '2015/2016'
						union all
						select away_team_id as team_id
						from match_info a
						where a.home_team_score = a.away_team_score and a.season = '2015/2016'
					)tie_team_id
					where tie_team_id.team_id = T.id
				)*1
				+
				(
					select count(win_team_id.team_id)
					from (
						select home_team_id as team_id
						from match_info a
						where a.home_team_score > a.away_team_score and a.season = '2015/2016'
						union all
						select away_team_id as team_id
						from match_info a
						where a.home_team_score < a.away_team_score and a.season = '2015/2016'
					)win_team_id
					where win_team_id.team_id = T.id
				)*2
			)
			/
			(
				select count(game_num.team_id)
				from 
				(
					select home_team_id as team_id
					from match_info a
					where a.season = '2015/2016'
					union all
					select away_team_id as team_id
					from match_info a
					where a.season = '2015/2016'
				)game_num
				where game_num.team_id = T.id
			)

		)sc
		from team T
		order by sc desc , T.team_long_name
		limit 5
    )year_team
where win_team.id = year_team.id
;