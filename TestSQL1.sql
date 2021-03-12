select
	country.country_name_eng AS tk,
	sum(case when call.id is null then 1 else 0 end) as calls,
	avg(isnull(datediff(second, call.start_time, call.end_time),0)) as avg_difference
from countrycodes AS country 
left join citystatescountries on city.country_id = country.id
left join customer on city.id = customer.city_id
left join call on call.customer_id = customer.id
group by 
	country.id,
	country.country_name_eng
having avg(isnull(datediff(second, call.start_time, call.end_time_ampm),0)) > (select avg(datediff(second, call.start_time, call.end_time)) from call)
order by calls desc, country.id asc;

-- comment 2
--- current date