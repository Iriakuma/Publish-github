/*Tables were created using create table and import data option*/
select *
from abtimedata;

select *
from abtestconv;
--checking for null values
select *
from abtestconv
where abtestconv is null;

select count(*) as "count of users"
from abtestconv;
select count(*)
from abtimedata;

--checking the structure of the data 
select column_name, data_type
from information_schema.columns
where table_schema = 'public' and
table_name = 'abtestconv';

select test_group,count(test_group) as "count of test group"
from abtestconv
group by conversion
order by 2 desc;

select test_group,conversion, count(conversion) as "conversion"
from abtestconv
group by conversion, 1
order by 2;

--percentage of true(converted) in experimental group
with true_ad_conv as (
select count(conversion) as conv_count
from abtestconv
where conversion = 'TRUE'
and test_group ='ad'),
total_ad_users as(
select count(test_group) as total_ad_count	
from abtestconv
where test_group ='ad')
select round(true_ad_conv.conv_count/total_ad_users.total_ad_count,4)*100 as percentage_of_converted 
from true_ad_conv
cross join total_ad_users;

--percentage of false(unconverted) in experimental group 
with false_ad_conv as (
select count(conversion) as conv_count
from abtestconv
where conversion = 'FALSE'
and test_group ='ad'),
total_psa_users as(
select count(test_group) as total_psa_count	
from abtestconv
where test_group ='ad')
select round(false_ad_conv.conv_count/total_psa_users.total_psa_count,4)*100 as percentage_of_unconverted
from false_ad_conv
cross join total_psa_users;

--percentage of true(converted) in control group
with true_psa_conv as (
select count(conversion) as conv_count
from abtestconv
where conversion = 'TRUE'
and test_group ='psa'),
total_psa_users as(
select count(test_group) as total_psa_count	
from abtestconv
where test_group ='psa')
select round(true_psa_conv.conv_count/total_psa_users.total_psa_count,4)*100 as percentage_of_converted 
from true_psa_conv
cross join total_psa_users;

--percentage of false(unconverted) in control group
with false_psa_conv as (
select count(conversion) as conv_count
from abtestconv
where conversion = 'FALSE'
and test_group ='psa'),
total_psa_users as(
select count(test_group) as total_psa_count	
from abtestconv
where test_group ='psa')
select round(false_psa_conv.conv_count/total_psa_users.total_psa_count,4)*100 as percentage_of_unconverted 
from false_psa_conv
cross join total_psa_users;

--How many of the conversions can be attributed to the add
with conv as(
select count(conversion) as countc
from abtestconv
where conversion = 'TRUE'),
total as (select count(user_id) as totalu
from abtestconv)
select round((conv.countc/total.totalu) * 100,2) as total_perc_conv
from conv
cross join total;

select most_ad_days, count(ab.most_ad_days) as "count of ads"
from abtestconv ac
join abtimedata ab
on ac.user_id = ab.user_id
where conversion ='TRUE'
group by ab.most_ad_days
Order by 2 desc;

select most_ad_hour, count(ab.most_ad_hour) as "count of ads hour"
from abtestconv ac
join abtimedata ab
on ac.user_id = ab.user_id
where conversion ='TRUE' and test_group = 'ad'
group by 1
Order by 2 desc;

--The idea of the dataset is to analyze the groups, find if the ads
--were successful, and 
--if the difference between the groups is statistically significant.


select test_group, conversion, count(conversion)
from abtestconv
group by test_group,conversion;

--conversion rate:






;
