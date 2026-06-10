SELECT count(*) FROM practice.smartphones;
use practice;
select * from smartphones;
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT brand_name) AS total_brands
FROM smartphones;
-- Q1 
SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT CONCAT(brand_name, ' | ', model))
	AS distinct_brand_model_combinations
FROM smartphones;
-- Q2
select brand_name, 
count(model) as total_no_of_models
from smartphones
group by brand_name
order by count(model) desc;

-- Q3 
select brand_name,  model, rating , price
from smartphones
where price <15000 and has_5g = true
order by price;
SELECT brand_name,
       COUNT(*) AS budget_5g_models
FROM smartphones
WHERE price < 15000
  AND has_5g = TRUE
GROUP BY brand_name
ORDER BY budget_5g_models DESC;

-- Q4
select count(*) as total_recodes,
sum(case when rating is null then 1 else 0 end) as missing_ratings,
round(sum(case when rating is null then 1 else 0 end)*100 / count(*),2) missing_percentage
from smartphones;

-- Q5
select round(avg(price),2) as avg_price,
round(avg(rating),2) as avg_rating,
round(avg(battery_capacity),2) as avg_battery_mah,
round(avg(ram_capacity),2) as avg_ram_gb,
round(avg(internal_memory),2) as avg_storage_gb
from smartphones;

-- Q6
select case 
			when price <15000 then 'Budget'
			when price between 15001 and 40000 then 'Mid_Range'
			when price between 40001 and 80000 then 'Premium'
			else 'Flagship'
		end as price_segment,
        count(*) as total_phones,
        round(avg(rating),2) as avg_rating
from smartphones
group by price_segment
order by case price_segment
			when 'Budget' then 1
            when 'Mid_Range' then 2 
            when 'Premium' then 3
            else 4
		end;

-- Q7
select brand_name,
	count(*) as total_models,
	round(avg(price),2) as avg_price,
	round(avg(rating),2) as avg_rating
from smartphones 
group by brand_name
having count(*) >= 5
order by avg_rating desc;

-- Q8
select brand_name,
	round(avg(price),2) as brand_avg_price,
    round((select avg(price) from smartphones),2)as market_avg_price
from smartphones
group by brand_name
having avg(price) > (select avg(price) from smartphones)
order by brand_avg_price desc;

-- Q9
select brand_name,
round(avg(price), 2) as avg_price,
round(avg(rating),2) as avg_rating
from smartphones
group by brand_name
having avg(rating) > (select avg(rating) from smartphones where rating is not null)
and avg(price) < (select avg(price) from smartphones)
order by avg(rating) desc;

-- Q10
select os,
	count(*) as total_phones,
    round(avg(price),2) as avg_price ,
    round(avg(rating),2) as avg_rating,
    round(avg(battery_capacity),2) as avg_battery_mah,
    round(avg(ram_capacity),2) as avg_ram_gb
from smartphones
where os in ('android','ios')
group by os 
order by os;

-- Q11
select case when has_5g = True then '5G' else 'Non-5G' end as connectivity,
count(*) as total_phones,
round(avg(price), 2) as avg_price
from smartphones
group by has_5g
order by has_5g desc;

-- Q12
select 
		brand_name,
        count(*) as total_models,
        sum(case when has_5g = true then 1 else 0 end ) as models_with_5g,
        round(sum(case when has_5g = true then 1 else 0 end) * 100.0 / count(*),2) as adoption_rate_pct
from smartphones
group by brand_name
having count(*) > 10 
order by adoption_rate_pct desc;

-- Q13
select processor_brand,
	count(*) as phones_count,
    round(count(*) * 100.0 / (select count(*) from smartphones where processor_brand is not null),2) as market_share_pct
from smartphones
where processor_brand is not null
group by processor_brand 
order by phones_count desc;

-- Q14
select brand_name,
count(*) as fast_charging_models,
avg(fast_charging) as avg_wattage,
min(fast_charging) as min_wattage,
max(fast_charging) as max_wattage
from smartphones 
where fast_charging_available = 1 and fast_charging is not null
group by brand_name
having count(*) >= 3
order by avg_wattage desc;

-- Q15
select brand_name,
round(avg(primary_camera_rear),1) as avg_rear_mp,
round(avg(primary_camera_front),1) as avg_front_mp,
count(*) as total_models
from smartphones
group by brand_name
order by avg_rear_mp desc
limit 10;

