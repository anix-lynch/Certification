-- Dimension table: Offices
-- This table contains the descriptive data (dimensions) about offices

SELECT
    officeCode AS office_code,
    city,
    phone,
    addressLine1 AS address_line_1,
    addressLine2 AS address_line_2,
    state,
    country,
    postalCode AS postal_code,
    territory
FROM {{ source('classicmodels', 'offices') }}
