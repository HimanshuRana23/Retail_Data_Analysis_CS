


 --Answer_1 -------------------------------------------------------

Select COUNT (*) from Customer
Select COUNT (*) from prod_cat_info
Select COUNT (*) from Transactions

 --Answer_2 -------------------------------------------------------

 Select Count (total_amt) from Transactions
 where total_amt like '-%'

 --Answer_3 -------------------------------------------------------


  Select convert(varchar(20),tran_date , 103) From 	Transactions


 --Answer_4 -------------------------------------------------------

 SELECT DATEDIFF(DAY, MIN(CONVERT(DATE, tran_date, 105)), MAX(CONVERT(DATE, tran_date, 105))), 
DATEDIFF(MONTH, MIN(CONVERT(DATE, tran_date, 105)), MAX(CONVERT(DATE, tran_date, 105))),  
DATEDIFF(YEAR, MIN(CONVERT(DATE, tran_date, 105)), MAX(CONVERT(DATE, tran_date, 105))) 
FROM Transactions

 --Answer_5 -------------------------------------------------------


 SELECT prod_cat
FROM prod_cat_info
WHERE prod_subcat
 LIKE 'DIY'


/---------------------------------------------------------------------------------------------------------------------------------------------------------------------
 --------------------------------------------------------------------------------------------------------------------------------------------------------------------\\


 --Answer_1 -----------------------------------------------------


 Select top 1
 Store_type,Count(Store_type) As Count_Channel_Trans 
 From Transactions
 Group by Store_type
 ORDER BY COUNT(TRANSACTION_ID) DESC



 --Answer_2  -----------------------------------------------------


 Select Gender ,Count (customer_Id) As Count_Of_Gender
 From Customer
 where Gender in ('M' , 'F')
 Group By Gender 
 


 --Answer_3 -----------------------------------------------------



 Select Top 1
 city_code,
 Count (customer_Id) AS [No of Customers]
 from Customer
 group by city_code
 ORDER BY [No of Customers] DESC



 --Answer_4 ------------------------------------------------


 Select count (prod_subcat) As Subcat_Count
from prod_cat_info
 where prod_cat = 'Books'
Group By prod_cat



 --Answer_5 ------------------------------------------------


 Select top 1 (Qty)
 from Transactions
 Order by Qty Desc



 --Answer_6 -------------------------------------------------


 Select Sum (total_amt) As Amount
 from Transactions T1
  join prod_cat_info T2 on T1.prod_cat_code = T2.prod_cat_code
 And prod_sub_cat_code = prod_sub_cat_code
 where prod_cat in ('books' , 'Electronics')



 --Answer_7 ------------------------------------------------


 SELECT COUNT(customer_Id) AS CUSTOMER_COUNT
FROM Customer WHERE customer_Id IN 
(
SELECT CUST_ID
FROM Transactions
LEFT JOIN Customer ON CUSTOMER_ID = CUST_ID
WHERE TOTAL_AMT NOT LIKE '-%'
GROUP BY
CUST_ID
HAVING 
COUNT(TRANSACTION_ID) > 10
)


 --Answer_8 ------------------------------------------------

 
 Select sum (total_amt) As [Total Revenue]
 from Transactions T1
INNER JOIN prod_cat_info T2 ON T1.prod_cat_code = T2.prod_cat_code
                 AND prod_subcat_code = prod_sub_cat_code
WHERE prod_cat IN ('CLOTHING' , 'ELECTRONICS') AND Store_type = 'FLAGSHIP STORE'



 --Answer_9 ------------------------------------------------


SELECT prod_subcat, SUM (total_amt) AS REVENUE 
FROM Transactions T1
LEFT JOIN Customer T2 ON T1.cust_id = T2.customer_Id
LEFT JOIN prod_cat_info T3 ON T1.prod_subcat_code = T3.prod_sub_cat_code AND T1.prod_cat_code = T3.prod_cat_code
WHERE T3.prod_cat_code = '3' AND Gender = 'M'
GROUP BY  prod_sub_cat_code , prod_subcat
 


 --Answer_10 ------------------------------------------------

SELECT TOP 5 
PROD_SUBCAT, (SUM(total_amt)/(SELECT SUM(TOTAL_AMT) FROM Transactions))*100 AS PERCANTAGE_OF_SALES, 
(COUNT(CASE WHEN QTY< 0 THEN QTY ELSE NULL END)/SUM(QTY))*100 AS PERCENTAGE_OF_RETURN
FROM Transactions T1
INNER JOIN prod_cat_info T2 ON T1.prod_cat_code = T2.prod_sub_cat_code AND prod_sub_cat_code= prod_sub_cat_code
GROUP BY PROD_SUBCAT
ORDER BY SUM(TOTAL_AMT) DESC



--Answer_11 --------------------------------------------------

SELECT CUST_ID,SUM(TOTAL_AMT) AS REVENUE FROM TRANSACTIONS
WHERE CUST_ID IN 
	(SELECT CUSTOMER_ID
	 FROM CUSTOMER
     WHERE DATEDIFF(YEAR,CONVERT(DATE,DOB,103),GETDATE()) BETWEEN 25 AND 35)
     AND CONVERT(DATE,tran_date,103) BETWEEN DATEADD(DAY,-30,(SELECT MAX(CONVERT(DATE,tran_date,103)) FROM Transactions)) 
	 AND (SELECT MAX(CONVERT(DATE,tran_date,103)) FROM Transactions)
GROUP BY CUST_ID


--Answer_12 --------------------------------------------------

SELECT TOP 1 PROD_CAT, SUM(TOTAL_AMT) FROM Transactions T1
INNER JOIN prod_cat_info T2 ON T1.PROD_CAT_CODE = T2.prod_cat_code AND 
										T1.PROD_SUBCAT_CODE = T2.prod_sub_cat_code
WHERE TOTAL_AMT < 0 AND 
CONVERT(date, tran_date, 103) BETWEEN DATEADD(MONTH,-3,(SELECT MAX(CONVERT(DATE,tran_date,103)) FROM Transactions)) 
	 AND (SELECT MAX(CONVERT(DATE,tran_date,103)) FROM Transactions)
GROUP BY PROD_CAT
ORDER BY 2 DESC


 --Answer_13 -------------------------------------------------

 SELECT  Store_type, SUM(total_amt) TOT_SALES, SUM(Qty) TOT_QUAN
FROM Transactions
GROUP BY STORE_TYPE
HAVING SUM(TOTAL_AMT) >=ALL (SELECT SUM(TOTAL_AMT) FROM Transactions GROUP BY STORE_TYPE)
AND SUM(QTY) >=ALL (SELECT SUM(QTY) FROM Transactions GROUP BY STORE_TYPE)

 --Answer_14 --------------------------------------------------

 SELECT prod_cat , AVG(TOTAL_AMT) AS AVERAGE
FROM Transactions T1
INNER JOIN prod_cat_info T2 ON T1.prod_cat_code = T2.prod_sub_cat_code AND prod_sub_cat_code= prod_sub_cat_code
GROUP BY prod_cat
HAVING AVG(TOTAL_AMT)> (SELECT AVG(TOTAL_AMT) FROM Transactions) 


 --Answer_15 --------------------------------------------------



