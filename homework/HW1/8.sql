select name, (homewin180 + awaywin180)/(home180 + away180) as prob
from league,
    (select A.league_id, homewin180, awaywin180
    from (select league_id, count(*) as homewin180 
        from match_info
        where id in (select match_id
            from player, (select  id as match_id, home_team_id as team_id, home_player_1 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all	
                        select id as match_id, home_team_id as team_id, home_player_2 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_3 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_4 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_5 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_6 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_7 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_8 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_9 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_10 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_11 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        -- away team
                        select  id as match_id, away_team_id as team_id, away_player_1 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all	
                        select id as match_id, away_team_id as team_id, away_player_2 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_3 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_4 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_5 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_6 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_7 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_8 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_9 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_10 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_11 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016') as my_table 
            where player.player_api_id = my_table.player_id
                AND side = 'H'
            group by match_id
            having avg(height) > 180)
            AND home_team_score > away_team_score
            AND season = '2015/2016'
        group by league_id)A,
        (select league_id, count(*) as awaywin180 
        from match_info
        where id in (select match_id
            from player, (select  id as match_id, home_team_id as team_id, home_player_1 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all	
                        select id as match_id, home_team_id as team_id, home_player_2 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_3 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_4 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_5 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_6 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_7 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_8 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_9 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_10 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_11 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        -- away team
                        select  id as match_id, away_team_id as team_id, away_player_1 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all	
                        select id as match_id, away_team_id as team_id, away_player_2 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_3 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_4 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_5 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_6 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_7 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_8 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_9 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_10 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_11 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016') as my_table 
            where player.player_api_id = my_table.player_id
                AND side = 'A'
            group by match_id
            having avg(height) > 180)
            AND away_team_score > home_team_score
            AND season = '2015/2016'
        group by league_id)B
    where A.league_id = B.league_id)A,
    (select A.league_id, home180, away180
    from (select league_id, count(*) as home180 
        from match_info
        where id in (select match_id
            from player, (select  id as match_id, home_team_id as team_id, home_player_1 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all	
                        select id as match_id, home_team_id as team_id, home_player_2 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_3 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_4 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_5 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_6 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_7 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_8 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_9 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_10 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_11 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        -- away team
                        select  id as match_id, away_team_id as team_id, away_player_1 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all	
                        select id as match_id, away_team_id as team_id, away_player_2 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_3 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_4 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_5 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_6 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_7 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_8 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_9 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_10 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_11 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016') as my_table 
            where player.player_api_id = my_table.player_id
                AND side = 'H'
            group by match_id
            having avg(height) > 180)
            AND season = '2015/2016'
        group by league_id)A
        ,(select league_id, count(*) as away180 
        from match_info
        where id in (select match_id
            from player, (select  id as match_id, home_team_id as team_id, home_player_1 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all	
                        select id as match_id, home_team_id as team_id, home_player_2 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_3 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_4 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_5 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_6 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_7 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_8 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_9 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_10 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, home_team_id as team_id, home_player_11 as player_id, home_team_score as score, 'H' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        -- away team
                        select  id as match_id, away_team_id as team_id, away_player_1 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all	
                        select id as match_id, away_team_id as team_id, away_player_2 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_3 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_4 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_5 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_6 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_7 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_8 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_9 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_10 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016'
                        union all
                        select id as match_id, away_team_id as team_id, away_player_11 as player_id, away_team_score as score, 'A' as side
                            from match_info
                            where season = '2015/2016') as my_table 
            where player.player_api_id = my_table.player_id
                AND side = 'A'
            group by match_id
            having avg(height) > 180)
            AND season = '2015/2016'
        group by league_id)B
    where A.league_id = B.league_id)B
where A.league_id = B.league_id
    AND A.league_id = league.id
order by name
;
