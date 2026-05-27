-- ============================================
-- BUSINESS PROBLEMS & ANALYTICAL SQL QUERIES
-- Apple Retail Sales & Warranty Analysis
-- ============================================


-- ============================================
-- BUSINESS PROBLEM 1
-- Which store sold the highest number of units?
-- ============================================

SELECT 
    st.store_name,
    SUM(s.quantity) AS total_units_sold
FROM sales s
JOIN stores st
    ON s.store_id = st.store_id
GROUP BY st.store_name
ORDER BY total_units_sold DESC
LIMIT 1;


-- ============================================
-- BUSINESS PROBLEM 2
-- Which product category generated the highest revenue?
-- ============================================

SELECT 
    c.category_name,
    SUM(s.quantity * p.price) AS total_revenue
FROM sales s
JOIN products p
    ON s.product_id = p.product_id
JOIN category c
    ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_revenue DESC;


-- ============================================
-- BUSINESS PROBLEM 3
-- Top 5 products with highest warranty claims
-- ============================================

SELECT 
    p.product_name,
    COUNT(w.claim_id) AS total_claims
FROM warranty w
JOIN sales s
    ON w.sale_id = s.sale_id
JOIN products p
    ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_claims DESC
LIMIT 5;


-- ============================================
-- BUSINESS PROBLEM 4
-- Store-wise contribution to total sales quantity
-- ============================================

SELECT 
    st.store_name,
    SUM(s.quantity) AS total_quantity,
    ROUND(
        SUM(s.quantity) * 100.0 /
        (SELECT SUM(quantity) FROM sales),
        2
    ) AS contribution_percentage
FROM sales s
JOIN stores st
    ON s.store_id = st.store_id
GROUP BY st.store_name
ORDER BY contribution_percentage DESC;


-- ============================================
-- BUSINESS PROBLEM 5
-- Products launched before 2020 still generating sales
-- ============================================

SELECT DISTINCT
    p.product_name,
    p.launch_date
FROM products p
JOIN sales s
    ON p.product_id = s.product_id
WHERE p.launch_date < '2020-01-01'
ORDER BY p.launch_date;


-- ============================================
-- BUSINESS PROBLEM 6
-- Month with highest number of sales
-- ============================================

SELECT 
    EXTRACT(MONTH FROM sale_date) AS sales_month,
    COUNT(*) AS total_sales
FROM sales
GROUP BY sales_month
ORDER BY total_sales DESC
LIMIT 1;


-- ============================================
-- BUSINESS PROBLEM 7
-- Top 3 cities with highest product diversity
-- ============================================

SELECT 
    st.city,
    COUNT(DISTINCT s.product_id) AS unique_products
FROM sales s
JOIN stores st
    ON s.store_id = st.store_id
GROUP BY st.city
ORDER BY unique_products DESC
LIMIT 3;


-- ============================================
-- BUSINESS PROBLEM 8
-- Products with highest warranty-to-sales ratio
-- ============================================

SELECT 
    p.product_name,
    COUNT(w.claim_id) * 100.0 / COUNT(DISTINCT s.sale_id)
        AS warranty_ratio
FROM sales s
JOIN products p
    ON s.product_id = p.product_id
LEFT JOIN warranty w
    ON s.sale_id = w.sale_id
GROUP BY p.product_name
HAVING COUNT(w.claim_id) > 0
ORDER BY warranty_ratio DESC;


-- ============================================
-- BUSINESS PROBLEM 9
-- Average warranty claim time in days
-- ============================================

SELECT 
    ROUND(
        AVG(w.claim_date - s.sale_date),
        2
    ) AS avg_claim_days
FROM warranty w
JOIN sales s
    ON w.sale_id = s.sale_id;


-- ============================================
-- BUSINESS PROBLEM 10
-- Stores where every sale led to a warranty claim
-- ============================================

SELECT 
    st.store_name
FROM stores st
JOIN sales s
    ON st.store_id = s.store_id
LEFT JOIN warranty w
    ON s.sale_id = w.sale_id
GROUP BY st.store_name
HAVING COUNT(s.sale_id) = COUNT(w.claim_id);


-- ============================================
-- END OF BUSINESS PROBLEMS
-- ============================================
