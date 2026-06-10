# 📱 Smartphone Market Intelligence Analysis Using SQL

## Project Overview

This project performs a comprehensive SQL-based analysis of a real-world smartphone market dataset containing **980 smartphone models** across **46 brands** and **26 attributes**. The analysis moves from basic data exploration to advanced business intelligence, answering 35 structured business questions that span market segmentation, brand positioning, technology adoption, pricing strategy, and customer satisfaction.

The goal is to demonstrate how SQL alone — without any external BI tool — can generate actionable insights comparable to what a data analyst would produce in a professional business environment.

---
## Executive Summary

This project analyzes 980 smartphone models across 46 brands using SQL to uncover market trends, pricing strategies, technology adoption patterns, and brand positioning.

Using 35 business-focused SQL analyses, I explored:

- Smartphone market segmentation
- Premium vs value-for-money brands
- 5G adoption trends
- Processor market share
- Camera and battery innovation
- Customer satisfaction drivers
- Brand portfolio strategies
- Advanced ranking and benchmarking techniques

The project demonstrates how SQL can be used beyond data extraction to solve real business problems through segmentation, KPI creation, statistical analysis, and decision-oriented insights.

## Featured Findings

- Xiaomi dominates Budget and Mid-Range segments with 117 combined models.
- Samsung leads the Premium segment with 20 models.
- Apple dominates the Flagship segment with 25 models.
- 5G smartphones cost 2.28× more than non-5G devices on average.
- Only 4.18% of smartphones contain all flagship features simultaneously.
- Doogee V Max achieved the highest composite smartphone score.
- Snapdragon powers 43% of smartphones in the dataset.
- Higher pricing does not necessarily lead to higher customer satisfaction.

## Dataset

| Attribute | Details |
|---|---|
| **Source** | Smartphones Cleaned Dataset (v6) |
| **Rows** | 980 |
| **Columns** | 26 |
| **Database** | MySQL (tested on MySQL Workbench 8.0) |
| **Table Name** | `smartphones` |

**Key Columns:**
`brand_name`, `model`, `price`, `rating`, `has_5g`, `has_nfc`, `has_ir_blaster`, `processor_brand`, `processor_speed`, `battery_capacity`, `fast_charging_available`, `fast_charging`, `ram_capacity`, `internal_memory`, `refresh_rate`, `primary_camera_rear`, `primary_camera_front`, `extended_memory_available`, `os`

---

## Project Structure

```
smartphone-sql-analysis/
│
├── smartphone_market_analysis.sql   # All 35 SQL queries
├── Smartphone_Market_Analysis_Questions.pdf  # Question set (4 levels)
├── Smartphone_Market_Analysis_Report.pdf     # Full insights report
└── README.md
```

---

## Analysis Structure — 4 Levels, 35 Questions

### 🟢 Level 1 — Basic Analysis (Q1–Q5)
Foundational queries to understand dataset structure and establish market baselines.

| Q# | Question |
|---|---|
| Q1 | Catalogue size — total records and distinct brand-model combinations |
| Q2 | Brand portfolio overview — model count per brand |
| Q3 | Budget 5G phones — phones under ₹15,000 with 5G |
| Q4 | Data quality audit — missing ratings count and percentage |
| Q5 | Market baseline metrics — average price, rating, battery, RAM, storage |

---

### 🟡 Level 2 — Business Analysis (Q6–Q17)
Brand benchmarking, feature adoption, and competitive market positioning.

| Q# | Question |
|---|---|
| Q6 | Price segment distribution — Budget / Mid-Range / Premium / Flagship |
| Q7 | Brand-wise average price and rating (brands with 5+ models) |
| Q8 | Premium brand identification — brands above market average price |
| Q9 | Value-for-money brands — above-avg rating, below-avg price |
| Q10 | Android vs iOS head-to-head comparison |
| Q11 | 5G price premium — average price gap between 5G and non-5G |
| Q12 | 5G adoption rate by brand |
| Q13 | Processor brand market share |
| Q14 | Fast charging brand analysis — average, min, max wattage |
| Q15 | Camera comparison — top 10 brands by rear camera MP |
| Q16 | Refresh rate vs price analysis — 60Hz / 90Hz / 120Hz / 144Hz+ |
| Q17 | Expandable storage impact on internal memory and pricing |

---

### 🟠 Level 3 — Intermediate Analysis (Q18–Q25)
Subquery-based filtering, NULL handling, multi-condition logic, and data quality checks.

| Q# | Question |
|---|---|
| Q18 | Hidden gem smartphones — below avg price, above avg rating |
| Q19 | Potentially overpriced smartphones — above avg price, below avg rating |
| Q20 | Battery capacity tiers and their relationship to ratings |
| Q21 | NULL handling — phones claiming fast charging with missing wattage |
| Q22 | Processor speed vs price and rating per chipset brand |
| Q23 | RAM tier distribution — pricing and storage by RAM capacity |
| Q24 | Fully-loaded phones — 5G + NFC + IR + Fast Charging + 120Hz+ + 8GB RAM |
| Q25 | High-resolution rear camera phones exceeding 100 MP |

