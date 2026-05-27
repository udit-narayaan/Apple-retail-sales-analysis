-- ============================================
-- EXPLORATORY DATA ANALYSIS
-- Apple Retail Sales & Warranty Analysis
-- ============================================


-- ============================================
-- TOTAL RECORDS IN EACH TABLE
-- ============================================

SELECT COUNT(*) AS total_sales
FROM sales;

SELECT COUNT(*) AS total_products
FROM products;

SELECT COUNT(*) AS total_stores
FROM stores;

SELECT COUNT(*) AS total_categories
FROM category;

SELECT COUNT(*) AS total_warranty_claims
FROM warranty;


-- ============================================
-- UNIQUE COUNTRIES
-- ============================================

SELECT DISTINCT country
FROM stores
ORDER BY country;


-- ============================================
-- TOTAL STORES BY COUNTRY
-- ============================================

SELECT 
    country,
    COUNT(store_id) AS total_stores
FROM stores
GROUP BY country
ORDER BY total_stores DESC;


-- ============================================
-- PRODUCT COUNT BY CATEGORY
-- ============================================

SELECT 
    c.category_name,
    COUNT(p.product_id) AS total_products
FROM products p
JOIN category c
    ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_products DESC;


-- ============================================
-- PRICE RANGE ANALYSIS
-- ============================================

SELECT 
    MIN(price) AS minimum_price,
    MAX(price) AS maximum_price,
    ROUND(AVG(price), 2) AS average_price
FROM products;


-- ============================================
-- SALES DATE RANGE
-- ============================================

SELECT 
    MIN(sale_date) AS first_sale_date,
    MAX(sale_date) AS latest_sale_date
FROM sales;


-- ============================================
-- WARRANTY CLAIM DATE RANGE
-- ============================================

SELECT 
    MIN(claim_date) AS first_claim_date,
    MAX(claim_date) AS latest_claim_date
FROM warranty;


-- ============================================
-- TOP 10 MOST SOLD PRODUCTS
-- ============================================

SELECT 
    p.product_name,
    SUM(s.quantity) AS total_quantity_sold
FROM sales s
JOIN products p
    ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 10;


-- ============================================
-- TOTAL SALES BY COUNTRY
-- ============================================

SELECT 
    st.country,
    COUNT(s.sale_id) AS total_transactions
FROM sales s
JOIN stores st
    ON s.store_id = st.store_id
GROUP BY st.country
ORDER BY total_transactions DESC;


-- ============================================
-- WARRANTY CLAIM DISTRIBUTION
-- ============================================

SELECT 
    repair_status,
    COUNT(*) AS total_claims
FROM warranty
GROUP BY repair_status
ORDER BY total_claims DESC;


-- ============================================
-- END OF EXPLORATORY ANALYSIS
-- ============================================
