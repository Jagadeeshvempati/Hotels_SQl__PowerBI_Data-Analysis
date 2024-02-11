use Project_Hotel_DataAnalysis;


--Making All same header column datasets to one
with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$']
)

select arrival_date_year, hotel, round(sum((stays_in_week_nights+stays_in_weekend_nights)*adr),2) as Revenue,
ROW_NUMBER() OVER (ORDER BY SUM((stays_in_week_nights + stays_in_weekend_nights) * adr) DESC) AS Revenue_Rank
from hotels
group by arrival_date_year, hotel;



--Combining the Market Segments to hotels data
with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$']
)

select *
from hotels
left join dbo.market_segment$
on hotels.market_segment = dbo.market_segment$.market_segment
left join dbo.meal_cost$
on dbo.meal_cost$.meal = hotels.meal;