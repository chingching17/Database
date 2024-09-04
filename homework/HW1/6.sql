select S.date, S.coronavirus ,T.confirmed as confirmed_accumulated ,
     (
          select T.confirmed - T2.confirmed
          from time T2
          where T2.date = DATE_SUB(T.date,INTERVAL 1 DAY)
     ) as confirmed_add,
     
     T.deceased as dead_accumulated,

     (
          select T.deceased - T3.deceased
          from time T3
          where T3.date = DATE_SUB(T.date,INTERVAL 1 DAY)
     ) as dead_add
from
     (
         select S2.date, S2.coronavirus
         from search_trend S2
         where (2*(select std(coronavirus) from search_trend where date between '2019-12-25' and '2020-06-29')
               + (select avg(coronavirus) from search_trend where date between '2019-12-25' and '2020-06-29'))
              < S2.coronavirus
     ) S,
     time T
where  S.date = T.date;