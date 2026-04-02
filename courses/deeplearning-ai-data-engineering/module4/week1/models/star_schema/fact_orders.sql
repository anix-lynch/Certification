-- Fact table: Orders
-- This table contains the transactional data (facts) about orders

SELECT
    {{ dbt_utils.generate_surrogate_key(['od.orderNumber', 'od.productCode']) }} AS fact_order_key,
    {{ dbt_utils.generate_surrogate_key(['o.customerNumber']) }} AS customer_key,
    {{ dbt_utils.generate_surrogate_key(['c.salesRepEmployeeNumber']) }} AS employee_key,
    e.officeCode AS office_code,
    {{ dbt_utils.generate_surrogate_key(['od.productCode']) }} AS product_key,
    o.orderDate AS order_date,
    o.requiredDate AS order_required_date,
    o.shippedDate AS order_shipped_date,
    od.quantityOrdered AS quantity_ordered,
    od.priceEach AS product_price
FROM {{ source('classicmodels', 'orderdetails') }} od
INNER JOIN {{ source('classicmodels', 'orders') }} o 
    ON od.orderNumber = o.orderNumber
INNER JOIN {{ source('classicmodels', 'customers') }} c 
    ON o.customerNumber = c.customerNumber
INNER JOIN {{ source('classicmodels', 'employees') }} e 
    ON c.salesRepEmployeeNumber = e.employeeNumber
