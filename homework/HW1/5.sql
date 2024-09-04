select distinct one_day.province, one_day.date
from 
    (
        select T.confirmed - t2.confirmed as confirmed, T.province , T.date
        from time_province t2, time_province T
        where T.province = t2.province and DATE_ADD(t2.date,INTERVAL 1 DAY) = T.date
    ) one_day,

    (
        select R2.province
        from region R2
        where R2.province = R2.city 
        and (select AVG(R.elderly_population_ratio) from region R where R.province = R.city) < R2.elderly_population_ratio 
              
    )ratio
where one_day.province = ratio.province
      and one_day.confirmed = 
        (
            select max(aa.confirmed)
            from 
                (
                    select T.confirmed - t2.confirmed as confirmed, T.province
                    from time_province t2,time_province T
                    where T.province = t2.province and DATE_ADD(t2.date,INTERVAL 1 DAY) = T.date
                ) aa
            where aa.province = one_day.province
        )
order by date;
