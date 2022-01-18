USE [u_lacki]
GO
/****** Object:  View [dbo].[CurrentDiscounts]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[CurrentDiscounts] as 
Select D.DiscountID,DS.SetName,DSD.Value from Discounts as D 
inner join DiscountSetDetails as DSD on D.DiscountID=DSD.DiscountID
inner join DiscountsSet as DS on DS.SetID=DSD.SetID
where D.EndDate is null
GO
/****** Object:  View [dbo].[CustomerDiscountFirstType]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[CustomerDiscountFirstType] as 
Select CI.CustomerID,CI.FirstName+' '+CI.LastName as 'Name',CDFT.ReceivedDate,DS.SetName,DSD.Value from CustomerIndividuals as CI
inner join CustomerDiscountFT as CDFT on CI.CustomerID=CDFT.CustomerID
inner join Discounts as D on D.DiscountID=CDFT.DiscountID
inner join DiscountSetDetails as DSD on D.DiscountID=DSD.DiscountID
inner join DiscountsSet as DS on DS.SetID=DSD.SetID
GO
/****** Object:  View [dbo].[CustomerDiscountsSecondType]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[CustomerDiscountsSecondType] as 
Select CI.CustomerID,CI.FirstName+' '+CI.LastName as 'Name',CDST.ReceivedDate,CDST.UseDate,DS.SetName,DSD.Value from CustomerIndividuals as CI
inner join CustomerDiscountsST as CDST on CI.CustomerID=CDST.CustomerID
inner join Discounts as D on D.DiscountID=CDST.DiscountID
inner join DiscountSetDetails as DSD on D.DiscountID=DSD.DiscountID
inner join DiscountsSet as DS on DS.SetID=DSD.SetID
GO
/****** Object:  View [dbo].[DiscountsFTMonthly]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DiscountsFTMonthly] AS
SELECT YEAR(ReceivedDate) AS 'Year', MONTH(ReceivedDate) AS 'Month', COUNT(*) AS 'Discounts Count' FROM CustomerDiscountFT
GROUP BY MONTH(ReceivedDate), YEAR(ReceivedDate)
GO
/****** Object:  View [dbo].[DiscountsFTWeekly]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DiscountsFTWeekly] AS
SELECT YEAR(ReceivedDate) AS 'Year', DATEPART(WEEK, ReceivedDate) AS 'Week', COUNT(*) AS 'Discounts Count' FROM CustomerDiscountFT
GROUP BY DATEPART(WEEK, ReceivedDate), YEAR(ReceivedDate)
GO
/****** Object:  View [dbo].[DiscountsSTMonthly]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DiscountsSTMonthly] AS
SELECT YEAR(ReceivedDate) AS 'Year', MONTH(ReceivedDate) AS 'Month', COUNT(*) AS 'Discounts Count' FROM CustomerDiscountsST
GROUP BY MONTH(ReceivedDate), YEAR(ReceivedDate)
GO
/****** Object:  View [dbo].[DiscountsSTWeekly]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DiscountsSTWeekly] AS
SELECT YEAR(ReceivedDate) AS 'Year', DATEPART(WEEK, ReceivedDate) AS 'Week', COUNT(*) AS 'Discounts Count' FROM CustomerDiscountsST
GROUP BY DATEPART(WEEK, ReceivedDate), YEAR(ReceivedDate)
GO
/****** Object:  View [dbo].[DishesCategories]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[DishesCategories] as 
Select D.DishName,C.CategoryName,C.Description from Dishes as D 
inner join Categories as C on D.CategoryID=C.CategoryID
GO
/****** Object:  View [dbo].[DishesHistoryPrices]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[DishesHistoryPrices] as 
Select TOP(100) Percent D.DishName,DH.DishPrice,DH.InMenuDate,DH.OutMenuDate from DishesHistory as DH 
inner join Dishes as D on D.DishID=DH.DishID 
order by D.DishID,DH.DishPrice DESC
GO
/****** Object:  View [dbo].[DishesToOrder]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[DishesToOrder] as 
Select D.DishName,D.Description,DH.DishPrice from DishesHistory as DH 
inner join Dishes as D on D.DishID=DH.DishID 
where D.MinStockValue>DH.UnitsInStock and OutMenuDate is null 
GO
/****** Object:  View [dbo].[DishIncome]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[DishIncome] as 
Select TOP(100) percent D.DishID,D.DishName,isnull(SUM(OD.Quantity*OD.DishPrice),0) as 'Income' from OrderDetails as OD
inner join DishesHistory as DH on OD.DishesHistoryID=DH.DishesHistoryID
right join Dishes as D on D.DishID=DH.DishID
group by OD.DishesHistoryID,D.DishID,D.DishName
order by 3 DESC
GO
/****** Object:  View [dbo].[DishPopularity]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[DishPopularity] as 
Select TOP(100) percent D.DishID,D.DishName,isnull(SUM(OD.Quantity),0) as 'Quantity' from OrderDetails as OD
inner join DishesHistory as DH on OD.DishesHistoryID=DH.DishesHistoryID
right join Dishes as D on D.DishID=DH.DishID
group by OD.DishesHistoryID,D.DishID,D.DishName
order by 3 DESC
GO
/****** Object:  View [dbo].[FirmsEmployees]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[FirmsEmployees] as 
Select C.CustomerID,CI.FirstName+' '+CI.LastName as 'Name',CF.CompanyName from Customers as C
inner join CustomerIndividuals as CI on C.CustomerID=CI.CustomerID
inner join CustomerFirmsEmployees as CFE on CFE.CustomerID=CI.CustomerID
inner join CustomerFirms as CF on CFE.FirmID=CF.CustomerID
GO
/****** Object:  View [dbo].[FirmsReservationsCount]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[FirmsReservationsCount] AS
SELECT CF.[CustomerID], CF.[CompanyName], ISNULL(COUNT(RF.[ReservationID]), 0) AS 'Count' 
FROM [ReservationsFirms] AS RF
RIGHT OUTER JOIN [CustomerFirms] AS CF 
ON RF.[FirmID] = CF.[CustomerID]
GROUP BY CF.[CustomerID], CF.[CompanyName]
GO
/****** Object:  View [dbo].[FreeTablesForToday]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[FreeTablesForToday] as
Select T.TableID,T.Places from Reservations as R
inner join ReservationsFirms as RF on RF.ReservationID=R.ReservationID
inner join ReservationsFirmsEmployees as RFE on RF.ReservationID=RFE.ReservationID
right join Tables as T on RFE.TableID=T.TableID and datediff(day,getdate(),R.ReservationDate)=0
where R.ReservationID is null
intersect
Select T.TableID,T.Places from Reservations as R
inner join ReservationsFirms as RF on RF.ReservationID=R.ReservationID
inner join ReservationsFirmsDetails as RFD on RF.ReservationID=RFD.ReservationID
right join Tables as T on RFD.TableID=T.TableID and datediff(day,getdate(),R.ReservationDate)=0
where R.ReservationID is null
intersect
Select T.TableID,T.Places from Reservations as R
inner join ReservationsIndividuals as RI on RI.ReservationID=R.ReservationID
right join Tables as T on RI.TableID=T.TableID and datediff(day,getdate(),R.ReservationDate)=0
where R.ReservationID is null
GO
/****** Object:  View [dbo].[IncomePerCustomerFirmThisMonth]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[IncomePerCustomerFirmThisMonth] AS
SELECT CF.CustomerID,CF.CompanyName AS 'Name',C.Phone,SUM(OD.DishPrice*OD.Quantity) AS 'Income' FROM CustomerFirms AS CF
INNER JOIN Customers AS C ON CF.CustomerID=C.CustomerID
INNER JOIN Orders AS O ON O.CustomerID=C.CustomerID
INNER JOIN OrderDetails AS OD ON O.OrderID=OD.OrderID
WHERE DATEDIFF(MONTH,GETDATE(),O.OrderDate)=0
GROUP BY CF.CustomerID,CF.CompanyName,C.Phone
GO
/****** Object:  View [dbo].[IncomePerCustomerFirmThisWeek]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[IncomePerCustomerFirmThisWeek] AS
SELECT CF.CustomerID,CF.CompanyName AS 'Name',C.Phone,SUM(OD.DishPrice*OD.Quantity) AS 'Income' FROM CustomerFirms AS CF
INNER JOIN Customers AS C ON CF.CustomerID=C.CustomerID
INNER JOIN Orders AS O ON O.CustomerID=C.CustomerID
INNER JOIN OrderDetails AS OD ON O.OrderID=OD.OrderID
WHERE DATEDIFF(WEEK,GETDATE(),O.OrderDate)=0
GROUP BY CF.CustomerID,CF.CompanyName,C.Phone
GO
/****** Object:  View [dbo].[IncomePerCustomerIndividualThisMonth]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[IncomePerCustomerIndividualThisMonth] AS
SELECT CI.CustomerID,CI.FirstName+' '+CI.LastName AS 'Name',C.Phone,SUM(OD.DishPrice*OD.Quantity) AS 'Income' FROM CustomerIndividuals AS Ci
INNER JOIN Customers AS C ON CI.CustomerID=C.CustomerID
INNER JOIN Orders AS O ON O.CustomerID=C.CustomerID
INNER JOIN OrderDetails AS OD ON O.OrderID=OD.OrderID
WHERE DATEDIFF(MONTH,GETDATE(),O.OrderDate)=0
GROUP BY CI.CustomerID,CI.FirstName,CI.LastName,C.Phone
GO
/****** Object:  View [dbo].[IncomePerCustomerIndividualThisWeek]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[IncomePerCustomerIndividualThisWeek] AS
SELECT CI.CustomerID,CI.FirstName+' '+CI.LastName AS 'Name',C.Phone,SUM(OD.DishPrice*OD.Quantity) AS 'Income' FROM CustomerIndividuals AS Ci
INNER JOIN Customers AS C ON CI.CustomerID=C.CustomerID
INNER JOIN Orders AS O ON O.CustomerID=C.CustomerID
INNER JOIN OrderDetails AS OD ON O.OrderID=OD.OrderID
WHERE DATEDIFF(WEEK,GETDATE(),O.OrderDate)=0
GROUP BY CI.CustomerID,CI.FirstName,CI.LastName,C.Phone
GO
/****** Object:  View [dbo].[IndividualsReservationsCount]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[IndividualsReservationsCount] AS
SELECT CI.[CustomerID], CI.[FirstName] + ' ' + CI.[LastName] 
AS 'Name', ISNULL(COUNT(RI.[ReservationID]), 0) AS 'Count' 
FROM [ReservationsIndividuals] AS RI
RIGHT OUTER JOIN [CustomerIndividuals] AS CI 
ON RI.[CustomerID] = CI.[CustomerID]
GROUP BY CI.[CustomerID], CI.[FirstName], CI.[LastName]
GO
/****** Object:  View [dbo].[Menu]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[Menu] as 
Select D.DishName,D.Description,DH.DishPrice from DishesHistory as DH 
inner join Dishes as D on D.DishID=DH.DishID 
where OutMenuDate is null 
GO
/****** Object:  View [dbo].[MenuMonthly]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[MenuMonthly] AS
SELECT D.[DishName], D.[Description], DH.[DishPrice], MONTH(DH.InMenuDate) AS Month, YEAR(DH.InMenuDate) AS Year
FROM [DishesHistory] AS DH
INNER JOIN [Dishes] AS D ON DH.[DishID] = D.[DishID]
GROUP BY MONTH(DH.InMenuDate),YEAR(DH.InMenuDate),D.[DishName], D.[Description], DH.[DishPrice] 
GO
/****** Object:  View [dbo].[MenuMonthlyCount]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[MenuMonthlyCount] AS
SELECT D.[DishName], D.[Description], COUNT(*) AS CountDish, MONTH(DH.InMenuDate) AS Month, YEAR(DH.InMenuDate) AS Year
FROM [DishesHistory] AS DH
INNER JOIN [Dishes] AS D ON DH.[DishID] = D.[DishID]
GROUP BY MONTH(DH.InMenuDate),YEAR(DH.InMenuDate),D.[DishName], D.[Description]
GO
/****** Object:  View [dbo].[MenuWeekly]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[MenuWeekly] AS
SELECT D.[DishName], D.[Description], DH.[DishPrice], DATEPART(WEEK, MONTH(DH.InMenuDate)) AS WeekNumber, MONTH(DH.InMenuDate) AS Month, YEAR(DH.InMenuDate) AS Year
FROM [DishesHistory] AS DH
INNER JOIN [Dishes] AS D ON DH.[DishID] = D.[DishID]
GROUP BY DATEPART(WEEK, MONTH(DH.InMenuDate)), MONTH(DH.InMenuDate), YEAR(DH.InMenuDate),D.[DishName], D.[Description], DH.[DishPrice] 
GO
/****** Object:  View [dbo].[MenuWeeklyCount]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[MenuWeeklyCount] AS
SELECT D.[DishName], D.[Description],COUNT(*) AS CountDish, DATEPART(WEEK, MONTH(DH.InMenuDate)) AS WeekNumber, MONTH(DH.InMenuDate) AS Month, YEAR(DH.InMenuDate) AS Year
FROM [DishesHistory] AS DH
INNER JOIN [Dishes] AS D ON DH.[DishID] = D.[DishID]
GROUP BY DATEPART(WEEK, MONTH(DH.InMenuDate)), MONTH(DH.InMenuDate), YEAR(DH.InMenuDate),D.[DishName], D.[Description]
GO
/****** Object:  View [dbo].[OrdersPerCustomerFirmThisMonth]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OrdersPerCustomerFirmThisMonth] AS
SELECT CF.CustomerID,CF.CompanyName AS 'Name',C.Phone,SUM(OD.DishPrice*OD.Quantity) AS 'Income',O.OrderID,O.OrderDate FROM CustomerFirms AS CF
INNER JOIN Customers AS C ON CF.CustomerID=C.CustomerID
INNER JOIN Orders AS O ON O.CustomerID=C.CustomerID
INNER JOIN OrderDetails AS OD ON O.OrderID=OD.OrderID
WHERE DATEDIFF(MONTH,GETDATE(),O.OrderDate)=0
GROUP BY CF.CustomerID,CF.CompanyName,C.Phone,O.OrderID,O.OrderDate
GO
/****** Object:  View [dbo].[OrdersPerCustomerFirmThisWeek]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OrdersPerCustomerFirmThisWeek] AS
SELECT CF.CustomerID,CF.CompanyName AS 'Name',C.Phone,SUM(OD.DishPrice*OD.Quantity) AS 'Income',O.OrderID,O.OrderDate FROM CustomerFirms AS CF
INNER JOIN Customers AS C ON CF.CustomerID=C.CustomerID
INNER JOIN Orders AS O ON O.CustomerID=C.CustomerID
INNER JOIN OrderDetails AS OD ON O.OrderID=OD.OrderID
WHERE DATEDIFF(WEEK,GETDATE(),O.OrderDate)=0
GROUP BY CF.CustomerID,CF.CompanyName,C.Phone,O.OrderID,O.OrderDate
GO
/****** Object:  View [dbo].[OrdersPerCustomerIndividualThisMonth]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OrdersPerCustomerIndividualThisMonth] AS
SELECT CI.CustomerID,CI.FirstName+' '+CI.LastName AS 'Name',C.Phone,SUM(OD.DishPrice*OD.Quantity) AS 'Income',O.OrderDate,O.OrderID FROM CustomerIndividuals AS Ci
INNER JOIN Customers AS C ON CI.CustomerID=C.CustomerID
INNER JOIN Orders AS O ON O.CustomerID=C.CustomerID
INNER JOIN OrderDetails AS OD ON O.OrderID=OD.OrderID
WHERE DATEDIFF(MONTH,GETDATE(),O.OrderDate)=0
GROUP BY CI.CustomerID,CI.FirstName,CI.LastName,C.Phone,O.OrderDate,O.OrderID
GO
/****** Object:  View [dbo].[OrdersPerCustomerIndividualThisWeek]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OrdersPerCustomerIndividualThisWeek] AS
SELECT CI.CustomerID,CI.FirstName+' '+CI.LastName AS 'Name',C.Phone,SUM(OD.DishPrice*OD.Quantity) AS 'Income',O.OrderDate,O.OrderID FROM CustomerIndividuals AS Ci
INNER JOIN Customers AS C ON CI.CustomerID=C.CustomerID
INNER JOIN Orders AS O ON O.CustomerID=C.CustomerID
INNER JOIN OrderDetails AS OD ON O.OrderID=OD.OrderID
WHERE DATEDIFF(WEEK,GETDATE(),O.OrderDate)=0
GROUP BY CI.CustomerID,CI.FirstName,CI.LastName,C.Phone,O.OrderDate,O.OrderID
GO
/****** Object:  View [dbo].[OrdersPerTimeOfDay]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OrdersPerTimeOfDay] AS
SELECT COUNT(*) AS 'Quantity', 'Morning' AS 'Time of day' FROM [Orders]
WHERE DATEPART(HOUR, [ReceiveDate]) < 11
UNION 
SELECT COUNT(*) AS 'Quantity', 'Midday' AS 'Time of day' FROM [Orders]
WHERE 11 <= DATEPART(HOUR, [ReceiveDate]) AND DATEPART(HOUR, [ReceiveDate]) < 16
UNION
SELECT COUNT(*) AS 'Quantity', 'Afternoon' AS 'Time of day' FROM [Orders]
WHERE 16 <= DATEPART(HOUR, [ReceiveDate]) AND DATEPART(HOUR, [ReceiveDate]) < 20
UNION
SELECT COUNT(*) AS 'Quantity', 'Evening' AS 'Time of day' FROM [Orders]
WHERE 20 <= DATEPART(HOUR, [ReceiveDate])
GO
/****** Object:  View [dbo].[OrdersPerTimeOfDayThisMonth]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OrdersPerTimeOfDayThisMonth] AS
SELECT COUNT(*) AS 'Quantity', 'Morning' AS 'Time of day' FROM [Orders]
WHERE DATEPART(HOUR, [ReceiveDate]) < 11 AND DATEDIFF(MONTH, [ReceiveDate], GETDATE()) = 0
UNION 
SELECT COUNT(*) AS 'Quantity', 'Midday' AS 'Time of day' FROM [Orders]
WHERE 11 <= DATEPART(HOUR, [ReceiveDate]) AND DATEPART(HOUR, [ReceiveDate]) < 16 AND DATEDIFF(MONTH, [ReceiveDate], GETDATE()) = 0
UNION
SELECT COUNT(*) AS 'Quantity', 'Afternoon' AS 'Time of day' FROM [Orders]
WHERE 16 <= DATEPART(HOUR, [ReceiveDate]) AND DATEPART(HOUR, [ReceiveDate]) < 20 AND DATEDIFF(MONTH, [ReceiveDate], GETDATE()) = 0
UNION
SELECT COUNT(*) AS 'Quantity', 'Evening' AS 'Time of day' FROM [Orders]
WHERE 20 <= DATEPART(HOUR, [ReceiveDate]) AND DATEDIFF(MONTH, [ReceiveDate], GETDATE()) = 0
GO
/****** Object:  View [dbo].[OrdersPerTimeOfDayThisWeek]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OrdersPerTimeOfDayThisWeek] AS
SELECT COUNT(*) AS 'Quantity', 'Morning' AS 'Time of day' FROM [Orders]
WHERE DATEPART(HOUR, [ReceiveDate]) < 11 AND DATEDIFF(WEEK, [ReceiveDate], GETDATE()) = 0
UNION 
SELECT COUNT(*) AS 'Quantity', 'Midday' AS 'Time of day' FROM [Orders]
WHERE 11 <= DATEPART(HOUR, [ReceiveDate]) AND DATEPART(HOUR, [ReceiveDate]) < 16 AND DATEDIFF(WEEK, [ReceiveDate], GETDATE()) = 0
UNION
SELECT COUNT(*) AS 'Quantity', 'Afternoon' AS 'Time of day' FROM [Orders]
WHERE 16 <= DATEPART(HOUR, [ReceiveDate]) AND DATEPART(HOUR, [ReceiveDate]) < 20 AND DATEDIFF(WEEK, [ReceiveDate], GETDATE()) = 0
UNION
SELECT COUNT(*) AS 'Quantity', 'Evening' AS 'Time of day' FROM [Orders]
WHERE 20 <= DATEPART(HOUR, [ReceiveDate]) AND DATEDIFF(WEEK, [ReceiveDate], GETDATE()) = 0
GO
/****** Object:  View [dbo].[OrdersPriceForToday]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[OrdersPriceForToday] as 
Select O.OrderID,SUM(OD.DishPrice*OD.Quantity) as 'Price' from Orders as o
inner join OrderDetails as OD on O.OrderID=OD.OrderID
where DATEDIFF(day,O.ReceiveDate,getdate())=0
group by O.OrderID
GO
/****** Object:  View [dbo].[OrdersToDo]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[OrdersToDo] as 
Select OrderID,CustomerID,EmployeeID,OrderDate,O.ReceiveDate,PT.PaymentName from Orders  as O
inner join PaymentType as PT on  O.PaymentTypeID=PT.PaymentTypeID
where ReceiveDate>getdate()
GO
/****** Object:  View [dbo].[ReservatedTablesMonthly]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ReservatedTablesMonthly] AS
SELECT YEAR(R.ReservationDate) AS 'Year', MONTH(R.ReservationDate) AS 'Month', COUNT(*) AS 'Reservations Count'
FROM [Reservations] AS R
INNER JOIN [ReservationsFirms] AS RF 
ON R.[ReservationID] = RF.[ReservationID]
INNER JOIN [ReservationsFirmsEmployees] AS RFE 
ON RF.[ReservationID] = RFE.[ReservationID]
RIGHT OUTER JOIN [Tables] AS T 
ON RFE.[TableID] = T.[TableID] 
WHERE R.[ReservationID] IS NOT NULL
GROUP BY MONTH(R.ReservationDate), YEAR(R.ReservationDate)  
UNION
SELECT YEAR(R.ReservationDate) AS 'Year', MONTH(R.ReservationDate) AS 'Month', COUNT(*) AS 'Reservations Count'
FROM [Reservations] AS R
INNER JOIN [ReservationsFirms] AS RF 
ON R.[ReservationID] = RF.[ReservationID]
INNER JOIN [ReservationsFirmsDetails] AS RFD 
ON RF.[ReservationID] = RFD.[ReservationID]
RIGHT OUTER JOIN [Tables] AS T 
ON RFD.[TableID] = T.[TableID] 
WHERE R.[ReservationID] IS NOT NULL
GROUP BY MONTH(R.ReservationDate), YEAR(R.ReservationDate)  
UNION
SELECT YEAR(R.ReservationDate) AS 'Year', MONTH(R.ReservationDate) AS 'Month', COUNT(*) AS 'Reservations Count'  
FROM [Reservations] AS R
INNER JOIN [ReservationsIndividuals] AS RI 
ON R.[ReservationID] = RI.[ReservationID]
RIGHT OUTER JOIN [Tables] AS T 
ON RI.[TableID] = T.[TableID] 
WHERE R.[ReservationID] IS NOT NULL
GROUP BY MONTH(R.ReservationDate), YEAR(R.ReservationDate)  
GO
/****** Object:  View [dbo].[ReservatedTablesThisMonth]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[ReservatedTablesThisMonth] as
Select R.ReservationID,R.ReservationDate,T.TableID from Reservations as R
inner join ReservationsFirms as RF on RF.ReservationID=R.ReservationID
inner join ReservationsFirmsEmployees as RFE on RF.ReservationID=RFE.ReservationID
right join Tables as T on RFE.TableID=T.TableID and datediff(month,getdate(),R.ReservationDate)=0
where R.ReservationID is not null
union
Select R.ReservationID,R.ReservationDate,T.TableID from Reservations as R
inner join ReservationsFirms as RF on RF.ReservationID=R.ReservationID
inner join ReservationsFirmsDetails as RFD on RF.ReservationID=RFD.ReservationID
right join Tables as T on RFD.TableID=T.TableID and datediff(month,getdate(),R.ReservationDate)=0
where R.ReservationID is not null
union
Select R.ReservationID,R.ReservationDate,T.TableID from Reservations as R
inner join ReservationsIndividuals as RI on RI.ReservationID=R.ReservationID
right join Tables as T on RI.TableID=T.TableID and datediff(month,getdate(),R.ReservationDate)=0
where R.ReservationID is not null
GO
/****** Object:  View [dbo].[ReservatedTablesThisWeek]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[ReservatedTablesThisWeek] as
Select R.ReservationID,R.ReservationDate,T.TableID from Reservations as R
inner join ReservationsFirms as RF on RF.ReservationID=R.ReservationID
inner join ReservationsFirmsEmployees as RFE on RF.ReservationID=RFE.ReservationID
right join Tables as T on RFE.TableID=T.TableID and datediff(Week,getdate(),R.ReservationDate)=0
where R.ReservationID is not null
union
Select R.ReservationID,R.ReservationDate,T.TableID from Reservations as R
inner join ReservationsFirms as RF on RF.ReservationID=R.ReservationID
inner join ReservationsFirmsDetails as RFD on RF.ReservationID=RFD.ReservationID
right join Tables as T on RFD.TableID=T.TableID and datediff(Week,getdate(),R.ReservationDate)=0
where R.ReservationID is not null
union
Select R.ReservationID,R.ReservationDate,T.TableID from Reservations as R
inner join ReservationsIndividuals as RI on RI.ReservationID=R.ReservationID
right join Tables as T on RI.TableID=T.TableID and datediff(Week,getdate(),R.ReservationDate)=0
where R.ReservationID is not null
GO
/****** Object:  View [dbo].[ReservatedTablesWeekly]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ReservatedTablesWeekly] AS
SELECT YEAR(R.ReservationDate) AS 'Year', DATEPART(WEEK, R.ReservationDate) AS 'Week', COUNT(*) AS 'Reservations Count'  
FROM [Reservations] AS R
INNER JOIN [ReservationsFirms] AS RF 
ON R.[ReservationID] = RF.[ReservationID]
INNER JOIN [ReservationsFirmsEmployees] AS RFE 
ON RF.[ReservationID] = RFE.[ReservationID]
RIGHT OUTER JOIN [Tables] AS T 
ON RFE.[TableID] = T.[TableID] 
WHERE R.[ReservationID] IS NOT NULL
GROUP BY DATEPART(WEEK, R.ReservationDate), YEAR(R.ReservationDate) 
UNION
SELECT YEAR(R.ReservationDate) AS 'Year', DATEPART(WEEK, R.ReservationDate) AS 'Week', COUNT(*) AS 'Reservations Count'  
FROM [Reservations] AS R
INNER JOIN [ReservationsFirms] AS RF 
ON R.[ReservationID] = RF.[ReservationID]
INNER JOIN [ReservationsFirmsDetails] AS RFD 
ON RF.[ReservationID] = RFD.[ReservationID]
RIGHT OUTER JOIN [Tables] AS T 
ON RFD.[TableID] = T.[TableID] 
WHERE R.[ReservationID] IS NOT NULL
GROUP BY DATEPART(WEEK, R.ReservationDate), YEAR(R.ReservationDate)  
UNION
SELECT YEAR(R.ReservationDate) AS 'Year', DATEPART(WEEK, R.ReservationDate) AS 'Week', COUNT(*) AS 'Reservations Count'    
FROM [Reservations] AS R
INNER JOIN [ReservationsIndividuals] AS RI 
ON R.[ReservationID] = RI.[ReservationID]
RIGHT OUTER JOIN [Tables] AS T 
ON RI.[TableID] = T.[TableID] 
WHERE R.[ReservationID] IS NOT NULL
GROUP BY DATEPART(WEEK, R.ReservationDate), YEAR(R.ReservationDate)
GO
/****** Object:  View [dbo].[ReservationsForToday]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[ReservationsForToday] as 
Select * from Reservations as R where DATEDIFF(day,R.ReservationDate,getdate())=0
GO
/****** Object:  View [dbo].[ReservationsThisMonth]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE VIEW [dbo].[ReservationsThisMonth] AS 
SELECT * FROM [Reservations] AS R 
WHERE DATEDIFF(MONTH, R.[ReservationDate], GETDATE()) = 0
GO
/****** Object:  View [dbo].[ReservationsThisWeek]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE VIEW [dbo].[ReservationsThisWeek] AS 
SELECT * FROM [Reservations] AS R 
WHERE DATEDIFF(WEEK, R.[ReservationDate], GETDATE()) = 0
GO
/****** Object:  View [dbo].[ReservationsToAccept]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE VIEW [dbo].[ReservationsToAccept] AS
SELECT R.[ReservationID], R.[ReservationDate], CI.[FirstName] + ' ' + CI.[LastName] AS 'Customer name', CI.[CustomerID] 
FROM [Reservations] AS R
INNER JOIN [ReservationsIndividuals] AS RI 
ON R.[ReservationID] = RI.[ReservationID]
INNER JOIN [CustomerIndividuals] AS CI 
ON RI.[CustomerID] = CI.[CustomerID]
WHERE R.[EmployeeID] IS NULL
UNION
SELECT R.[ReservationID], R.[ReservationDate], CF.[CompanyName] AS 'Customer Name', CF.[CustomerID]
FROM [Reservations] AS R
INNER JOIN [ReservationsFirms] AS RF 
ON R.[ReservationID] = RF.[ReservationID]
INNER JOIN [CustomerFirms] AS CF 
ON RF.[FirmID] = CF.[CustomerID]
WHERE R.[EmployeeID] IS NULL
GO
/****** Object:  View [dbo].[SeaFoodNeededForThisWeekend]    Script Date: 18.01.2022 22:06:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SeaFoodNeededForThisWeekend]
AS
SELECT D.[DishID], D.[DishName], SUM(OD.[Quantity]) AS 'Quantity' FROM [Orders] AS O 
INNER JOIN [OrderDetails] AS OD ON O.[OrderID] = OD.[OrderID]
INNER JOIN [DishesHistory] AS DH ON OD.DishesHistoryID = DH.DishesHistoryID
INNER JOIN [Dishes] AS D ON DH.DishID = D.DishID
INNER JOIN [Categories] AS Ca ON D.CategoryID = Ca.CategoryID
WHERE Ca.CategoryID = 2 AND DATEDIFF(WEEK, GETDATE(), O.[ReceiveDate]) = 0
GROUP BY D.[DishID], D.[DishName]
GO
