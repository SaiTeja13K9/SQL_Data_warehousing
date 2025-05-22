/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

EXEC bronze.load_bronze

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 
	BEGIN TRY
		PRINT '================================================================================================================='
		PRINT 'Loading Bronze Layer';
		PRINT '================================================================================================================='

		PRINT '-----------------------------------------------------------------------------------------------------------------'
		PRINT 'Loading CRM Tables";
		PRINT '-----------------------------------------------------------------------------------------------------------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info; --first we are making the table empty and we start loading from the scratch.
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\saite\OneDrive - UNT System\Skills\SQL\SQl_Data_warehousing_project_from_scratch\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2, --skip the first raw as it contains column names. actual data starts from the second row.
			FIELDTERMINATOR = ',', --delimiter is ,
			TABLOCK --to improve the performance, where you are locking the entire table during loading it 
		);  
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';


		TRUNCATE TABLE bronze.crm_prd_info; --first we are making the table empty and we start loading from the scratch.
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\saite\OneDrive - UNT System\Skills\SQL\SQl_Data_warehousing_project_from_scratch\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2, --skip the first raw as it contains column names. actual data starts from the second row.
			FIELDTERMINATOR = ',', --delimiter is ,
			TABLOCK --to improve the performance, where you are locking the entire table during loading it 
		);  

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_sales_details; --first we are making the table empty and we start loading from the scratch.
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\saite\OneDrive - UNT System\Skills\SQL\SQl_Data_warehousing_project_from_scratch\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2, --skip the first raw as it contains column names. actual data starts from the second row.
			FIELDTERMINATOR = ',', --delimiter is ,
			TABLOCK --to improve the performance, where you are locking the entire table during loading it 
		);  
		SET @end_time = GETDATE();
		PRINT '-----------------------------------------------------------------------------------------------------------------'
		PRINT 'Loading ERP Tables";
		PRINT '-----------------------------------------------------------------------------------------------------------------'


		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_LOC_A101; --first we are making the table empty and we start loading from the scratch.
		BULK INSERT bronze.erp_LOC_A101
		FROM 'C:\Users\saite\OneDrive - UNT System\Skills\SQL\SQl_Data_warehousing_project_from_scratch\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2, --skip the first raw as it contains column names. actual data starts from the second row.
			FIELDTERMINATOR = ',', --delimiter is ,
			TABLOCK --to improve the performance, where you are locking the entire table during loading it 
		);  
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';


		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.erp_CUST_AZ12; --first we are making the table empty and we start loading from the scratch.
		BULK INSERT bronze.erp_CUST_AZ12
		FROM 'C:\Users\saite\OneDrive - UNT System\Skills\SQL\SQl_Data_warehousing_project_from_scratch\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2, --skip the first raw as it contains column names. actual data starts from the second row.
			FIELDTERMINATOR = ',', --delimiter is ,
			TABLOCK --to improve the performance, where you are locking the entire table during loading it 
		);  
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_PX_CAT_G1V2; --first we are making the table empty and we start loading from the scratch.
		BULK INSERT bronze.erp_PX_CAT_G1V2
		FROM 'C:\Users\saite\OneDrive - UNT System\Skills\SQL\SQl_Data_warehousing_project_from_scratch\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2, --skip the first raw as it contains column names. actual data starts from the second row.
			FIELDTERMINATOR = ',', --delimiter is ,
			TABLOCK --to improve the performance, where you are locking the entire table during loading it 
		);  
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

		SET @batch_end_time = GETDATE();
		PRINT '=========================================='
		PRINT 'Loading Bronze Layer is Completed';
        PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=========================================='
	END TRY
	BEGIN CATCH
		PRINT '=============================================================================================='
		PRINT 'Error Occured During Loading Bronze Layer'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() as NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=============================================================================================='
	END CATCH
END