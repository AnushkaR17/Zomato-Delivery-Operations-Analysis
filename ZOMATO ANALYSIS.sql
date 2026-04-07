CREATE TABLE zomato_delivery (
    id VARCHAR(15),
    delivery_person_id VARCHAR(50),
    delivery_person_age NUMERIC,
    delivery_person_ratings NUMERIC,
    order_date DATE,
    time_ordered TIME,
    time_order_picked TIME,
    weather_conditions VARCHAR(50),
    road_traffic_density VARCHAR(50),
    type_of_order VARCHAR(50),
    type_of_vehicle VARCHAR(50),
    multiple_deliveries NUMERIC,
    festival VARCHAR(10),
    city_type VARCHAR(50),
    time_taken NUMERIC,
    distance_km NUMERIC,
    delivery_status VARCHAR(50),
    payment_method VARCHAR(50),
    order_value NUMERIC,
    vehicle_condition VARCHAR(20)
);



--Overall Business Metrics
SELECT 
count(*) as total_orders,
sum(order_value) as total_revenue,
avg(order_value) as avg_order_value,
avg(time_taken) as avg_time
FROM zomato_delivery;


--City Type Performance
SELECT 
city_type,
count(*) as total_orders,
avg(time_taken) as avg_time,
sum(order_value) as revenue
FROM zomato_delivery
GROUP BY city_type;


--Traffic Impact On Delivery Time
SELECT 
road_traffic_density,
avg(time_taken) as avg_time
FROM zomato_delivery
GROUP BY road_traffic_density
ORDER BY avg_time desc;


--Weather Impact Analysis
SELECT 
weather_conditions,
avg(time_taken) as avg_delivery_time
FROM zomato_delivery
GROUP BY weather_conditions;

--Vehicle Condition Effect
SELECT 
vehicle_condition,
count(*) as total_orders,
avg(time_taken) as avg_time
FROM zomato_delivery
GROUP BY vehicle_condition;

--Delivery partner Performance
SELECT 
delivery_person_id,
count(*) as orders_done,
avg(time_taken) as avg_time,
avg(delivery_person_ratings) as avg_rating
FROM zomato_delivery
GROUP BY delivery_person_id
ORDER BY avg_rating desc;


--Multiple Deliveries Imapct
SELECT 
multiple_deliveries,
avg(time_taken) as avg_time
FROM zomato_delivery
GROUP BY multiple_deliveries;

--Payment Method
SELECT 
payment_method,
count(*) as total_orders,
sum(order_value) as total_revenue
FROM zomato_delivery
GROUP BY payment_method;


--Rating VS Delivery Time
SELECT 
CASE 
    WHEN delivery_person_ratings >= 4 THEN 'High'
    WHEN delivery_person_ratings >= 3 THEN 'Medium'
    ELSE 'Low'
END as rating_category,
avg(time_taken) as avg_time
FROM zomato_delivery
GROUP BY rating_category;


--Top 5 Fast Delivery Partner
SELECT delivery_person_id, avg_time
FROM (
    SELECT 
    delivery_person_id,
    avg(time_taken) as avg_time,
    rank() over(order by avg(time_taken)) as rnk
    FROM zomato_delivery
    GROUP BY delivery_person_id
) t
WHERE rnk <= 5;


--High Value Orders
SELECT 
count(*) as high_value_orders
FROM zomato_delivery
WHERE order_value > 700;



SELECT 
type_of_order,
sum(order_value) as revenue
FROM zomato_delivery
GROUP BY type_of_order
ORDER BY revenue desc;

