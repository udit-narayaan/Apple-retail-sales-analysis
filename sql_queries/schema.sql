-- ============================================
-- APPLE RETAIL SALES & WARRANTY ANALYSIS
-- Database Schema Creation
-- ============================================


-- ============================================
-- CATEGORY TABLE
-- ============================================

CREATE TABLE category (
    category_id VARCHAR(10) PRIMARY KEY,
    category_name VARCHAR(50)
);


-- ============================================
-- PRODUCTS TABLE
-- ============================================

CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(150),
    category_id VARCHAR(10),
    launch_date DATE,
    price NUMERIC(10,2),

    CONSTRAINT fk_category
        FOREIGN KEY (category_id)
        REFERENCES category(category_id)
);


-- ============================================
-- STORES TABLE
-- ============================================

CREATE TABLE stores (
    store_id VARCHAR(10) PRIMARY KEY,
    store_name VARCHAR(100),
    city VARCHAR(100),
    country VARCHAR(100)
);


-- ============================================
-- SALES TABLE
-- ============================================

CREATE TABLE sales (
    sale_id VARCHAR(20) PRIMARY KEY,
    sale_date DATE,
    store_id VARCHAR(10),
    product_id VARCHAR(10),
    quantity INT,

    CONSTRAINT fk_store
        FOREIGN KEY (store_id)
        REFERENCES stores(store_id),

    CONSTRAINT fk_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);


-- ============================================
-- WARRANTY TABLE
-- ============================================

CREATE TABLE warranty (
    claim_id VARCHAR(20) PRIMARY KEY,
    claim_date DATE,
    sale_id VARCHAR(20),
    repair_status VARCHAR(50),

    CONSTRAINT fk_sale
        FOREIGN KEY (sale_id)
        REFERENCES sales(sale_id)
);


-- ============================================
-- END OF SCHEMA
-- ============================================
