-- Dimension table: Date
-- This table contains the descriptive data (dimensions) about dates

{{ dbt_date.get_date_dimension("2003-01-01", "2005-12-31") }}
