-- ============================================
-- REVENUE ANALYSIS
-- Apple Retail Sales & Warranty Analysis
-- ============================================


-- ============================================
-- TOTAL REVENUE GENERATED
-- ============================================

SELECT 
    ROUND(
        SUM(s.quantity * p.price),
        2
    ) AS total_revenue
FROM sales s
JOIN products p
    ON s.product_id = p.product_id;


-- ============================================
-- REVENUE BY PRODUCT CATEGORY
-- ============================================

SELECT 
    c.category_name,

    ROUND(
        SUM(s.quantity * p.price),
        2
    ) AS total_revenue

FROM sales s
JOIN products p
    ON s.product_id = p.product_id
JOIN category c
    ON p.category_id = c.category_id

GROUP BY c.category_name

ORDER BY total_revenue DESC;


-- ============================================
-- TOP 10 REVENUE GENERATING PRODUCTS
-- ============================================

SELECT 
    p.product_name,

    ROUND(
        SUM(s.quantity * p.price),
        2
    ) AS total_revenue

FROM sales s
JOIN products p
    ON s.product_id = p.product_id

GROUP BY p.product_name

ORDER BY total_revenue DESC

LIMIT 10;


-- ============================================
-- COUNTRY-WISE REVENUE ANALYSIS
-- ============================================

SELECT 
    st.country,

    ROUND(
        SUM(s.quantity * p.price),
        2
    ) AS total_revenue

FROM sales s
JOIN products p
    ON s.product_id = p.product_id
JOIN stores st
    ON s.store_id = st.store_id

GROUP BY st.country

ORDER BY total_revenue DESC;


-- ============================================
-- STORE-WISE REVENUE ANALYSIS
-- ============================================

SELECT 
    st.store_name,

    ROUND(
        SUM(s.quantity * p.price),
        2
    ) AS total_revenue

FROM sales s
JOIN products p
    ON s.product_id = p.product_id
JOIN stores st
    ON s.store_id = st.store_id

GROUP BY st.store_name

ORDER BY total_revenue DESC;


-- ============================================
-- YEARLY REVENUE TREND
-- ============================================

SELECT 
    EXTRACT(YEAR FROM s.sale_date) AS sales_year,

    ROUND(
        SUM(s.quantity * p.price),
        2
    ) AS yearly_revenue

FROM sales s
JOIN products p
    ON s.product_id = p.product_id

GROUP BY sales_year

ORDER BY sales_year;


-- ============================================
-- MONTHLY REVENUE TREND
-- ============================================

SELECT 
    DATE_TRUNC('month', s.sale_date) AS sales_month,

    ROUND(
        SUM(s.quantity * p.price),
        2
    ) AS monthly_revenue

FROM sales s
JOIN products p
    ON s.product_id = p.product_id

GROUP BY sales_month

ORDER BY sales_month;


-- ============================================
-- AVERAGE REVENUE PER SALE
-- ============================================

SELECT 
    ROUND(
        AVG(s.quantity * p.price),
        2
    ) AS average_sale_value
FROM sales s
JOIN products p
    ON s.product_id = p.product_id;


-- ============================================
-- HIGHEST REVENUE GENERATING CATEGORY PER COUNTRY
-- ============================================

WITH country_category_revenue AS (

    SELECT 
        st.country,
        c.category_name,

        ROUND(
            SUM(s.quantity * p.price),
            2
        ) AS revenue,

        RANK() OVER (
            PARTITION BY st.country
            ORDER BY SUM(s.quantity * p.price) DESC
        ) AS revenue_rank

    FROM sales s
    JOIN products p
        ON s.product_id = p.product_id
    JOIN category c
        ON p.category_id = c.category_id
    JOIN stores st
        ON s.store_id = st.store_id

    GROUP BY st.country, c.category_name
)

SELECT 
    country,
    category_name,
    revenue
FROM country_category_revenue
WHERE revenue_rank = 1;


-- ============================================
-- REVENUE CONTRIBUTION BY CATEGORY
-- ============================================

SELECT 
    c.category_name,

    ROUND(
        SUM(s.quantity * p.price),
        2
    ) AS category_revenue,

    ROUND(
        SUM(s.quantity * p.price) * 100.0
        /
        (
            SELECT SUM(s2.quantity * p2.price)
            FROM sales s2
            JOIN products p2
                ON s2.product_id = p2.product_id
        ),
        2
    ) AS contribution_percentage

FROM sales s
JOIN products p
    ON s.product_id = p.product_id
JOIN category c
    ON p.category_id = c.category_id

GROUP BY c.category_name

ORDER BY contribution_percentage DESC;


-- ============================================
-- END OF REVENUE ANALYSIS
-- ============================================
