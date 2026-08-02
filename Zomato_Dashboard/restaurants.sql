SELECT * FROM public.restaurants;


-- 1. Top 15 cuisines by number of restaurants offering them
SELECT
    TRIM(cuisine)      AS cuisine,
    COUNT(*)           AS no_of_restaurants
FROM restaurants,
     unnest(string_to_array(cuisines, ',')) AS cuisine
GROUP BY TRIM(cuisine)
ORDER BY no_of_restaurants DESC
LIMIT 15;

-- 2. Average rating & average cost by cuisine (min. 20 restaurants)
SELECT
    TRIM(cuisine)                                     AS cuisine,
    COUNT(*)                                          AS no_of_restaurants,
    ROUND(AVG(rating) FILTER (WHERE rating > 0)::NUMERIC,2)   AS avg_rating,
    ROUND(AVG(cost_for_two_people)::NUMERIC, 2)                AS avg_cost_for_two
FROM restaurants,
     unnest(string_to_array(cuisines, ',')) AS cuisine
GROUP BY TRIM(cuisine)
HAVING COUNT(*) >= 20
ORDER BY avg_rating DESC
LIMIT 15;

-- 3. Number of distinct cuisines offered per restaurant (multi-cuisine places)
SELECT
    name,
    location,
    array_length(string_to_array(cuisines, ','), 1) AS no_of_cuisines
FROM restaurants
ORDER BY no_of_cuisines DESC
LIMIT 15;

SELECT name, location, rating, votes, cost_for_two_people
FROM restaurants
WHERE rating >= 4.5 AND votes >= 1000
ORDER BY rating DESC, votes DESC
LIMIT 20;


-- 4. Rating bucket distribution
SELECT
    CASE
        WHEN rating = 0            THEN 'Not Rated'
        WHEN rating <= 2.5          THEN 'Poor'
        WHEN rating <= 3.5          THEN 'Average'
        WHEN rating <= 4.0          THEN 'Good'
        WHEN rating <= 4.5          THEN 'Very Good'
        ELSE 'Excellent'
    END AS rating_bucket,
    COUNT(*) AS no_of_restaurants
FROM restaurants
GROUP BY rating_bucket
ORDER BY MIN(rating);
--bucket
-- 5. Restaurants with zero rating, broken down by location (data-quality view)
SELECT
    location,
    COUNT(*) AS unrated_count
FROM restaurants
WHERE rating = 0
GROUP BY location
ORDER BY unrated_count DESC
LIMIT 10;


-- 6. Rank every restaurant within its own location by rating (window function)
SELECT
    name,
    location,
    rating,
    RANK() OVER (PARTITION BY location ORDER BY rating DESC) AS rank_in_location
FROM restaurants
WHERE rating > 0
ORDER BY location, rank_in_location
LIMIT 30;

-- 7. Cost-for-two buckets
SELECT
    CASE
        WHEN cost_for_two_people < 300  THEN 'Budget'
        WHEN cost_for_two_people < 600  THEN 'Affordable'
        WHEN cost_for_two_people < 1000 THEN 'Mid-range'
        WHEN cost_for_two_people < 1500 THEN 'Premium'
        ELSE 'Fine Dining (₹1500+)'
    END AS price_tier,
    COUNT(*)                                          AS no_of_restaurants,
    ROUND(AVG(rating) FILTER (WHERE rating > 0)::NUMERIC,2)             AS avg_rating
FROM restaurants
GROUP BY price_tier
ORDER BY MIN(cost_for_two_people);


-- 8. Top 10 most expensive restaurants
SELECT name, location, cost_for_two_people, rating
FROM restaurants
ORDER BY cost_for_two_people DESC
LIMIT 10;

-- 9. Best-value restaurants: high rating, low cost
SELECT name, location, rating, cost_for_two_people
FROM restaurants
WHERE rating >= 4.0 AND cost_for_two_people <= 500
ORDER BY rating DESC, cost_for_two_people ASC
LIMIT 20;

