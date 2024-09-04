select province, city, elementary_school_count as cnt
from region 
where province <> city
order by elementary_school_count desc
limit 3
;