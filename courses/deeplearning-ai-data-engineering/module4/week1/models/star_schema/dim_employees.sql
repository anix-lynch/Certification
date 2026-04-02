-- Dimension table: Employees
-- This table contains the descriptive data (dimensions) about employees

SELECT
    {{ dbt_utils.generate_surrogate_key(['employeeNumber']) }} AS employee_key,
    lastName AS employee_last_name,
    firstName AS employee_first_name,
    extension,
    email,
    officeCode AS office_code,
    reportsTo AS reports_to,
    jobTitle AS job_title
FROM {{ source('classicmodels', 'employees') }}