-- Q16
select case 	
	when refresh_rate = 60 then '60Hz'
    when refresh_rate = 90 then '90Hz'
    when refresh_rate = 120 then '120Hz'
    else '144Hz+'
    end as refresh_rate_bucket,
	count(*) as total_phones,
    round(avg(price),2) as avg_price,
    round(avg(rating), 2) as avg_rating
from smartphones
group by refresh_rate_bucket
order by case refresh_rate_bucket
	when '60Hz' then 1
    when '90Hz' then 2
    when '120Hz' then 3
    else 4
    end;

-- Q17
select 
	case when extended_memory_available = 1 then 'Expandable' else 'No Expandable'
    end as memory_type,
    count(*) as total_phones,
    round(avg(internal_memory),2) as avg_internal_storage_gb,
    round(avg(price),2) as avg_price
from smartphones
group by extended_memory_available
order by extended_memory_available desc;

-- Q18
select brand_name,
		model,
        price,
        rating 
from smartphones 
where rating is not null and price < (select avg(price) from smartphones)
	and rating > (select avg(rating) from smartphones where rating is not null)
order by rating desc;

-- Q19
select brand_name,
model,
price,
rating
from smartphones
where rating is NOT null 
and price > (select avg(price) from smartphones)
and rating < (select avg(rating) from smartphones where rating is not null)
order by price desc, rating asc

-- Q20
select 	
	case when battery_capacity < 3000 then 'Low(< 3000mAh)'
    when battery_capacity between  3000 and 4499 then 'Standard(3000 - 4499 mAh)'
    when battery_capacity between 4500 and 4999 then 'High(4500 - 4999mAh)'
    else 'Ultra (5000+ mAh)'
end as battery_tier,
count(*) as total_phones,
round(avg(rating), 2) as avg_rating
from smartphones
where battery_capacity is not null
group by battery_tier
order by case battery_tier when 'Low(< 3000mAh)' then 1
	when 'Standard(3000 - 4499 mAh)' then 2
	when 'High(4500 - 4999mAh)' then 3 
	else 4 
end;

-- Q21
select 
	count(*) as phones_with_missing_wattage
from smartphones
where fast_charging_available = 1 and fast_charging is null;

SELECT
    fast_charging_available,
    SUM(CASE WHEN fast_charging IS NULL THEN 1 ELSE 0 END) AS null_wattage,
    SUM(CASE WHEN fast_charging IS NOT NULL THEN 1 ELSE 0 END) AS has_wattage,
    COUNT(*) AS total
FROM smartphones
GROUP BY fast_charging_available;

-- Q22
select processor_brand,
	count(*) as phone_count,
    round(avg(processor_speed), 2) as avg_processor_speed_ghz,
    round(avg(price), 2)as avg_price,
    round(avg(rating), 2) as avg_rating
from smartphones
where processor_brand  is not null
	and processor_speed is not null
group by processor_brand
order by avg_processor_speed_ghz desc;

-- Q23
select case
		when ram_capacity = 4 then '4 GB'
        when ram_capacity = 6 then '6 GB'
        when ram_capacity = 8 then '8 GB'
        when ram_capacity = 12 then '12 GB'
        when ram_capacity = 16 then '16 GB'
        else 'Other'
	end as ram_tier,
    count(*) as total_phones,
    round(avg(price),2) as avg_price,
    round(avg(internal_memory), 2) as avg_storage_gb
    from smartphones
    group by ram_tier
    order by case ram_tier
		when '4 GB' then 1
        when '6 GB' then 2
        when '8 GB' then 3
        when '12 GB' then 4
        when '16 GB' then 5
        else 6
	end;
    
-- Q24
select brand_name,
	model,
    price,
    rating,
    round((select count(*) from smartphones where has_5g = true
			and has_nfc = true 
            and has_ir_blaster = true
            and fast_charging_available = 1 
            and refresh_rate >= 120
            and ram_capacity >= 8) * 100.0/ (select count(*) from smartphones),2) as pct_of_catalogue
from smartphones
where has_5g = true
			and has_nfc = true 
            and has_ir_blaster = true
            and fast_charging_available = 1 
            and refresh_rate >= 120
            and ram_capacity >= 8
order by price desc;

-- Q25
select brand_name,
	model,
    primary_camera_rear as rear_camera_mp,
    primary_camera_front as front_camera_mp,
    price
from smartphones
where primary_camera_rear > 100
order by primary_camera_rear desc;

-- Q26
select brand_name,
	model,
    price,
    rating
