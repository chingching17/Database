select team.team_long_name, round(team_win.win_num/total.game_num,2) as win_rate
from team,
( 
    select a.team_id as team_id, (h.game_num + a.game_num) as game_num
    from 
        (
            select distinct home_team_id as team_id, count(home_team_id) as game_num
            from match_info
            group by home_team_id
        )h,
        (
            select distinct away_team_id as team_id, count(away_team_id) as game_num
            from match_info
            group by away_team_id
        )a
    where h.team_id = a.team_id
)total,

(
    select win_h.team_id as team_id, (win_h.game_num + win_a.game_num) as win_num
    from
        (
            select distinct m.home_team_id as team_id, count(m.home_team_id) as game_num
            from match_info m
            where m.home_team_score > m.away_team_score
            group by m.home_team_id
        )win_h,
        (
            select distinct m.away_team_id as team_id, count(m.away_team_id) as game_num
            from match_info m
            where m.away_team_score > m.home_team_score
            group by m.away_team_id
        )win_a
    where win_a.team_id = win_h.team_id
)team_win
where team_win.team_id = total.team_id and team.id = team_win.team_id;