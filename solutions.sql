---netflix project--
drop table if exists netflix;
create table netflix(
  show_id VARCHAR(6),
  type	VARCHAR(10),
  title	VARCHAR(150),
  director	VARCHAR(208),
  casts	VARCHAR(1000),
  country VARCHAR(150),	
  date_added  VARCHAR(50), 	
  release_year INT,	
  rating  VARCHAR(10),	
  duration	VARCHAR(15),
 listed_in	VARCHAR(100),
 description VARCHAR(250)

);
select * from netflix;

select 
    count(*) as total_content
from netflix;

---15 questions--
--1. count the number of movies vs tv shows
 select
 type,
 count(*) as total_content
 from netflix
 group by type

 2 find the most common rating fotr the movie shows
  select 
  type,
  rating
  from 
 ( 
 select 
 type,
 rating,
 count(*),
 rank() over(partition by type order by count(*)desc)as ranking
 from netflix 
 group by 1,2
 )as t1
 where 
 ranking =1
 --order by 1,3 desc
 
 --3. select all the movies relaesed in a specific year 
 select *from netflix
 where 
 type ='Movie'
 and 
 release_year=2020

 --4 find the top 5 countries with the most content on netflix
 SELECT
      UNNEST(STRING_TO_ARRAY(country, ','))as new_country,
      COUNT(show_id)as total_content
 FROM netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
 SELECT 
    UNNEST (STRING_TO_ARRAY(country,','))as new_country
  FROM netflix

  --IDENTIFY THE LONGEST MOVIE--
  SELECT *FROM netflix
   where 
   type ='Movie'
   and
   duration=(select max(duration)from netflix)
--6th find content added in the last 5 years 
select *from netflix
where 
   date_added=current_date-interval '5 years'
   select current_date-interval '5 years'


   --7 find all the movies by director 'rajiv chilaka'
   select*from netflix
   where director like'%Rajiv Chilaka%'

 --8 list all tv shows with more than 5 seasons 
 select 
     *
     --split_part(duration,'',1) as sessions
from netflix
where 
	 type='Tv show'
	 and
	 split_part(duration,'',1)::numeric >5

select 
split_part('apple bannana cherry','',1)

 --9 count the number of content items in each gere
 select 
 unnest(string_to_array(listed_in,',')) as genre,
 count(show_id)
 from netflix
 group by 1


  --10 find the each year and the average numbers of content released by india on netflix
  select
  EXTRACT(YEAR FROM TO_DATE(date_added,'Month DD,YYYY'))as year,
  count(*),
  count(*)::NUMERIC/(select count(*) from netflix where country='India')::NUMERIC *100 as avg_content_per_year 
  from netflix
 where country ='India'
 group by 1

 --11 LIST ALL MOVIES THAT ARE DOCUMENTRIES
 select *from netflix
 where 
      listed_in ilike'%documentries%'
--12th find all the content without a director
select *from netflix
 where 
 director is null
      
13 
select *from netflix
where
casts ilike'%salman khan%'
and 
release_year>extract(year from current_date)-10
14 
top ten actor appeared i in india
select
--show_id,
--casts,
unnest(string_to_array(casts,','))as actors,
count(*) as total_content
from netflix
where country ilike 'India'
group by 1
order by 2 desc
limit 10

 15 
 select 
 *,
 case
 when 
    description ilike '%kill%' or
       description ilike '%violence%' then 'bad_film'
	   else 'good content'
	   end category
 
 from netflix
 where
 description ilike '%kill%'
 or
description ilike '%violence%'

