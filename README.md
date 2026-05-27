# Apple-retail-sales-analysis
SQL analysis of 1M+ Apple retail sales &amp; warranty records across 35 countries


## Project Overview
An end-to-end SQL analysis of Apple's global retail sales and warranty data — covering 1,040,191 transactions across 73 stores in 35 countries, 64 products across 10 categories, and 30,836 warranty claims spanning January 2019 to August 2024.

The goal was to move beyond surface-level reporting and answer real business questions: Which stores are underperforming? Which products generate the most warranty claims? Where is revenue growing — and where is it declining?

Total Revenue Analysed: $992,751,214

---

## Dataset Structure
5 relational tables joined across this schema:
| Table | Description | Rows |
|---|---|---|
| `sales` | Transaction-level sales records | 1,040,191 |
| `products` | 64 Apple products with pricing & launch dates | 64 |
| `stores` | 73 Apple retail stores across 25+ countries | 73 |
| `category` | 10 product categories (Laptop, Audio, Tablet etc.) | 10 |
| `warranty` | 30,836 warranty claims with repair status | 30,836 |

---

## Database Schema
### Entity Relationship Diagram

The following ER diagram represents the relational structure of the Apple retail sales database used in this project.

![ER Diagram](screenshots/er_diagram.PNG)

---

## Business Questions Answered
### Sales Performance
- Which stores generate the highest and lowest revenue globally?
- What are the top products by total units sold and revenue?
- How does sales performance vary year-over-year across countries?
- Which product categories contribute most to overall revenue?
- Which country markets are most and least valuable?

### Time-Series Analysis
- How do monthly and yearly sales trends look over a 5-year period?
- Which stores show consistent growth vs decline over time?
- What year-over-year growth patterns exist across regions?
- How did the 2022 revenue spike compare to surrounding years?

### Warranty & Product Reliability
- Which products have the highest warranty claim rates?
- What is the average time between purchase and warranty claim?
- How do warranty-to-sales ratios vary across product categories?
- What proportion of claims result in free replacement vs paid repair vs void?

---

## Key Insights
### Sales Performance

**Questions Asked:**
- Which stores generate the highest and lowest revenue globally?
- What are the top products by total revenue?
- Which product categories contribute most to overall revenue?
- Which country markets are most and least valuable?

**What the Data Revealed:**
> Smartphones and Laptops alone drive 74.6% of all revenue ($434M and $306M 
respectively), with the top 3 categories including Tablets ($102M) accounting 
for 85% of $992M+ total revenue. The bottom 5 categories combined contribute 
less than 3% — Apple's retail business is heavily concentrated in its flagship 
product lines, meaning one bad product cycle in any of these three categories 
could significantly impact overall performance.

> The MacBook Pro M1 Max (16-inch) is the single highest-revenue product at 
$145M — outearning the entire Desktop category ($94M) on its own. Two MacBook 
Pro variants together generated $261M, making Apple's premium laptop lineup the 
second-highest revenue driver after iPhones and proving that customers are 
willing to pay top dollar for flagship hardware.

> The USA dominates globally with $305M (30.8% of revenue), followed by Canada 
at $160M. Despite having fewer stores, Canadian locations consistently 
outperform many larger markets on a per-store basis — making it Apple's most 
efficient international market. On the other end, the 4 lowest-revenue stores 
globally are all in the UK — Apple Sheffield ($649K), Birmingham ($679K), 
Newcastle ($689K), and Manchester ($715K) — compared to top US stores 
generating $36M–$38M each. A 50x revenue gap between best and worst performers 
points to a significant regional strategy problem worth investigating.

---

### Time-Series Analysis
**Questions Asked:**
- How did revenue trend year-over-year from 2019 to 2024?
- Which years saw the sharpest growth and decline?
- What does the revenue trajectory tell us about Apple's retail cycle?

**What the Data Revealed:**
> Revenue grew strongly from $139M in 2019 to $296M in 2022 — a 112% increase 
over three years. The growth wasn't linear: 2020 saw a 45.5% jump, 2021 dipped 
slightly by 12%, then 2022 surged 66% to its peak. This pattern likely reflects 
a combination of post-COVID retail recovery and a strong product supercycle 
driven by Apple's M1 chip launch.

> 2023 then saw the sharpest reversal in the dataset — revenue fell 46.4% from 
$296M to $159M. This decline after three years of strong growth raises the most 
important strategic question in the entire analysis: is this the natural end of 
a product supercycle, early signs of market saturation, or the effect of broader 
macroeconomic conditions? Any executive receiving this report would make this 
the centrepiece of their next planning cycle.

---

### Warranty & Product Reliability
**Questions Asked:**
- Which product categories have the highest warranty claim rates?
- What proportion of claims result in free replacement vs paid repair vs void?
- How long after purchase are customers filing warranty claims?

**What the Data Revealed:**
> Subscription Services carry a 9.35% warranty claim rate — the highest of any 
category — despite contributing just 0.2% of total revenue. This is nearly 3x 
higher than Smartphones (3.46%) and 18x higher than Desktops (0.51%). A product 
generating almost no revenue while driving disproportionate customer complaints 
is a clear signal that either the product experience or the warranty 
classification process needs urgent review.

> Of 30,836 total warranty claims, 65.4% resulted in free replacement, 23.2% 
were voided, and only 11.4% were paid repairs. The high free replacement rate 
reflects Apple's generous warranty policy — but also a product failure rate that 
carries significant cost. Reducing free replacements by even 10% across the 
dataset would represent millions in savings annually.

> Customers file warranty claims on average 176 days after purchase — roughly 
6 months — with a range spanning from as early as 15 days to as late as 650 
days. The concentration around the 6-month mark suggests manufacturing or 
component issues that surface quickly under regular use rather than long-term 
wear and tear. This is precisely the window where quality control improvements 
would have the greatest impact.

---

## 📁 Project Structure

```
Apple-retail-sales-analysis/
│
├── 📂 datasets/
│   ├── sales.csv
│   ├── products.csv
│   ├── stores.csv
│   ├── category.csv
│   └── warranty.csv
│
├── 📂 queries/
│   └── apple_analysis.sql
│
└── 📄 README.md
```

---

## How to Run
1. Clone this repository
2. Set up PostgreSQL locally or use any SQL client (pgAdmin, DBeaver)
3. Create a new database and import all 5 CSV files as tables
4. Run queries from queries/apple_analysis.sql

---

## Skills Demonstrated
- Complex SQL joins across 5 relational tables
- CTEs (Common Table Expressions) for readable, layered queries
- Window Functions (LAG, LEAD, RANK, ROW_NUMBER) for time-series and ranking analysis
- Subqueries for filtered aggregations
- Year-over-year growth calculations
- Warranty-to-sales ratio analysis
- Revenue contribution and segmentation analysis

---

## 👤 Author
**Udit Narayan** 

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=flat-square&logo=linkedin)](https://www.linkedin.com/in/udit-narayan-7902aa293/)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-black?style=flat-square&logo=github)](https://github.com/udit-narayaan)
