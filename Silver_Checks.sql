
-- Replace the bronze keyword with silver.
-- ====================================================================
-- Checking 'silver.crm_cust_info'
-- ====================================================================
Select * from silver.crm_cust_info;

--to check the duplicate records in the primary key
SELECT cst_id, COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 or cst_id is NULL;


--check for unwanted spaces
--expectation = no results
SELECT cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

SELECT cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);

SELECT cst_gndr
FROM silver.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr);


--Data standardization & consistency
SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info;

SELECT DISTINCT cst_marital_status
FROM silver.crm_cust_info;

-- ====================================================================
-- Checking 'silver.crm_prd_info'
-- ====================================================================
--check for unwanted spaces
--expectation = no results
SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

--Check for NULLS or negative numbers(like negative price)
--expectation = no results
SELECT prd_cost
from silver.crm_prd_info
WHERE prd_cost < 0 or prd_cost IS NULL ; --Handle the nulls by replacing with 0


--checking the cat_id after suing the substring to match it with id in cat table ERP
--in ERP it is in the format of AC_BC but in CRM its in the format of AC-BC
SELECT DISTINCT id from silver.erp_px_cat_g1v2;

--Data Standardization and consistency
SELECT DISTINCT prd_line
FROM silver.crm_prd_info; --need to ask the expert from source systems about the abbrevations

--Check for invalid date orders
SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;
--For complex Transformations in SQL, I typically narrow it down to a specific example and brainstorm multiple solution approaches.

--Check for Invalide dates
SELECT NULLIF(sls_order_dt, 0) sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt <= 0 or LEN(sls_order_dt) != 8
or sls_order_dt > 20500101
or sls_order_dt < 19000101; --for example, company start date

--Check for invalid date orders
--Order date should always be less than the shipping dates/ due date

SELECT *
FROM silver.crm_sales_details
WHERE sls_ship_dt < sls_order_dt OR sls_order_dt > sls_due_dt ;

--CHECK Data consistency: between Sales, Quantity and Price
-- Sales = Quantity * Price
-- Values must not be Null, zero or negative
SELECT
sls_sales, sls_quantity, sls_price
FROM silver.crm_sales_details
Where sls_sales != sls_quantity*sls_price
OR sls_sales is NULL or sls_quantity is NULL or sls_price IS NULL
OR sls_sales <= 0 or sls_quantity <= 0 or sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;


--Identify out of range dates: check for very old birth dates and greater than current date
SELECT
bdate
FROM silver.erp_cust_az12
WHERE YEAR(bdate) < 1924 OR bdate > GETDATE();

--Data Standardization and consistency
SELECT DISTINCT gen
FROM silver.erp_cust_az12;

SELECT * FROM silver.erp_cust_az12;

--Checking IDs from both the tables before connecting
SELECT 
cid, 
cntry
FROM silver.erp_loc_a101;

SELECT cst_key FROM silver.crm_cust_info;

--Data Standardization and consistency
SELECT DISTINCT cntry
FROM silver.erp_loc_a101;


--Check for unwanted spaces
SELECT
id,
cat,
subcat,
maintenance
FROM bronze.erp_px_cat_g1v2;

SELECT * FROM bronze.erp_px_cat_g1v2
WHERE cat != TRIM(cat) OR subcat != TRIM(subcat) OR maintenance != TRIM(maintenance);


--Data Standardization and consistency
SELECT DISTINCT cat
FROM bronze.erp_px_cat_g1v2;

SELECT DISTINCT subcat
FROM bronze.erp_px_cat_g1v2;

SELECT DISTINCT maintenance
FROM bronze.erp_px_cat_g1v2;

-- For deleting duplicate rows.
SELECT * FROM (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY id, cat, subcat, maintenance ORDER BY id) AS rn
  FROM bronze.erp_px_cat_g1v2
) t WHERE rn > 1;

WITH CTE AS (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY id, cat, subcat, maintenance ORDER BY id) AS rn
  FROM bronze.erp_px_cat_g1v2
)
DELETE FROM CTE WHERE rn > 1;