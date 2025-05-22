/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs quality checks to validate the integrity, consistency, 
    and accuracy of the Gold Layer. These checks ensure:
    - Uniqueness of surrogate keys in dimension tables.
    - Referential integrity between fact and dimension tables.
    - Validation of relationships in the data model for analytical purposes.

Usage Notes:
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/

select * from silver.crm_cust_info;


--Check for the duplicates after Joining the tables
SELECT cst_id, count(*) as count
FROM
(SELECT 
ci.cst_id, 
ci.cst_key,
ci.cst_firstname,
ci.cst_lastname,
ci.cst_marital_status,
ci.cst_gndr,
ci.cst_create_date,
ca.bdate,
ca.gen,
la.cntry
FROM silver.crm_cust_info AS ci
LEFT JOIN silver.erp_cust_az12 ca
ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
on ci.cst_key = la.cid) AS t
GROUP BY cst_id
HAVING COUNT(*) > 1;


-- THere are 2 columns gen and cst_gen created with the same values. need to integrate them.
SELECT DISTINCT
ci.cst_gndr,
ca.gen,
CASE
	WHEN cst_gndr != 'n/a' THEN ci.cst_gndr
	ELSE COALESCE(ca.gen, 'n/a')
END as new_gen
FROM silver.crm_cust_info AS ci
LEFT JOIN silver.erp_cust_az12 ca
ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
on ci.cst_key = la.cid
ORDER BY 1,2;

--Quality Checks of the GOLD table 
SELECT * FROM gold.dim_customers;

SELECT DISTINCT gender FROM gold.dim_customers;


--Foreign Key Integrity (Dimensions)
-- Check if all dimension tables can successfully join to the fact table
SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE c.customer_key is NULL; 