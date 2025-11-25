SELECT * FROM `sales-478305.BRIGHTSALES.SALESDATASET` LIMIT 1000; --TEST LINE

 SELECT MIN(DATE) AS `OPENING DATE` FROM `sales-478305.BRIGHTSALES.SALESDATASET`; -- CHECKING STORE'S EARLIEST TRANSACTION DATE

 SELECT MAX(DATE) AS `CLOSING DATE` FROM `sales-478305.BRIGHTSALES.SALESDATASET`;--CHECKING STORE'S LAST OPERATION DATE

 --CALCULATING GROSS PROFIT
  SELECT (SALES - `Cost of sales`) AS GROSS_PROFIT
FROM `sales-478305.BRIGHTSALES.SALESDATASET`;

SELECT Date,
  FORMAT("%.2f", Sales) AS Sales,
  FORMAT("%.2f", `Cost of sales`) AS `Cost of sales`, 
FORMAT_DATE('%B', Date) AS Month_name,
  FORMAT_DATE('%A', Date) AS Day_name,
   SUM (Sales/ `Quantity Sold`) AS `daily sales per unit`,
    AVG(( Sales)/ `Quantity Sold`) AS average_unit_sale_price,
    SUM(Sales) - SUM(`Cost of sales`) AS gross_profit ,
   (SUM(Sales) - SUM(`Cost of sales`))/ SUM(`Quantity Sold`) AS Daily_gross_profit_per_unit,
    ((SUM(Sales) - SUM(`Cost of sales`)) /SUM (Sales)) * 100 AS Gross_profit_margin,
    CASE
        WHEN  ((SUM(Sales) - SUM(`Cost of sales`)) /SUM (Sales)) * 100 > 5 THEN 'High Margin'
        WHEN  ((SUM(Sales) - SUM(`Cost of sales`)) /SUM (Sales)) * 100 BETWEEN -5 AND 5 THEN 'Medium Margin'
        ELSE 'Low Margin'
    END AS margin_tier,
    SUM(`Quantity sold`) AS Total_Quantity,
    CASE
        WHEN `Quantity sold` > 17600 THEN 'High Volume'
        When `Quantity sold` BETWEEN 8000 AND 17600 THEN 'Medium Volume'
        ELSE 'Low Volume'
    END AS volume_tier
FROM `sales-478305.BRIGHTSALES.SALESDATASET`
GROUP BY ALL
ORDER BY Sales DESC;
