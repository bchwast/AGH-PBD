USE [u_lacki]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [Category_Index]    Script Date: 18.01.2022 22:10:45 ******/
CREATE NONCLUSTERED INDEX [Category_Index] ON [dbo].[Categories]
(
	[CategoryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [City_Index]    Script Date: 18.01.2022 22:11:03 ******/
CREATE NONCLUSTERED INDEX [City_Index] ON [dbo].[Cities]
(
	[CityName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

/****** Object:  Index [CustomerDiscountFT_Index]    Script Date: 18.01.2022 22:11:25 ******/
CREATE NONCLUSTERED INDEX [CustomerDiscountFT_Index] ON [dbo].[CustomerDiscountFT]
(
	[ReceivedDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

/****** Object:  Index [CustomerDiscountsST_Index]    Script Date: 18.01.2022 22:12:00 ******/
CREATE NONCLUSTERED INDEX [CustomerDiscountsST_Index] ON [dbo].[CustomerDiscountsST]
(
	[ReceivedDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

/****** Object:  Index [CustomerDiscountsST_Index_1]    Script Date: 18.01.2022 22:12:14 ******/
CREATE NONCLUSTERED INDEX [CustomerDiscountsST_Index_1] ON [dbo].[CustomerDiscountsST]
(
	[UseDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

/****** Object:  Index [CustomerDiscountsST_Index_2]    Script Date: 18.01.2022 22:12:27 ******/
CREATE NONCLUSTERED INDEX [CustomerDiscountsST_Index_2] ON [dbo].[CustomerDiscountsST]
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [CustomerFirms_Index]    Script Date: 18.01.2022 22:12:47 ******/
CREATE NONCLUSTERED INDEX [CustomerFirms_Index] ON [dbo].[CustomerFirms]
(
	[NIP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [CustomerFirms_Index_2]    Script Date: 18.01.2022 22:13:02 ******/
CREATE NONCLUSTERED INDEX [CustomerFirms_Index_2] ON [dbo].[CustomerFirms]
(
	[CompanyName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

/****** Object:  Index [CustomerFirmsEmployees_Index]    Script Date: 18.01.2022 22:13:28 ******/
CREATE NONCLUSTERED INDEX [CustomerFirmsEmployees_Index] ON [dbo].[CustomerFirmsEmployees]
(
	[FirmID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [Customers_Index]    Script Date: 18.01.2022 22:13:53 ******/
CREATE NONCLUSTERED INDEX [Customers_Index] ON [dbo].[Customers]
(
	[Phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [DiscountsSet_Index]    Script Date: 18.01.2022 22:14:21 ******/
CREATE NONCLUSTERED INDEX [DiscountsSet_Index] ON [dbo].[DiscountsSet]
(
	[SetName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [Dishes_Index]    Script Date: 18.01.2022 22:14:44 ******/
CREATE NONCLUSTERED INDEX [Dishes_Index] ON [dbo].[Dishes]
(
	[DishName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

/****** Object:  Index [Dishes_Index_1]    Script Date: 18.01.2022 22:14:55 ******/
CREATE NONCLUSTERED INDEX [Dishes_Index_1] ON [dbo].[Dishes]
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

/****** Object:  Index [DishesHistory_Index]    Script Date: 18.01.2022 22:16:22 ******/
CREATE NONCLUSTERED INDEX [DishesHistory_Index] ON [dbo].[DishesHistory]
(
	[DishID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

/****** Object:  Index [DishesHistory_Index_1]    Script Date: 18.01.2022 22:16:32 ******/
CREATE NONCLUSTERED INDEX [DishesHistory_Index_1] ON [dbo].[DishesHistory]
(
	[InMenuDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

/****** Object:  Index [DishesHistory_Index_2]    Script Date: 18.01.2022 22:16:44 ******/
CREATE NONCLUSTERED INDEX [DishesHistory_Index_2] ON [dbo].[DishesHistory]
(
	[OutMenuDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [Employees_Index]    Script Date: 18.01.2022 22:17:00 ******/
CREATE NONCLUSTERED INDEX [Employees_Index] ON [dbo].[Employees]
(
	[Phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

/****** Object:  Index [Orders_Index]    Script Date: 18.01.2022 22:17:21 ******/
CREATE NONCLUSTERED INDEX [Orders_Index] ON [dbo].[Orders]
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

/****** Object:  Index [Orders_Index_1]    Script Date: 18.01.2022 22:17:30 ******/
CREATE NONCLUSTERED INDEX [Orders_Index_1] ON [dbo].[Orders]
(
	[ReceiveDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

/****** Object:  Index [Orders_Index_2]    Script Date: 18.01.2022 22:17:42 ******/
CREATE NONCLUSTERED INDEX [Orders_Index_2] ON [dbo].[Orders]
(
	[OrderDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [PaymentType_Index]    Script Date: 18.01.2022 22:18:00 ******/
CREATE NONCLUSTERED INDEX [PaymentType_Index] ON [dbo].[PaymentType]
(
	[PaymentName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

/****** Object:  Index [Reservations_Index]    Script Date: 18.01.2022 22:18:25 ******/
CREATE NONCLUSTERED INDEX [Reservations_Index] ON [dbo].[Reservations]
(
	[ReservationDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

/****** Object:  Index [ReservationsFirms_Index]    Script Date: 18.01.2022 22:18:42 ******/
CREATE NONCLUSTERED INDEX [ReservationsFirms_Index] ON [dbo].[ReservationsFirms]
(
	[FirmID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

/****** Object:  Index [ReservationsFirmsDetails_Index]    Script Date: 18.01.2022 22:19:01 ******/
CREATE NONCLUSTERED INDEX [ReservationsFirmsDetails_Index] ON [dbo].[ReservationsFirmsDetails]
(
	[ReservationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

/****** Object:  Index [ReservationsFirmsDetails_Index_1]    Script Date: 18.01.2022 22:19:13 ******/
CREATE NONCLUSTERED INDEX [ReservationsFirmsDetails_Index_1] ON [dbo].[ReservationsFirmsDetails]
(
	[TableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

/****** Object:  Index [ReservationsFirmsEmployees_Index]    Script Date: 18.01.2022 22:19:31 ******/
CREATE NONCLUSTERED INDEX [ReservationsFirmsEmployees_Index] ON [dbo].[ReservationsFirmsEmployees]
(
	[TableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

/****** Object:  Index [ReservationsIndividuals_Index]    Script Date: 18.01.2022 22:19:46 ******/
CREATE NONCLUSTERED INDEX [ReservationsIndividuals_Index] ON [dbo].[ReservationsIndividuals]
(
	[TableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

/****** Object:  Index [ReservationsIndividuals_Index_1]    Script Date: 18.01.2022 22:20:01 ******/
CREATE NONCLUSTERED INDEX [ReservationsIndividuals_Index_1] ON [dbo].[ReservationsIndividuals]
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

/****** Object:  Index [ReservationsIndividuals_Index_2]    Script Date: 18.01.2022 22:20:12 ******/
CREATE NONCLUSTERED INDEX [ReservationsIndividuals_Index_2] ON [dbo].[ReservationsIndividuals]
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO