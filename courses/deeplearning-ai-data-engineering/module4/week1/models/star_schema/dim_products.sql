-- Dimension table: Products
-- This table contains the descriptive data (dimensions) about products

SELECT
    {{ dbt_utils.generate_surrogate_key(['productCode']) }} AS product_key,
    productName AS product_name,
    productLine AS product_line,
    productScale AS product_scale,
    productVendor AS product_vendor,
    productDescription AS product_description,
    quantityInStock AS quantity_in_stock,
    buyPrice AS buy_price,
    MSRP AS msrp
FROM {{ source('classicmodels', 'products') }}