---

### 🔴 Level 4 — Advanced SQL (Q26–Q35)
Window functions, CTEs, correlated subqueries, ranking, percentiles, and statistical measures.

| Q# | Question | Key Concept |
|---|---|---|
| Q26 | Highest-rated smartphone per brand | `RANK()` with `PARTITION BY` |
| Q27 | Price ranking within each brand | `RANK()` window function |
| Q28 | Price percentile within brand — Top Tier flag | `PERCENT_RANK()` |
| Q29 | Phones priced above their own brand's average | Correlated subquery |
| Q30 | Top 3 rated phones per brand — handling ties | `DENSE_RANK()` |
| Q31 | LAG and LEAD — price gap between adjacent phones | `LAG()` / `LEAD()` |
| Q32 | Brand consistency score — Coefficient of Variation | `STDDEV_POP()`, derived metric |
| Q33 | Brand ranking within price segments | CTE + `RANK()` + `PARTITION BY` |
| Q34 | Composite smartphone score — Top 20 leaderboard | Multi-column weighted formula |
| Q35 | Multi-CTE tier dominance — which brand dominates each segment | 3-CTE chain + `RANK()` |

---

## SQL Concepts Demonstrated

```
Basic          : SELECT, WHERE, GROUP BY, ORDER BY, HAVING, LIMIT
Aggregation    : COUNT, AVG, SUM, MIN, MAX, ROUND, STDDEV_POP
Conditional    : CASE WHEN, conditional aggregation (SUM + CASE)
Filtering      : IS NULL, IS NOT NULL, IN, AND/OR, BETWEEN
Subqueries     : Scalar subqueries, subqueries in HAVING and WHERE
Correlated     : Subquery referencing outer query's column (Q29)
Joins          : Derived table join (Q29 alternate approach)
CTEs           : Single CTE (Q33), multi-step chained CTEs (Q35)
Window Funcs   : RANK(), DENSE_RANK(), ROW_NUMBER()
               : PERCENT_RANK(), LAG(), LEAD()
               : PARTITION BY, ORDER BY within window frames
Derived Metrics: Percentage calculations, Coefficient of Variation,
               : Composite weighted scoring index
```

---

## Key Business Insights

- **Xiaomi dominates** the Budget and Mid-Range segments with 56 and 61 models respectively — the most diversified portfolio in the dataset.
- **Samsung leads Premium**, Apple dominates Flagship. Both follow distinct tier strategies rather than competing across all segments.
- **5G phones cost 2.28× more** on average (₹43,200 vs ₹18,917), yet 56% of phones in the dataset already support 5G — the tipping point has passed.
- **Higher price ≠ higher rating.** Apple averages ₹95,967 but rates 76.80 — lower than Android's 78.22. Vertu's ₹650,000 flagship rates just 62.
- **Best value brands:** Doogee, Nothing, and BLU deliver above-market ratings at below-market prices. Among mass-market brands: iQOO, Motorola, Poco.
- **Fast charging is a Chinese brand battleground.** Nubia (95W avg), OnePlus (76.3W), iQOO (75.3W) lead. Samsung averages just 24.1W, Apple 20.3W.
- **Only 4.18% of phones** are truly "fully-loaded" with all six premium features simultaneously (5G + NFC + IR + Fast Charging + 120Hz+ + 8GB RAM).
- **Composite leaderboard winner:** Doogee V Max — powered by a 22,000 mAh battery, 12GB RAM, 108MP camera, and an 88 rating.

---

## How to Run

1. Import `smartphones_cleaned_v6.csv` into MySQL Workbench as a table named `smartphones` in your chosen schema.
2. Open `smartphone_market_analysis.sql` in MySQL Workbench.
3. Run queries individually by question or select all and execute.
4. Cross-reference outputs with `Smartphone_Market_Analysis_Report.pdf` for business interpretation.

> All queries are written and tested on **MySQL 8.0**. Window functions (RANK, DENSE_RANK, PERCENT_RANK, LAG, LEAD) require MySQL 8.0+.

---

## Tools Used

| Tool | Purpose |
|---|---|
| MySQL Workbench 8.0 | Query writing and execution |
| Python (Pandas) | Dataset cleaning and pre-processing |
| SQL | Full analysis — 35 business questions |

---

## Author

**Anuj Oraon**  
🐙 [github.com/anujoraon799](https://github.com/anujoraon799)
https://www.linkedin.com/in/anuj-oraon-ab0a22298/

---

*This project is part of a SQL portfolio built to demonstrate real-world business analysis skills using structured query language across a complete analytics workflow — from data exploration to advanced business intelligence.*