from ( select brand_name, model, price, rating,
		rank() over(partition by brand_name order by rating desc) as rnk
        from smartphones
        where rating is not null
) ranked
where rnk = 1 
order by brand_name;

-- Q27
select 
	brand_name,
    model,
    price,
    rank() over( 
		partition by brand_name order by price desc
    ) as price_rank
from smartphones
order by brand_name, price_rank;

-- Q28
select 	
	brand_name,
    model,
    price,
    round(price_percentile, 2) as price_percentile,
    case when price_percentile >= 0.90 then 'Top Tier' else 'Standard' end as tier_flag
    from (
		select brand_name,
        model,
        price,
        percent_rank() over( partition by brand_name order by price ) as price_percentile
        from smartphones
    )pct
    order by brand_name, price desc;

-- Q29
select s.brand_name,
		s.model,
        s.price as phone_price,
        round(brand_avg.avg_price, 2) as brand_avg_price
from smartphones s 
join (
		select brand_name,
        avg(price) as avg_price
        from smartphones
        group by brand_name
) brand_avg
	on s.brand_name = brand_avg.brand_name
where s.price > brand_avg.avg_price
order by s.brand_name, s.price desc;

-- Q30
select brand_name,
model,
rating,
dense_rnk as rating_rank
from (
	select brand_name,
    model,
    rating,
    dense_rank() over(partition by brand_name order by rating desc) as dense_rnk
    from smartphones
    where rating is not null
)dr
where dense_rnk <= 3
order by brand_name, dense_rnk;

-- Q31
select brand_name,
model, 
price as current_price,
lag(price) over(order by price) as prev_phone_price,
lead(price) over(order by price) as next_phone_price,
lead(price) over(order by price)- price as gap_to_next_tier
from smartphones
order by price;

-- Q32
select brand_name,
	count(*) as total_models,
    round(avg(price), 2) as avg_price,
    round(stddev_pop(price), 2) as price_stddev,
    round(stddev_pop(price)/ avg(price) * 100,2)as coeff_of_variation_pct
    from smartphones
    group by brand_name
    having count(*) >= 5
    order by coeff_of_variation_pct asc;

-- Q33
with segmented as (
		select brand_name,
        case when price < 15000 then 'Budget'
        when price between 15000 and 40000 then 'Mid-Range'
        when price between 40001 and 80000 then 'Premium'
        else 'Flagship'
        end as price_segment,
        rating 
        from smartphones
        where rating is not null
),
brand_segment_avg as (
	select
		price_segment,
        brand_name,
        round(avg(rating), 2) as avg_rating,
        count(*) as model_count
	from segmented
    group by price_segment, brand_name
)
select price_segment,
		brand_name,
        avg_rating,
        model_count,
        rank() over(
			partition by price_segment order by avg_rating desc
        ) as rank_within_segment
	from brand_segment_avg
    order by case price_segment
    when 'Budget' then 1
    when 'Mid-Range' then 2
    when 'Premium' then 3
    else 4
    end,
    rank_within_segment;

-- Q34
select 
	brand_name,
    model,
    price,
    rating,
    battery_capacity,
    ram_capacity,
    primary_camera_rear,
    round(
		(rating/ 89.0 *40) +
        (battery_capacity / 22000.0 * 20) +
        (ram_capacity / 18.0 * 20)+
        (primary_camera_rear / 200.0 * 20),   2) as composite_score
from smartphones
where rating is not null
and battery_capacity is not null
and ram_capacity is not null
and primary_camera_rear is not null
order by composite_score desc
limit 20;

-- Q35
with segmented as (
	select
    brand_name, 
    case when price < 15000 then 'Budget' 
    when price between 15000 and 40000 then 'Mid-Range'
    when price between 40001 and 80000 then 'Premium'
    else 'Flagship'
    end as price_segment 
    from smartphones
),
brand_tier_counts as (
	select price_segment,
    brand_name,
    count(*) as model_count 
    from segmented
    group by price_segment, brand_name
),
ranked as (
		select 
			price_segment,
            brand_name,
            model_count,
            rank() over(partition by price_segment order by model_count desc) as rnk
            from brand_tier_counts
)
select
	price_segment,
    brand_name as dominant_brand,
    model_count as models_in_segment
from ranked
where rnk = 1
order by case price_segment
		when 'Budget' then 1
        when 'Mid-Range' then 2
        when 'Premium' then 3
        else 4
        end;