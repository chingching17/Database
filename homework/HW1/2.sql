select DISTINCT infection_case 
from patient_info 
where age < 30 and province = 'Seoul' and city = 'Gangnam-gu' and sex = 'male'
order by infection_case
;
