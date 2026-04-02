# Module 3 Week 3 - Advanced SQL Queries

**Grade: 95% (114/120)** ✅ PASSED

## Overview
Advanced SQL assignment demonstrating mastery of complex query techniques including CTEs, window functions, pivot tables, and date manipulation using a DVD rental database (Sakila).

## Key Concepts Demonstrated

### 1. Common Table Expressions (CTEs)
- Multi-level CTEs for modular query design
- Aggregations and filtering within CTEs

### 2. Window Functions
- `RANK()` - Ranking with ties
- `ROW_NUMBER()` - Sequential numbering
- `LAG()` - Access previous row values
- `LEAD()` - Access next row values
- `PARTITION BY` for grouped calculations

### 3. Advanced Techniques
- **Pivot Tables**: CASE WHEN with SUM for column transformation
- **Date Functions**: EXTRACT, EPOCH calculations for duration analysis
- **String Functions**: SUBSTRING, CONCAT for text manipulation
- **Subqueries**: Nested SELECT for complex filtering
- **CASE Statements**: Conditional logic for categorization

## Assignment Structure

### Complex Queries (Exercises 1-5)
- Multi-table JOINs with date filtering
- CTEs with aggregations (FLOOR/CEIL)
- Subqueries for above-average filtering
- CASE statements for value categorization
- Pivot tables with 10 category columns

### SQL Functions (Exercises 6-12)
- Date calculations (rental duration analysis)
- String manipulation (staff initials)
- Window functions (actor rankings)
- LAG/LEAD for month-over-month analysis

## Technical Highlights
- **Database**: PostgreSQL (Sakila DVD Rental schema)
- **Star Schema**: Fact table (rentals) with dimension tables (customers, films, categories, actors)
- **Query Complexity**: Multi-CTE queries with 3+ levels of nesting
- **Performance**: Efficient use of DISTINCT, proper indexing considerations

## Files
- `C3_W3_Assignment.ipynb` - Completed Jupyter notebook with all 12 exercises
- `CHECKPOINT.md` - Detailed progress log and key learnings
- `images/` - Entity-relationship diagrams
- `src/` - Database connection configuration

## Key Learnings
- Window functions are powerful for row-to-row comparisons without self-joins
- CTEs improve query readability and maintainability vs nested subqueries
- EXTRACT(EPOCH) is essential for accurate date arithmetic in PostgreSQL
- Pivot tables in SQL require careful CASE WHEN construction with aggregations

---

**Part of**: DeepLearning.AI Data Engineering Professional Certificate  
**Module**: 3 - Data Modeling and Transformation  
**Status**: Completed January 2026
