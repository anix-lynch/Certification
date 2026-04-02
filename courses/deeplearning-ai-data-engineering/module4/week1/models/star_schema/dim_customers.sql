-- Dimension table: Customers
-- This table contains the descriptive data (dimensions) about customers

SELECT
    {{ dbt_utils.generate_surrogate_key(['customerNumber']) }} AS customer_key,
    customerName AS customer_name,
    contactLastName AS customer_last_name,
    contactFirstName AS customer_first_name,
    phone,
    addressLine1 AS address_line_1,
    addressLine2 AS address_line_2,
    postalCode AS postal_code,
    city,
    state,
    country,
    creditLimit AS credit_limit
FROM {{ source('classicmodels', 'customers') }}