-- 10. City-level summary: outlets, avg rating, avg cost, online-order adoption
SELECT
    listing_city AS city,
    COUNT(*) AS no_of_outlets,
    ROUND(AVG(rating) FILTER (WHERE rating > 0)::NUMERIC, 2) AS avg_rating,
    ROUND(AVG(cost_for_two_people)::NUMERIC, 2) AS avg_cost_for_two_people,
    ROUND(
        (100.0 * COUNT(*) FILTER (WHERE online_order) / COUNT(*))::NUMERIC,
        2
    ) AS online_order_pct
FROM restaurants
GROUP BY listing_city
ORDER BY no_of_outlets DESC;

-- 11. Which city has the highest table-booking availability
SELECT
    listing_city AS city,
    ROUND(100.0 * COUNT(*) FILTER (WHERE book_table) / COUNT(*), 1) AS booking_table_pct
FROM restaurants
GROUP BY listing_city
HAVING COUNT(*) >= 50
ORDER BY booking_table_pct DESC
LIMIT 10;

-- 12. Restaurants offering BOTH online ordering and table booking
SELECT COUNT(*) AS both_facilities_count
FROM restaurants
WHERE online_order = TRUE AND book_table = TRUE;

-- 13. Online-order adoption rate by restaurant type
SELECT
    rest_type,
    COUNT(*)                                                          AS no_of_restaurants,
    ROUND(100.0 * COUNT(*) FILTER (WHERE online_order) / COUNT(*), 1) AS online_order_pct
FROM restaurants
GROUP BY rest_type
HAVING COUNT(*) >= 30
ORDER BY online_order_pct DESC
LIMIT 15;

-- 14. Running total of votes, ordered by rating descending (window function)
SELECT
    name,
    rating,
    votes,
    SUM(votes) OVER (ORDER BY rating DESC, votes DESC) AS running_total_votes
FROM restaurants
ORDER BY rating DESC, votes DESC;


-- 15. Restaurants serving a specific cuisine, sorted by rating
SELECT name, location, cuisines, rating
FROM restaurants
WHERE cuisines ILIKE '%biryani%'
ORDER BY rating DESC
LIMIT 20;

-- 16. Chains present in more than 10 different locations
SELECT
    name,
    COUNT(DISTINCT location) AS no_of_locations,
    COUNT(*)                 AS no_of_outlets,
    ROUND(AVG(rating) FILTER (WHERE rating > 0)::NUMERIC,2) AS avg_rating
FROM restaurants
GROUP BY name
HAVING COUNT(DISTINCT location) > 10
ORDER BY no_of_locations DESC;


CREATE OR REPLACE VIEW restaurants_summary AS
SELECT
    r.*,
 
    --  Rating band
    CASE
        WHEN r.rating = 0   THEN 'Not Rated'
        WHEN r.rating < 2.5 THEN 'Poor'
        WHEN r.rating < 3.5 THEN 'Average'
        WHEN r.rating < 4.0 THEN 'Good'
        WHEN r.rating < 4.5 THEN 'Very Good'
        ELSE 'Excellent'
    END AS rating_band,
 
    -- price tier
    CASE
        WHEN r.cost_for_two_people < 300  THEN 'Budget'
        WHEN r.cost_for_two_people < 600  THEN 'Affordable'
        WHEN r.cost_for_two_people < 1000 THEN 'Mid-range'
        WHEN r.cost_for_two_people < 1500 THEN 'Premium'
        ELSE 'Fine Dining'
    END AS price_tier,
 
    -- facility combo label
    CASE
        WHEN r.online_order AND r.book_table       THEN 'Online Order + Table Booking'
        WHEN r.online_order AND NOT r.book_table    THEN 'Online Order Only'
        WHEN NOT r.online_order AND r.book_table    THEN 'Table Booking Only'
        ELSE 'No Facilities'
    END AS facility_type

FROM restaurants r;
 
SELECT * FROM restaurants_summary;


















