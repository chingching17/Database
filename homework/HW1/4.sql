select province , count(province) as cnt
from region R, weather W
where R.code = W.code and W.date like '2016-05-%' and W.avg_relative_humidity > 70
group by province
order by cnt desc
limit 3
;
