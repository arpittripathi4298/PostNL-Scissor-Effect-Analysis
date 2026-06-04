SELECT * FROM PostNL_Cleaned_Analysis;


/* Identify Depots WHERE the Scissor Gap is 20% higher than the city average */

with ProvinceAverages as (select date,Province,Unite_Per_Cost_EUR,AVG(Unite_Per_Cost_EUR)over(partition by province) as Province_Avg_Daily
from PostNL_Cleaned_Analysis)
select * , round((Unite_Per_Cost_EUR - Province_Avg_Daily)/Province_Avg_Daily,2) as Inefficiency_Score
from ProvinceAverages
where Unite_Per_Cost_EUR > (Province_Avg_Daily * 1.2)
order by Inefficiency_Score desc;