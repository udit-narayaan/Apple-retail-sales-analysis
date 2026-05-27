-- ============================================
-- TIME SERIES ANALYSIS
-- Apple Retail Sales & Warranty Analysis
-- ============================================


-- ============================================
-- YEAR-OVER-YEAR SALES REVENUE GROWTH
-- ============================================

WITH yearly_sales AS (
    SELECT 
        EXTRACT(YEAR FROM s.sale_date) AS sales_year,
        SUM(s.quantity * p.price) AS total_revenue
    FROM sales s
    JOIN products p
        ON s.product_id = p.product_id
    GROUP BY sales_year
)

SELECT 
    sales_year,
    total_revenue,
    LAG(total_revenue) OVER (
        ORDER BY sales_year
    ) AS previous_year_revenue,

    ROUND(
        (
            total_revenue -
            LAG(total_revenue) OVER (
                ORDER BY sales_year
            )
        ) * 100.0
        /
        LAG(total_revenue) OVER (
            ORDER BY sales_year
        ),
        2
    ) AS yoy_growth_percentage

FROM yearly_sales;


-- ============================================
-- MONTHLY REVENUE TREND
-- ============================================

SELECT 
    DATE_TRUNC('month', s.sale_date) AS sales_month,
    SUM(s.quantity * p.price) AS monthly_revenue
FROM sales s
JOIN products p
    ON s.product_id = p.product_id
GROUP BY sales_month
ORDER BY sales_month;


-- ============================================
-- RUNNING TOTAL OF SALES REVENUE
-- ============================================

WITH monthly_sales AS (
    SELECT 
        DATE_TRUNC('month', s.sale_date) AS sales_month,
        SUM(s.quantity * p.price) AS revenue
    FROM sales s
    JOIN products p
        ON s.product_id = p.product_id
    GROUP BY sales_month
)

SELECT 
    sales_month,
    revenue,

    SUM(revenue) OVER (
        ORDER BY sales_month
    ) AS running_total_revenue

FROM monthly_sales;


-- ============================================
-- MONTH-OVER-MONTH SALES DIFFERENCE
-- ============================================

WITH monthly_sales AS (
    SELECT 
        DATE_TRUNC('month', sale_date) AS sales_month,
        SUM(quantity) AS total_units
    FROM sales
    GROUP BY sales_month
)

SELECT 
    sales_month,
    total_units,

    LAG(total_units) OVER (
        ORDER BY sales_month
    ) AS previous_month_sales,

    total_units -
    LAG(total_units) OVER (
        ORDER BY sales_month
    ) AS sales_difference

FROM monthly_sales;


-- ============================================
-- TOP SELLING PRODUCT EACH YEAR
-- ============================================

WITH yearly_product_sales AS (
    SELECT 
        EXTRACT(YEAR FROM s.sale_date) AS sales_year,
        p.product_name,
        SUM(s.quantity) AS total_units_sold,

        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM s.sale_date)
            ORDER BY SUM(s.quantity) DESC
        ) AS product_rank

    FROM sales s
    JOIN products p
        ON s.product_id = p.product_id

    GROUP BY sales_year, p.product_name
)

SELECT 
    sales_year,
    product_name,
    total_units_sold
FROM yearly_product_sales
WHERE product_rank = 1;


-- ============================================
-- STORES WITH DECLINING YEARLY SALES
-- ============================================

WITH yearly_store_sales AS (
    SELECT 
        st.store_name,
        EXTRACT(YEAR FROM s.sale_date) AS sales_year,
        SUM(s.quantity) AS total_units,

        LAG(SUM(s.quantity)) OVER (
            PARTITION BY st.store_name
            ORDER BY EXTRACT(YEAR FROM s.sale_date)
        ) AS previous_year_sales

    FROM sales s
    JOIN stores st
        ON s.store_id = st.store_id

    GROUP BY st.store_name, sales_year
)

SELECT 
    store_name,
    sales_year,
    total_units,
    previous_year_sales
FROM yearly_store_sales
WHERE total_units < previous_year_sales;


-- ============================================
-- END OF TIME SERIES ANALYSIS
-- ============================================
