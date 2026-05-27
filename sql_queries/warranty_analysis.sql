-- ============================================
-- WARRANTY ANALYSIS
-- Apple Retail Sales & Warranty Analysis
-- ============================================


-- ============================================
-- TOTAL WARRANTY CLAIMS
-- ============================================

SELECT 
    COUNT(*) AS total_warranty_claims
FROM warranty;


-- ============================================
-- WARRANTY CLAIMS BY REPAIR STATUS
-- ============================================

SELECT 
    repair_status,
    COUNT(*) AS total_claims
FROM warranty
GROUP BY repair_status
ORDER BY total_claims DESC;


-- ============================================
-- TOP 5 PRODUCTS WITH HIGHEST WARRANTY CLAIMS
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
-- WARRANTY CLAIMS BY PRODUCT CATEGORY
-- ============================================

SELECT 
    c.category_name,
    COUNT(w.claim_id) AS total_claims
FROM warranty w
JOIN sales s
    ON w.sale_id = s.sale_id
JOIN products p
    ON s.product_id = p.product_id
JOIN category c
    ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_claims DESC;


-- ============================================
-- AVERAGE CLAIM TIME (IN DAYS)
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
-- PRODUCTS WITH HIGHEST WARRANTY-TO-SALES RATIO
-- ============================================

SELECT 
    p.product_name,

    COUNT(w.claim_id) AS total_claims,

    COUNT(DISTINCT s.sale_id) AS total_sales,

    ROUND(
        COUNT(w.claim_id) * 100.0
        /
        COUNT(DISTINCT s.sale_id),
        2
    ) AS warranty_ratio_percentage

FROM sales s
JOIN products p
    ON s.product_id = p.product_id
LEFT JOIN warranty w
    ON s.sale_id = w.sale_id

GROUP BY p.product_name

HAVING COUNT(w.claim_id) > 0

ORDER BY warranty_ratio_percentage DESC;


-- ============================================
-- WARRANTY CLAIMS FILED WITHIN 180 DAYS
-- ============================================

SELECT 
    COUNT(*) AS claims_within_180_days
FROM warranty w
JOIN sales s
    ON w.sale_id = s.sale_id
WHERE (w.claim_date - s.sale_date) <= 180;


-- ============================================
-- STORE WITH HIGHEST WARRANTY CLAIM RATE
-- ============================================

SELECT 
    st.store_name,

    COUNT(w.claim_id) AS total_claims,

    COUNT(DISTINCT s.sale_id) AS total_sales,

    ROUND(
        COUNT(w.claim_id) * 100.0
        /
        COUNT(DISTINCT s.sale_id),
        2
    ) AS claim_rate_percentage

FROM sales s
JOIN stores st
    ON s.store_id = st.store_id
LEFT JOIN warranty w
    ON s.sale_id = w.sale_id

GROUP BY st.store_name

ORDER BY claim_rate_percentage DESC;


-- ============================================
-- CLAIM DISTRIBUTION BY COUNTRY
-- ============================================

SELECT 
    st.country,
    COUNT(w.claim_id) AS total_claims
FROM warranty w
JOIN sales s
    ON w.sale_id = s.sale_id
JOIN stores st
    ON s.store_id = st.store_id
GROUP BY st.country
ORDER BY total_claims DESC;


-- ============================================
-- END OF WARRANTY ANALYSIS
-- ============================================
