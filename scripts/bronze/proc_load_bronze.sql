CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @start_whole_time DATETIME, @end_time DATETIME, @end_whole_time DATETIME;
	BEGIN TRY
		SET @start_whole_time = GETDATE();
		PRINT '========================================================================================';
		PRINT '									LOADING BRONZE LAYER';
		PRINT '========================================================================================';

		PRINT '';

		PRINT '----------------------------------------------------------------------------------------';
		PRINT '									Loading CRM tables';

		PRINT '****************************************************************************************';
		PRINT 'Truncating table: bronze.crm_cust_info';
		PRINT '';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT 'Inserting data into table: bronze.crm_cust_info';
		PRINT 'Data source: D:\Data Warehouse Project\First project\Datasets\crm_source\cust_info.csv';

		BULK INSERT bronze.crm_cust_info 
		FROM 'D:\Data Warehouse Project\First project\Datasets\crm_source\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();

		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '****************************************************************************************';
		PRINT '';

		PRINT '****************************************************************************************';
		PRINT 'Truncating table: bronze.crm_prd_info';
		PRINT '';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT 'Inserting data into table: bronze.crm_prd_info';
		PRINT 'Data source: D:\Data Warehouse Project\First project\Datasets\crm_source\prd_info.csv';

		BULK INSERT bronze.crm_prd_info
		FROM 'D:\Data Warehouse Project\First project\Datasets\crm_source\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();

		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '****************************************************************************************';
		PRINT '';

		PRINT '****************************************************************************************';
		PRINT 'Truncating table: bronze.crm_sales_details';
		PRINT '';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details;


		PRINT 'Inserting data into table: bronze.crm_sales_details';
		PRINT 'Data source: D:\Data Warehouse Project\First project\Datasets\crm_source\sales_details.csv';

		BULK INSERT bronze.crm_sales_details 
		FROM 'D:\Data Warehouse Project\First project\Datasets\crm_source\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();

		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '****************************************************************************************';
		PRINT '----------------------------------------------------------------------------------------';

		PRINT '';
		
		PRINT '----------------------------------------------------------------------------------------';
		PRINT '								Loading ERP tables';
	
		PRINT '****************************************************************************************';
		PRINT 'Truncating table: bronze.erp_cust_az12';
		PRINT '';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_cust_az12;

		
		PRINT 'Inserting data into table: bronze.erp_cust_az12';
		PRINT 'Data source: D:\Data Warehouse Project\First project\Datasets\erp_source\CUST_AZ12.csv';

		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\Data Warehouse Project\First project\Datasets\erp_source\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();

		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '****************************************************************************************';
		PRINT '';

		PRINT '****************************************************************************************';
		PRINT 'Truncating table: bronze.erp_loc_a101';
		PRINT '';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101;


		PRINT 'Inserting data into table: bronze.erp_loc_a101';
		PRINT 'Data source: D:\Data Warehouse Project\First project\Datasets\erp_source\LOC_A101.csv';

		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\Data Warehouse Project\First project\Datasets\erp_source\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();

		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '****************************************************************************************';
		PRINT '';

		PRINT '****************************************************************************************';
		PRINT 'Truncating table: bronze.erp_px_cat_g1v2';
		PRINT '';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT 'Inserting data into table: bronze.erp_px_cat_g1v2';
		PRINT 'Data source: D:\Data Warehouse Project\First project\Datasets\erp_source\PX_CAT_G1V2.csv';

		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\Data Warehouse Project\First project\Datasets\erp_source\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();

		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '****************************************************************************************';
		PRINT '----------------------------------------------------------------------------------------';
		PRINT '						ALL DATA SOURCES HAS BEEN LOADED INTO BRONZE LAYER';

		SET @end_whole_time = GETDATE();

		PRINT '									Total Load Time: ' + CAST(DATEDIFF(second, @start_whole_time, @end_whole_time) AS NVARCHAR) + 'seconds';
	END TRY

	BEGIN CATCH

		PRINT 'ERROR OCCURED DURING DATA LOADING IN BRONZE LAYER';
		PRINT 'ERROR: ' + ERROR_MESSAGE();
		PRINT 'ERROR LINE: ' + CAST(ERROR_LINE() AS NVARCHAR);
		PRINT 'ERROR STATE: ' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT 'ERROR PROCEDURE: ' + CAST(ERROR_PROCEDURE() AS NVARCHAR);

	END CATCH
END
