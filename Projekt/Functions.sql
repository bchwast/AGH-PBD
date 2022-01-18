USE [u_lacki]
GO
/****** Object:  UserDefinedFunction [dbo].[CustomerDiscountForOrder]    Script Date: 18.01.2022 22:08:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CustomerDiscountForOrder]
(
	@OrderID int 
)
RETURNS FLOAT
AS
	BEGIN
		DECLARE @SumTotal FLOAT
		DECLARE @SumDiscounted FLOAT
		SET @SumTotal = (SELECT SUM(DH.DishPrice*OD.Quantity) FROM Orders AS O
			INNER JOIN OrderDetails AS OD ON OD.OrderID=O.OrderID
			INNER JOIN DishesHistory AS DH ON DH.DishesHistoryID=OD.DishesHistoryID
			WHERE O.OrderID=@OrderID)
		SET @SumDiscounted = (SELECT SUM(OD.DishPrice*OD.Quantity) FROM Orders AS O
			INNER JOIN OrderDetails AS OD ON OD.OrderID=O.OrderID
			WHERE O.OrderID=@OrderID)
		RETURN (
			SELECT(@SumTotal-@SumDiscounted)
		)
	END
GO
/****** Object:  UserDefinedFunction [dbo].[CustomerOrdersMinValueCountSince]    Script Date: 18.01.2022 22:08:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CustomerOrdersMinValueCountSince]
(
	@CustomerID int,
	@ReceiveDate datetime = NULL,
	@Value int = 0
)
RETURNS int
AS
	BEGIN
	IF @ReceiveDate IS NULL
	SET @ReceiveDate = CAST('1753-1-1' AS DATETIME)
	RETURN
	(
	SELECT COUNT(*)
	FROM [Orders] AS O
	WHERE O.[CustomerID] = @CustomerID AND O.[ReceiveDate] > @ReceiveDate
	AND (SELECT SUM(OD.[DishPrice] * OD.[Quantity]) FROM [OrderDetails] AS OD
		WHERE OD.[OrderID] = O.[OrderID]) > @Value
	)
END
GO
/****** Object:  UserDefinedFunction [dbo].[CustomerOrdersValueSince]    Script Date: 18.01.2022 22:08:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CustomerOrdersValueSince]
(
	@CustomerID int,
	@ReceiveDate datetime = NULL
)
RETURNS int
AS
	BEGIN
	IF @ReceiveDate IS NULL
	SET @ReceiveDate = CAST('1753-1-1' AS DATETIME)
	RETURN
	(
	SELECT SUM(OD.[DishPrice] * OD.[Quantity])
	FROM [Orders] AS O
	INNER JOIN [OrderDetails] AS OD ON O.[OrderID] = OD.[OrderID]
	WHERE O.[CustomerID] = @CustomerID AND O.[ReceiveDate] > @ReceiveDate
	)
END
GO
/****** Object:  UserDefinedFunction [dbo].[NumberDiscountFTReceived]    Script Date: 18.01.2022 22:08:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[NumberDiscountFTReceived]
()
RETURNS INT
AS
	BEGIN
	RETURN ISNULL((
		SELECT COUNT(*) FROM CustomerIndividuals AS CI
		INNER JOIN CustomerDiscountFT AS CDFT ON CDFT.CustomerID=CI.CustomerID
	),0)
	
	END
GO
/****** Object:  UserDefinedFunction [dbo].[NumberDiscountSTCurrent]    Script Date: 18.01.2022 22:08:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[NumberDiscountSTCurrent]
()
RETURNS INT
AS
	BEGIN
	RETURN ISNULL((
		SELECT COUNT(*) FROM CustomerIndividuals AS CI
		INNER JOIN CustomerDiscountsST AS CDST ON CDST.CustomerID=CI.CustomerID
		INNER JOIN Discounts AS D ON D.DiscountID=CDST.DiscountID
		INNER JOIN DiscountSetDetails AS DSD ON DSD.DiscountID=D.DiscountID
		INNER JOIN DiscountsSet AS DS ON DS.SetID=DSD.SetID
		WHERE DS.SetName='D' AND DATEDIFF(DAY, ReceivedDate, GETDATE())<=DSD.Value
	),0)
	
	END
GO
/****** Object:  UserDefinedFunction [dbo].[OrderCost]    Script Date: 18.01.2022 22:08:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[OrderCost]
(
	@OrderID int
)
RETURNS FLOAT
AS
	BEGIN
	RETURN
	(
	SELECT SUM(OD.[DishPrice] * OD.[Quantity])
	FROM [Orders] AS O
	INNER JOIN [OrderDetails] AS OD ON O.[OrderID] = OD.[OrderID]
	WHERE O.[OrderID] = @OrderID
	)
END
GO
/****** Object:  UserDefinedFunction [dbo].[OrderCostNoDiscount]    Script Date: 18.01.2022 22:08:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[OrderCostNoDiscount]
(
	@OrderID int
)
RETURNS FLOAT
AS
	BEGIN
	RETURN
	(
	SELECT SUM(DH.[DishPrice] * OD.[Quantity])
	FROM [Orders] AS O
	INNER JOIN [OrderDetails] AS OD ON O.[OrderID] = OD.[OrderID]
	INNER JOIN [DishesHistory] AS DH ON OD.[DishesHistoryID] = DH.[DishesHistoryID]
	WHERE O.[OrderID] = @OrderID
	)
END
GO
/****** Object:  UserDefinedFunction [dbo].[ReservationsCount]    Script Date: 18.01.2022 22:08:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ReservationsCount]
(
	@CustomerID int
)
RETURNS int
AS
	BEGIN
	DECLARE @CountIndividual int
	DECLARE @CountFirm int
	SET @CountIndividual = 
		(
		SELECT COUNT(*) FROM [Reservations] AS R
		INNER JOIN [ReservationsIndividuals] AS RI ON R.[ReservationID] = RI.[ReservationID]
		WHERE RI.[CustomerID] = @CustomerID
		)
	SET @CountFirm =
		(
		SELECT COUNT(*) FROM [Reservations] AS R
		INNER JOIN [ReservationsFirms] AS RF ON R.[ReservationID] = RF.[ReservationID]
		WHERE RF.[FirmID] = @CustomerID
		)
	RETURN (
		@CountIndividual + @CountFirm
	)
END
GO
/****** Object:  UserDefinedFunction [dbo].[CustomerDiscountSecondTypeHistory]    Script Date: 18.01.2022 22:08:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CustomerDiscountSecondTypeHistory]
(
	@CustomerID int
)
RETURNS TABLE
AS
	RETURN
	(
	SELECT DS.[SetName], DSD.[Value], CDST.[ReceivedDate], CDST.[UseDate]
	FROM [CustomerDiscountsST] AS CDST
	INNER JOIN [Discounts] AS D ON CDST.[DiscountID] = D.[DiscountID] 
	INNER JOIN [DiscountSetDetails] AS DSD 
	ON D.[DiscountID] = DSD.[DiscountID]
	INNER JOIN [DiscountsSet] AS DS ON DSD.[SetID] = DS.[SetID]
	WHERE CDST.[CustomerID] = @CustomerID
	)
GO
/****** Object:  UserDefinedFunction [dbo].[CustomerOrderHistory]    Script Date: 18.01.2022 22:08:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CustomerOrderHistory]
(
	@CustomerID int
)
RETURNS TABLE
AS
	RETURN
	(
	SELECT *, 
		(
		SELECT SUM(OD.[DishPrice] * OD.[Quantity]) FROM [OrderDetails] AS OD
		WHERE OD.[OrderID] = O.[OrderID]
		GROUP BY OD.[OrderID]
		) AS 'Income'
		FROM [Orders] AS O
	WHERE O.[CustomerID] = @CustomerID
	)
GO
/****** Object:  UserDefinedFunction [dbo].[CustomerOrderHistoryDetails]    Script Date: 18.01.2022 22:08:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CustomerOrderHistoryDetails]
(
	@CustomerID int
)
RETURNS TABLE
AS
	RETURN
	(
	SELECT O.[OrderID], O.[OrderDate], D.[DishID], D.[DishName], OD.[Quantity], OD.[DishPrice], OD.[Quantity] * OD.[DishPrice] AS 'Total' FROM [Orders] AS O
	INNER JOIN [OrderDetails] AS OD ON O.[OrderID] = OD.[OrderID]
	INNER JOIN [DishesHistory] AS DH ON OD.[DishesHistoryID] = DH.[DishesHistoryID]
	INNER JOIN [Dishes] AS D ON DH.[DishID] = D.[DishID]
	WHERE OD.[OrderID] = O.[OrderID] AND O.[CustomerID] = @CustomerID
	GROUP BY OD.[OrderID], D.[DishID], D.[DishName], OD.[Quantity], OD.[DishPrice], O.[OrderID], O.[OrderDate]
	)
GO
/****** Object:  UserDefinedFunction [dbo].[FreeTables]    Script Date: 18.01.2022 22:08:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FreeTables]
(
	@Date date
)
RETURNS TABLE
AS
	RETURN
	(
	SELECT T.[TableID], T.[Places] FROM [Reservations] AS R
	INNER JOIN [ReservationsFirms] AS RF 
	ON R.[ReservationID] = RF.[ReservationID]
	INNER JOIN [ReservationsFirmsEmployees] AS RFE 
	ON RF.[ReservationID] = RFE.[ReservationID]
	RIGHT OUTER JOIN [Tables] AS T 
	ON RFE.[TableID] = T.[TableID] 
	AND DATEDIFF(DAY, @Date, R.[ReservationDate]) = 0
	WHERE R.[ReservationID] IS NULL

	INTERSECT

	SELECT T.[TableID], T.[Places] FROM [Reservations] AS R
	INNER JOIN [ReservationsFirms] AS RF 
	ON R.[ReservationID] = RF.[ReservationID]
	INNER JOIN [ReservationsFirmsDetails] AS RFD 
	ON RF.[ReservationID] = RFD.[ReservationID]
	RIGHT OUTER JOIN [Tables] AS T 
	ON RFD.[TableID] = T.[TableID] 
	AND DATEDIFF(DAY, @Date, R.[ReservationDate]) = 0
	WHERE R.[ReservationID] IS NULL

	INTERSECT

	SELECT T.[TableID], T.[Places] FROM [Reservations] AS R
	INNER JOIN [ReservationsIndividuals] AS RI 
	ON R.[ReservationID] = RI.[ReservationID]
	RIGHT OUTER JOIN [Tables] AS T 
	ON RI.[TableID] = T.[TableID] 
	AND DATEDIFF(DAY, @Date, R.[ReservationDate]) = 0
	WHERE R.[ReservationID] IS NULL
	)
GO
/****** Object:  UserDefinedFunction [dbo].[OrdersForDay]    Script Date: 18.01.2022 22:08:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[OrdersForDay]
(
	@ReceiveDate date
)
RETURNS TABLE
AS
	RETURN
	(
	SELECT * FROM [Orders]
	WHERE DATEDIFF(DAY, @ReceiveDate, [ReceiveDate]) = 0
	)
GO
/****** Object:  UserDefinedFunction [dbo].[ReservationsForDay]    Script Date: 18.01.2022 22:08:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ReservationsForDay]
(
	@ReservationDate date
)
RETURNS TABLE
AS
	RETURN
	(
	SELECT * FROM [Reservations]
	WHERE DATEDIFF(DAY, @ReservationDate, [ReservationDate]) = 0
	)
GO
/****** Object:  UserDefinedFunction [dbo].[ReservationsForFirmCustomer]    Script Date: 18.01.2022 22:08:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE FUNCTION [dbo].[ReservationsForFirmCustomer]
(
	@CustomerID int
)
RETURNS TABLE
AS
	RETURN
	(
	SELECT R.[ReservationID], R.[ReservationDate], NULL 
     AS 'EmployeeID', RFD.[PeopleCount], RFD.[TableID]
	FROM [Reservations] AS R
	INNER JOIN [ReservationsFirms] AS RF 
     ON R.[ReservationID] = RF.[ReservationID]
	INNER JOIN [ReservationsFirmsDetails] AS RFD 
     ON RF.[ReservationID] = RFD.[ReservationID]
	WHERE RF.FirmID = @CustomerID

	UNION

	SELECT R.[ReservationID], R.[ReservationDate], 
     RFE.[EmployeeID], RFE.[PeopleCount], RFE.[TableID]
	FROM [Reservations] AS R
	INNER JOIN [ReservationsFirms] AS RF 
     ON R.[ReservationID] = RF.[ReservationID]
	INNER JOIN [ReservationsFirmsEmployees] AS RFE 
     ON RF.[ReservationID] = RFE.[ReservationID]
	WHERE RF.FirmID = @CustomerID
	)
GO
/****** Object:  UserDefinedFunction [dbo].[ReservationsForIndividualCustomer]    Script Date: 18.01.2022 22:08:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTIOn [dbo].[ReservationsForIndividualCustomer]
(
	@CustomerID int
)
RETURNS TABLE
AS
	RETURN
	(
	SELECT R.[ReservationID], R.[ReservationDate], RI.[PeopleCount], RI.[TableID], RI.[OrderID]
	FROM [Reservations] AS R
	INNER JOIN [ReservationsIndividuals] AS RI ON R.[ReservationID] = RI.[ReservationID]
	WHERE RI.CustomerID = @CustomerID
	)
GO
