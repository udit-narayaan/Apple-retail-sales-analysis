-- ============================================
-- ADVANCED SQL ANALYSIS
-- Apple Retail Sales & Warranty Analysis
-- ============================================


-- ============================================
-- PRODUCTS SOLD IN ALL COUNTRIES
-- ============================================

SELECT 
    p.product_name
FROM products p
JOIN sales s
    ON p.product_id = s.product_id
JOIN stores st
    ON s.store_id = st.store_id

GROUP BY p.product_name

HAVING COUNT(DISTINCT st.country) = (
    SELECT COUNT(DISTINCT country)
    FROM stores
);


-- ============================================
-- STORES THAT SOLD PRODUCTS FROM ALL CATEGORIES
-- ============================================

SELECT 
    st.store_name
FROM stores st
JOIN sales s
    ON st.store_id = s.store_id
JOIN products p
    ON s.product_id = p.product_id

GROUP BY st.store_name

HAVING COUNT(DISTINCT p.category_id) = (
    SELECT COUNT(DISTINCT category_id)
    FROM category
);


-- ============================================
-- MOST FREQUENTLY SOLD CATEGORY PER COUNTRY
-- ============================================

WITH country_category_sales AS (

    SELECT 
        st.country,
        c.category_name,
        SUM(s.quantity) AS total_units_sold,

        RANK() OVER (
            PARTITION BY st.country
            ORDER BY SUM(s.quantity) DESC
        ) AS category_rank

    FROM sales s
    JOIN stores st
        ON s.store_id = st.store_id
    JOIN products p
        ON s.product_id = p.product_id
    JOIN category c
        ON p.category_id = c.category_id

    GROUP BY st.country, c.category_name
)

SELECT 
    country,
    category_name,
    total_units_sold
FROM country_category_sales
WHERE category_rank = 1;


-- ============================================
-- PRODUCTS SOLD WITHIN 7 DAYS OF LAUNCH
-- ============================================

SELECT DISTINCT
    p.product_name,
    p.launch_date,
    s.sale_date
FROM products p
JOIN sales s
    ON p.product_id = s.product_id

WHERE s.sale_date <= p.launch_date + INTERVAL '7 days'

ORDER BY p.launch_date;


-- ============================================
-- STORES THAT NEVER SOLD PRODUCTS ABOVE $1000
-- ============================================

SELECT 
    st.store_name
FROM stores st
JOIN sales s
    ON st.store_id = s.store_id
JOIN products p
    ON s.product_id = p.product_id

GROUP BY st.store_name

HAVING MAX(p.price) <= 1000;


-- ============================================
-- PRODUCTS WITH MORE THAN 3 CLAIMS
-- WITHIN 30 DAYS OF SALE
-- ============================================

SELECT 
    p.product_name,
    COUNT(w.claim_id) AS total_claims

FROM warranty w
JOIN sales s
    ON w.sale_id = s.sale_id
JOIN products p
    ON s.product_id = p.product_id

WHERE (w.claim_date - s.sale_date) <= 30

GROUP BY p.product_name

HAVING COUNT(w.claim_id) > 3

ORDER BY total_claims DESC;


-- ============================================
-- SALES WITH QUANTITY GREATER THAN
-- 3 TIMES PRODUCT AVERAGE
-- ============================================

WITH avg_product_sales AS (

    SELECT 
        product_id,
        AVG(quantity) AS avg_quantity
    FROM sales
    GROUP BY product_id
)

SELECT 
    s.sale_id,
    p.product_name,
    s.quantity,
    aps.avg_quantity

FROM sales s
JOIN avg_product_sales aps
    ON s.product_id = aps.product_id
JOIN products p
    ON s.product_id = p.product_id

WHERE s.quantity > (aps.avg_quantity * 3)

ORDER BY s.quantity DESC;


-- ============================================
-- FASTEST WARRANTY CLAIMS
-- ============================================

SELECT 
    p.product_name,
    w.claim_id,
    (w.claim_date - s.sale_date) AS days_to_claim

FROM warranty w
JOIN sales s
    ON w.sale_id = s.sale_id
JOIN products p
    ON s.product_id = p.product_id

ORDER BY days_to_claim ASC

LIMIT 5;


-- ============================================
-- PRODUCTS NOT SOLD IN LAST YEAR
-- BUT STILL HAVING WARRANTY CLAIMS
-- ============================================

SELECT DISTINCT
    p.product_name

FROM products p
JOIN sales s
    ON p.product_id = s.product_id
JOIN warranty w
    ON s.sale_id = w.sale_id

WHERE p.product_id NOT IN (

    SELECT DISTINCT product_id
    FROM sales
    WHERE sale_date >= CURRENT_DATE - INTERVAL '1 year'
);


-- ============================================
-- CATEGORY WITH HIGHEST PRICE VARIANCE
-- ============================================

SELECT 
    c.category_name,

    ROUND(
        VARIANCE(p.price),
        2
    ) AS price_variance

FROM products p
JOIN category c
    ON p.category_id = c.category_id

GROUP BY c.category_name

ORDER BY price_variance DESC;


-- ============================================
-- END OF ADVANCED ANALYSIS
-- ============================================
