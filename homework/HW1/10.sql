select id, round(avg_home_age,2) as home_player_age, round(avg_away_age,2) as away_player_age,
       round(result.home_overall_rating,2) as home_player_avg_rating, round(result.away_overall_rating,2) as away_player_avg_rating
from (
        select (
                    select avg(year( from_days( datediff( ma.date, P.birthday))))
                    from player P
                    where P.player_api_id = ma.home_player_1 
                        OR P.player_api_id = ma.home_player_2 
                        OR P.player_api_id = ma.home_player_3
                        OR P.player_api_id = ma.home_player_4
                        OR P.player_api_id = ma.home_player_5
                        OR P.player_api_id = ma.home_player_6
                        OR P.player_api_id = ma.home_player_7
                        OR P.player_api_id = ma.home_player_8
                        OR P.player_api_id = ma.home_player_9
                        OR P.player_api_id = ma.home_player_10
                        OR P.player_api_id = ma.home_player_11
                ) as avg_home_age,

                (
                    select avg(year( from_days( datediff( ma.date, P.birthday ))))
                    from player P
                    where P.player_api_id = ma.away_player_1
                        OR P.player_api_id = ma.away_player_2
                        OR P.player_api_id = ma.away_player_3
                        OR P.player_api_id = ma.away_player_4
                        OR P.player_api_id = ma.away_player_5
                        OR P.player_api_id = ma.away_player_6
                        OR P.player_api_id = ma.away_player_7
                        OR P.player_api_id = ma.away_player_8
                        OR P.player_api_id = ma.away_player_9
                        OR P.player_api_id = ma.away_player_10
                        OR P.player_api_id = ma.away_player_11
                ) as avg_away_age,

                (
                    select avg(overall_rating)
                    from player_attributes P
                    where
                        P.date between DATE_SUB(ma.date, INTERVAL 6 month) and ma.date
                        and
                        (P.player_api_id = ma.home_player_1
                        OR P.player_api_id = ma.home_player_2
                        OR P.player_api_id = ma.home_player_3
                        OR P.player_api_id = ma.home_player_4
                        OR P.player_api_id = ma.home_player_5
                        OR P.player_api_id = ma.home_player_6
                        OR P.player_api_id = ma.home_player_7
                        OR P.player_api_id = ma.home_player_8
                        OR P.player_api_id = ma.home_player_9
                        OR P.player_api_id = ma.home_player_10
                        OR P.player_api_id = ma.home_player_11)
                ) as home_overall_rating,

                (
                    select avg(P.overall_rating)
                    from player_attributes P
                    where
                        P.date between DATE_SUB(ma.date, INTERVAL 6 month) and ma.date
                        and
                        (P.player_api_id = ma.away_player_1
                        OR P.player_api_id = ma.away_player_2
                        OR P.player_api_id = ma.away_player_3
                        OR P.player_api_id = ma.away_player_4
                        OR P.player_api_id = ma.away_player_5
                        OR P.player_api_id = ma.away_player_6
                        OR P.player_api_id = ma.away_player_7
                        OR P.player_api_id = ma.away_player_8
                        OR P.player_api_id = ma.away_player_9
                        OR P.player_api_id = ma.away_player_10
                        OR P.player_api_id = ma.away_player_11)
                ) as away_overall_rating, ma.id

        from match_info ma
        where
        (ma.home_team_score-ma.away_team_score >=5 and (ma.B365A<ma.B365H or ma.SJA<ma.SJH or ma.WHA<ma.WHH))
        or (ma.away_team_score-ma.home_team_score >=5 and (ma.B365A>ma.B365H or ma.SJA>ma.SJH or ma.WHA>ma.WHH))

) as result
group by id
order by id;
