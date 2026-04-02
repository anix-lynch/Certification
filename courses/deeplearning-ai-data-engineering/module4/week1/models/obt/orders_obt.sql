-- One Big Table (OBT): Sales Overview
-- This table denormalizes the star schema into a single wide table for analytics

SELECT
    f.fact_order_key,
    f.customer_key,
    f.employee_key,
    f.office_code,
    f.product_key,
    f.order_date,
    f.order_required_date,
    f.order_shipped_date,
    f.quantity_ordered,
    f.product_price,
    c.customer_name,
    c.city AS customer_city,
    c.country AS customer_country,
    e.employee_first_name,
    e.employee_last_name,
    o.city AS office_city,
    o.country AS office_country,
    p.product_name,
    p.product_line
FROM {{ ref('fact_orders') }} f
LEFT JOIN {{ ref('dim_customers') }} c ON f.customer_key = c.customer_key
LEFT JOIN {{ ref('dim_employees') }} e ON f.employee_key = e.employee_key
LEFT JOIN {{ ref('dim_offices') }} o ON f.office_code = o.office_code
LEFT JOIN {{ ref('dim_products') }} p ON f.product_key = p.product_key
