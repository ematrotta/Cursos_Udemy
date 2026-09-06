

  SELECT SalesOrderNumber,SUM(SalesAmount) as Suma_Amount FROM dbo.FactResellerSales GROUP BY SalesOrderNumber HAVING SUM(SalesAmount)>1000;
  SELECT TOP 10 ResellerKey FROM dbo.FactResellerSales GROUP BY ResellerKey HAVING SUM(SalesAmount)>1000 ORDER BY SUM(SalesAmount) DESC;
  
  SELECT SalesOrderNumber,SUM(SalesAmount) as Suma_Amount
	FROM dbo.FactResellerSales 
	WHERE ResellerKey IN (
		SELECT TOP 10 ResellerKey 
		FROM dbo.FactResellerSales 
		GROUP BY ResellerKey 
		HAVING SUM(SalesAmount)>1000 
		ORDER BY SUM(SalesAmount) DESC) 
	GROUP BY SalesOrderNumber 
	HAVING SUM(SalesAmount)>1000;

WITH reseller AS 
	(SELECT TOP 10 ResellerKey 
		FROM dbo.FactResellerSales 
		GROUP BY ResellerKey 
		HAVING SUM(SalesAmount)>1000 
		ORDER BY SUM(SalesAmount) DESC),
	fecha AS
	(SELECT MAX(OrderDate) AS fecha_order FROM dbo.FactResellerSales),
	employee AS 
	(SELECT DISTINCT EmployeeKey 
		FROM dbo.FactResellerSales 
		WHERE OrderDate>DATEADD(MONTH, -4,(SELECT fecha_order FROM fecha)))

SELECT * FROM employee;

ALTER VIEW SalesLastFourMonthsTopReseller AS  

WITH reseller AS 
	(SELECT TOP 10 ResellerKey 
		FROM dbo.FactResellerSales 
		GROUP BY ResellerKey 
		HAVING SUM(SalesAmount)>1000 
		ORDER BY SUM(SalesAmount) DESC),
	fecha AS
	(SELECT MAX(OrderDate) AS fecha_order FROM dbo.FactResellerSales),
	employee AS 
	(SELECT DISTINCT EmployeeKey 
		FROM dbo.FactResellerSales 
		WHERE OrderDate>DATEADD(MONTH, -4,(SELECT fecha_order FROM fecha)))

  SELECT [ProductKey]
      ,[OrderDateKey]
      ,[DueDateKey]
      ,[ShipDateKey]
      ,[ResellerKey]
      ,[EmployeeKey]
      ,[PromotionKey]
      ,[CurrencyKey]
      ,[SalesTerritoryKey]
      ,[SalesOrderNumber]
      ,[SalesOrderLineNumber]
      ,[RevisionNumber]
      ,[OrderQuantity]
      ,[UnitPrice]
      ,[ExtendedAmount]
      ,[UnitPriceDiscountPct]
      ,[DiscountAmount]
      ,[ProductStandardCost]
      ,[TotalProductCost]
      ,[SalesAmount]
      ,[TaxAmt]
      ,[Freight]
      ,[CarrierTrackingNumber]
      ,[CustomerPONumber]
      ,[OrderDate]
      ,[DueDate]
      ,[ShipDate]
	FROM dbo.FactResellerSales 
	WHERE ResellerKey IN (SELECT ResellerKey FROM reseller);