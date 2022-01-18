USE [u_lacki]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 18.01.2022 22:02:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryName] [varchar](50) NOT NULL,
	[Description] [varchar](500) NULL,
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_Categories] UNIQUE NONCLUSTERED 
(
	[CategoryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cities]    Script Date: 18.01.2022 22:02:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cities](
	[CityName] [varchar](50) NOT NULL,
	[CityID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [AK_CityName] UNIQUE NONCLUSTERED 
(
	[CityName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerDiscountFT]    Script Date: 18.01.2022 22:02:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerDiscountFT](
	[CustomerID] [int] NOT NULL,
	[DiscountID] [int] NOT NULL,
	[ReceivedDate] [date] NOT NULL,
 CONSTRAINT [PK_CustomerDiscountFT] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerDiscountsST]    Script Date: 18.01.2022 22:02:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerDiscountsST](
	[CustomerID] [int] NOT NULL,
	[ReceivedDate] [date] NOT NULL,
	[UseDate] [date] NULL,
	[DiscountID] [int] NOT NULL,
	[DiscountSTID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DiscountSTID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerFirms]    Script Date: 18.01.2022 22:02:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerFirms](
	[NIP] [nchar](10) NOT NULL,
	[CompanyName] [varchar](50) NOT NULL,
	[Address] [varchar](50) NOT NULL,
	[PostalCode] [varchar](50) NOT NULL,
	[CityID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
 CONSTRAINT [PK_CustomerFirms_1] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [AK_CompanyName] UNIQUE NONCLUSTERED 
(
	[CompanyName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_CustomerFirms] UNIQUE NONCLUSTERED 
(
	[NIP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerFirmsEmployees]    Script Date: 18.01.2022 22:02:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerFirmsEmployees](
	[FirmID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
 CONSTRAINT [PK_CustomerFirmsEmployees_1] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerIndividuals]    Script Date: 18.01.2022 22:02:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerIndividuals](
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[CustomerID] [int] NOT NULL,
 CONSTRAINT [PK_CustomerIndividuals] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 18.01.2022 22:02:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Phone] [nchar](9) NOT NULL,
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_Customers] UNIQUE NONCLUSTERED 
(
	[Phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Discounts]    Script Date: 18.01.2022 22:02:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discounts](
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NULL,
	[DiscountID] [int] IDENTITY(1,1) NOT NULL,
	[DiscountType] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[DiscountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiscountSetDetails]    Script Date: 18.01.2022 22:02:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiscountSetDetails](
	[DiscountID] [int] NOT NULL,
	[SetID] [int] NOT NULL,
	[Value] [int] NOT NULL,
 CONSTRAINT [PK_DiscountSetDetails] PRIMARY KEY CLUSTERED 
(
	[DiscountID] ASC,
	[SetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiscountsSet]    Script Date: 18.01.2022 22:02:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiscountsSet](
	[SetName] [varchar](50) NOT NULL,
	[SetID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [AK_SetName] UNIQUE NONCLUSTERED 
(
	[SetName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dishes]    Script Date: 18.01.2022 22:02:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dishes](
	[DishName] [varchar](50) NOT NULL,
	[Description] [varchar](500) NULL,
	[CategoryID] [int] NOT NULL,
	[MinStockValue] [int] NULL,
	[DishID] [int] IDENTITY(1,1) NOT NULL,
	[StartUnits] [int] NOT NULL,
	[BasicDishPrice] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DishID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_Dishes] UNIQUE NONCLUSTERED 
(
	[DishName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DishesHistory]    Script Date: 18.01.2022 22:02:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DishesHistory](
	[DishPrice] [decimal](10, 2) NOT NULL,
	[InMenuDate] [date] NOT NULL,
	[OutMenuDate] [date] NULL,
	[UnitsInStock] [int] NOT NULL,
	[DishID] [int] NOT NULL,
	[DishesHistoryID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK__DishesHi__5B032715F8DDB909] PRIMARY KEY CLUSTERED 
(
	[DishesHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 18.01.2022 22:02:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[ManagerID] [int] NULL,
	[Phone] [nchar](9) NOT NULL,
	[CityID] [int] NOT NULL,
	[PostalCode] [varchar](50) NOT NULL,
	[Address] [varchar](50) NOT NULL,
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_Employees] UNIQUE NONCLUSTERED 
(
	[Phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 18.01.2022 22:02:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderID] [int] NOT NULL,
	[DishesHistoryID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[DishPrice] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK_Order Details] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[DishesHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 18.01.2022 22:02:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[CustomerID] [int] NOT NULL,
	[EmployeeID] [int] NULL,
	[OrderDate] [date] NOT NULL,
	[ReceiveDate] [datetime] NOT NULL,
	[PaymentTypeID] [int] NOT NULL,
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentType]    Script Date: 18.01.2022 22:02:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentType](
	[PaymentName] [varchar](50) NOT NULL,
	[PaymentTypeID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [AK_PaymentName] UNIQUE NONCLUSTERED 
(
	[PaymentName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReservationRequirements]    Script Date: 18.01.2022 22:02:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReservationRequirements](
	[WZValue] [int] NOT NULL,
	[WKValue] [int] NOT NULL,
 CONSTRAINT [IX_ReservationRequirements] UNIQUE NONCLUSTERED 
(
	[WZValue] ASC,
	[WKValue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reservations]    Script Date: 18.01.2022 22:02:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservations](
	[ReservationDate] [date] NOT NULL,
	[EmployeeID] [int] NULL,
	[ReservationID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ReservationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReservationsFirms]    Script Date: 18.01.2022 22:02:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReservationsFirms](
	[ReservationID] [int] NOT NULL,
	[FirmID] [int] NOT NULL,
 CONSTRAINT [PK_ReservationFirms] PRIMARY KEY CLUSTERED 
(
	[ReservationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReservationsFirmsDetails]    Script Date: 18.01.2022 22:02:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReservationsFirmsDetails](
	[ReservationID] [int] NOT NULL,
	[PeopleCount] [int] NOT NULL,
	[TableID] [int] NULL,
	[RFDID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RFDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReservationsFirmsEmployees]    Script Date: 18.01.2022 22:02:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReservationsFirmsEmployees](
	[ReservationID] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[TableID] [int] NULL,
	[PeopleCount] [int] NOT NULL,
 CONSTRAINT [PK_ReservationDetailsFirms_1] PRIMARY KEY CLUSTERED 
(
	[ReservationID] ASC,
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReservationsIndividuals]    Script Date: 18.01.2022 22:02:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReservationsIndividuals](
	[ReservationID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[OrderID] [int] NOT NULL,
	[TableID] [int] NULL,
	[PeopleCount] [int] NOT NULL,
 CONSTRAINT [PK_Reservations] PRIMARY KEY CLUSTERED 
(
	[ReservationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tables]    Script Date: 18.01.2022 22:02:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tables](
	[Places] [int] NOT NULL,
	[TableID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CustomerDiscountFT] ADD  CONSTRAINT [DF_CustomerDiscountFT_ReceivedDate]  DEFAULT (getdate()) FOR [ReceivedDate]
GO
ALTER TABLE [dbo].[CustomerDiscountsST] ADD  CONSTRAINT [DF_CustomerDiscountsST_ReceivedDate]  DEFAULT (getdate()) FOR [ReceivedDate]
GO
ALTER TABLE [dbo].[CustomerDiscountsST] ADD  CONSTRAINT [DF_CustomerDiscountsST_UseDate]  DEFAULT (NULL) FOR [UseDate]
GO
ALTER TABLE [dbo].[Discounts] ADD  CONSTRAINT [DF_Discounts_StartDate]  DEFAULT (getdate()) FOR [StartDate]
GO
ALTER TABLE [dbo].[Discounts] ADD  CONSTRAINT [DF_Discounts_EndDate]  DEFAULT (NULL) FOR [EndDate]
GO
ALTER TABLE [dbo].[DiscountSetDetails] ADD  CONSTRAINT [DF_DiscountSetDetails_Value]  DEFAULT ((0)) FOR [Value]
GO
ALTER TABLE [dbo].[Dishes] ADD  DEFAULT ('30') FOR [StartUnits]
GO
ALTER TABLE [dbo].[Dishes] ADD  DEFAULT ('0') FOR [BasicDishPrice]
GO
ALTER TABLE [dbo].[DishesHistory] ADD  CONSTRAINT [DF_DishesHistory_OutMenuDate]  DEFAULT (NULL) FOR [OutMenuDate]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_OrderDate]  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_ReceiveDate]  DEFAULT (getdate()) FOR [ReceiveDate]
GO
ALTER TABLE [dbo].[Reservations] ADD  CONSTRAINT [DF_Reservations_EmployeeID]  DEFAULT (NULL) FOR [EmployeeID]
GO
ALTER TABLE [dbo].[ReservationsFirmsDetails] ADD  CONSTRAINT [DF_ReservationsFirmsDetails_TableID]  DEFAULT (NULL) FOR [TableID]
GO
ALTER TABLE [dbo].[ReservationsFirmsEmployees] ADD  CONSTRAINT [DF_ReservationsFirmsEmployees_TableID]  DEFAULT (NULL) FOR [TableID]
GO
ALTER TABLE [dbo].[ReservationsIndividuals] ADD  CONSTRAINT [DF_ReservationsIndividuals_TableID]  DEFAULT (NULL) FOR [TableID]
GO
ALTER TABLE [dbo].[CustomerDiscountFT]  WITH CHECK ADD  CONSTRAINT [FK_CustomerDiscountFT_CustomerIndividuals] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[CustomerIndividuals] ([CustomerID])
GO
ALTER TABLE [dbo].[CustomerDiscountFT] CHECK CONSTRAINT [FK_CustomerDiscountFT_CustomerIndividuals]
GO
ALTER TABLE [dbo].[CustomerDiscountFT]  WITH CHECK ADD  CONSTRAINT [FK_CustomerDiscountFT_Discounts] FOREIGN KEY([DiscountID])
REFERENCES [dbo].[Discounts] ([DiscountID])
GO
ALTER TABLE [dbo].[CustomerDiscountFT] CHECK CONSTRAINT [FK_CustomerDiscountFT_Discounts]
GO
ALTER TABLE [dbo].[CustomerDiscountsST]  WITH CHECK ADD  CONSTRAINT [FK_CustomerDiscountsST_CustomerIndividuals] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[CustomerIndividuals] ([CustomerID])
GO
ALTER TABLE [dbo].[CustomerDiscountsST] CHECK CONSTRAINT [FK_CustomerDiscountsST_CustomerIndividuals]
GO
ALTER TABLE [dbo].[CustomerDiscountsST]  WITH CHECK ADD  CONSTRAINT [FK_CustomerDiscountsST_Discounts] FOREIGN KEY([DiscountID])
REFERENCES [dbo].[Discounts] ([DiscountID])
GO
ALTER TABLE [dbo].[CustomerDiscountsST] CHECK CONSTRAINT [FK_CustomerDiscountsST_Discounts]
GO
ALTER TABLE [dbo].[CustomerFirms]  WITH CHECK ADD  CONSTRAINT [FK_CustomerFirms_Cities] FOREIGN KEY([CityID])
REFERENCES [dbo].[Cities] ([CityID])
GO
ALTER TABLE [dbo].[CustomerFirms] CHECK CONSTRAINT [FK_CustomerFirms_Cities]
GO
ALTER TABLE [dbo].[CustomerFirms]  WITH CHECK ADD  CONSTRAINT [FK_CustomerFirms_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[CustomerFirms] CHECK CONSTRAINT [FK_CustomerFirms_Customers]
GO
ALTER TABLE [dbo].[CustomerFirmsEmployees]  WITH CHECK ADD  CONSTRAINT [FK_CustomerFirmsEmployees_CustomerFirms] FOREIGN KEY([FirmID])
REFERENCES [dbo].[CustomerFirms] ([CustomerID])
GO
ALTER TABLE [dbo].[CustomerFirmsEmployees] CHECK CONSTRAINT [FK_CustomerFirmsEmployees_CustomerFirms]
GO
ALTER TABLE [dbo].[CustomerFirmsEmployees]  WITH CHECK ADD  CONSTRAINT [FK_CustomerFirmsEmployees_CustomerIndividuals] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[CustomerIndividuals] ([CustomerID])
GO
ALTER TABLE [dbo].[CustomerFirmsEmployees] CHECK CONSTRAINT [FK_CustomerFirmsEmployees_CustomerIndividuals]
GO
ALTER TABLE [dbo].[CustomerIndividuals]  WITH CHECK ADD  CONSTRAINT [FK_CustomerIndividuals_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[CustomerIndividuals] CHECK CONSTRAINT [FK_CustomerIndividuals_Customers]
GO
ALTER TABLE [dbo].[DiscountSetDetails]  WITH CHECK ADD  CONSTRAINT [FK_DiscountSetDetails_Discounts] FOREIGN KEY([DiscountID])
REFERENCES [dbo].[Discounts] ([DiscountID])
GO
ALTER TABLE [dbo].[DiscountSetDetails] CHECK CONSTRAINT [FK_DiscountSetDetails_Discounts]
GO
ALTER TABLE [dbo].[DiscountSetDetails]  WITH CHECK ADD  CONSTRAINT [FK_DiscountSetDetails_DiscountsSet] FOREIGN KEY([SetID])
REFERENCES [dbo].[DiscountsSet] ([SetID])
GO
ALTER TABLE [dbo].[DiscountSetDetails] CHECK CONSTRAINT [FK_DiscountSetDetails_DiscountsSet]
GO
ALTER TABLE [dbo].[Dishes]  WITH CHECK ADD  CONSTRAINT [FK_Dishes_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Dishes] CHECK CONSTRAINT [FK_Dishes_Categories]
GO
ALTER TABLE [dbo].[DishesHistory]  WITH CHECK ADD  CONSTRAINT [FK_DishesHistory_Dishes] FOREIGN KEY([DishID])
REFERENCES [dbo].[Dishes] ([DishID])
GO
ALTER TABLE [dbo].[DishesHistory] CHECK CONSTRAINT [FK_DishesHistory_Dishes]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Cities] FOREIGN KEY([CityID])
REFERENCES [dbo].[Cities] ([CityID])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_Cities]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Employees] FOREIGN KEY([ManagerID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_Employees]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_DishesHistory] FOREIGN KEY([DishesHistoryID])
REFERENCES [dbo].[DishesHistory] ([DishesHistoryID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_DishesHistory]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Employees]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_PaymentType] FOREIGN KEY([PaymentTypeID])
REFERENCES [dbo].[PaymentType] ([PaymentTypeID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_PaymentType]
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD  CONSTRAINT [FK_Reservations_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [FK_Reservations_Employees]
GO
ALTER TABLE [dbo].[ReservationsFirms]  WITH CHECK ADD  CONSTRAINT [FK_ReservationsFirms_CustomerFirms] FOREIGN KEY([FirmID])
REFERENCES [dbo].[CustomerFirms] ([CustomerID])
GO
ALTER TABLE [dbo].[ReservationsFirms] CHECK CONSTRAINT [FK_ReservationsFirms_CustomerFirms]
GO
ALTER TABLE [dbo].[ReservationsFirms]  WITH CHECK ADD  CONSTRAINT [FK_ReservationsFirms_Reservations] FOREIGN KEY([ReservationID])
REFERENCES [dbo].[Reservations] ([ReservationID])
GO
ALTER TABLE [dbo].[ReservationsFirms] CHECK CONSTRAINT [FK_ReservationsFirms_Reservations]
GO
ALTER TABLE [dbo].[ReservationsFirmsDetails]  WITH CHECK ADD  CONSTRAINT [FK_ReservationsFirmsDetails_ReservationsFirms] FOREIGN KEY([ReservationID])
REFERENCES [dbo].[ReservationsFirms] ([ReservationID])
GO
ALTER TABLE [dbo].[ReservationsFirmsDetails] CHECK CONSTRAINT [FK_ReservationsFirmsDetails_ReservationsFirms]
GO
ALTER TABLE [dbo].[ReservationsFirmsDetails]  WITH CHECK ADD  CONSTRAINT [FK_ReservationsFirmsDetails_Tables] FOREIGN KEY([TableID])
REFERENCES [dbo].[Tables] ([TableID])
GO
ALTER TABLE [dbo].[ReservationsFirmsDetails] CHECK CONSTRAINT [FK_ReservationsFirmsDetails_Tables]
GO
ALTER TABLE [dbo].[ReservationsFirmsEmployees]  WITH CHECK ADD  CONSTRAINT [FK_ReservationsFirmsEmployees_CustomerFirmsEmployees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[CustomerFirmsEmployees] ([CustomerID])
GO
ALTER TABLE [dbo].[ReservationsFirmsEmployees] CHECK CONSTRAINT [FK_ReservationsFirmsEmployees_CustomerFirmsEmployees]
GO
ALTER TABLE [dbo].[ReservationsFirmsEmployees]  WITH CHECK ADD  CONSTRAINT [FK_ReservationsFirmsEmployees_ReservationsFirms] FOREIGN KEY([ReservationID])
REFERENCES [dbo].[ReservationsFirms] ([ReservationID])
GO
ALTER TABLE [dbo].[ReservationsFirmsEmployees] CHECK CONSTRAINT [FK_ReservationsFirmsEmployees_ReservationsFirms]
GO
ALTER TABLE [dbo].[ReservationsFirmsEmployees]  WITH CHECK ADD  CONSTRAINT [FK_ReservationsFirmsEmployees_Tables] FOREIGN KEY([TableID])
REFERENCES [dbo].[Tables] ([TableID])
GO
ALTER TABLE [dbo].[ReservationsFirmsEmployees] CHECK CONSTRAINT [FK_ReservationsFirmsEmployees_Tables]
GO
ALTER TABLE [dbo].[ReservationsIndividuals]  WITH CHECK ADD  CONSTRAINT [FK_ReservationsIndividuals_CustomerIndividuals] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[CustomerIndividuals] ([CustomerID])
GO
ALTER TABLE [dbo].[ReservationsIndividuals] CHECK CONSTRAINT [FK_ReservationsIndividuals_CustomerIndividuals]
GO
ALTER TABLE [dbo].[ReservationsIndividuals]  WITH CHECK ADD  CONSTRAINT [FK_ReservationsIndividuals_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[ReservationsIndividuals] CHECK CONSTRAINT [FK_ReservationsIndividuals_Orders]
GO
ALTER TABLE [dbo].[ReservationsIndividuals]  WITH CHECK ADD  CONSTRAINT [FK_ReservationsIndividuals_Reservations] FOREIGN KEY([ReservationID])
REFERENCES [dbo].[Reservations] ([ReservationID])
GO
ALTER TABLE [dbo].[ReservationsIndividuals] CHECK CONSTRAINT [FK_ReservationsIndividuals_Reservations]
GO
ALTER TABLE [dbo].[ReservationsIndividuals]  WITH CHECK ADD  CONSTRAINT [FK_ReservationsIndividuals_Tables] FOREIGN KEY([TableID])
REFERENCES [dbo].[Tables] ([TableID])
GO
ALTER TABLE [dbo].[ReservationsIndividuals] CHECK CONSTRAINT [FK_ReservationsIndividuals_Tables]
GO
ALTER TABLE [dbo].[CustomerDiscountsST]  WITH CHECK ADD  CONSTRAINT [CK_CustomerDiscountsST] CHECK  (([UseDate] IS NULL OR [UseDate]>[ReceivedDate]))
GO
ALTER TABLE [dbo].[CustomerDiscountsST] CHECK CONSTRAINT [CK_CustomerDiscountsST]
GO
ALTER TABLE [dbo].[CustomerFirms]  WITH CHECK ADD  CONSTRAINT [CKNIP] CHECK  ((isnumeric([NIP])=(1)))
GO
ALTER TABLE [dbo].[CustomerFirms] CHECK CONSTRAINT [CKNIP]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [CKPhone] CHECK  ((isnumeric([Phone])=(1)))
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [CKPhone]
GO
ALTER TABLE [dbo].[Discounts]  WITH CHECK ADD  CONSTRAINT [CK_Discounts] CHECK  (([EndDate] IS NULL OR [EndDate]>[StartDate]))
GO
ALTER TABLE [dbo].[Discounts] CHECK CONSTRAINT [CK_Discounts]
GO
ALTER TABLE [dbo].[Dishes]  WITH CHECK ADD  CONSTRAINT [CK_Dishes] CHECK  (([MinStockValue]>(0)))
GO
ALTER TABLE [dbo].[Dishes] CHECK CONSTRAINT [CK_Dishes]
GO
ALTER TABLE [dbo].[DishesHistory]  WITH CHECK ADD  CONSTRAINT [CK_DishesHistory] CHECK  (([DishPrice]>(0)))
GO
ALTER TABLE [dbo].[DishesHistory] CHECK CONSTRAINT [CK_DishesHistory]
GO
ALTER TABLE [dbo].[DishesHistory]  WITH CHECK ADD  CONSTRAINT [CK_DishesHistory_1] CHECK  (([OutMenuDate] IS NULL OR [OutMenuDate]>[InMenuDate]))
GO
ALTER TABLE [dbo].[DishesHistory] CHECK CONSTRAINT [CK_DishesHistory_1]
GO
ALTER TABLE [dbo].[DishesHistory]  WITH CHECK ADD  CONSTRAINT [CK_DishesHistory_2] CHECK  (([UnitsInStock]>=(0)))
GO
ALTER TABLE [dbo].[DishesHistory] CHECK CONSTRAINT [CK_DishesHistory_2]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [CK_Employees] CHECK  ((isnumeric([Phone])=(1)))
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [CK_Employees]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [CK_OrderDetails] CHECK  (([Quantity]>(0)))
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [CK_OrderDetails]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [CK_OrderDetails_1] CHECK  (([DishPrice]>=(0)))
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [CK_OrderDetails_1]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [CK_Orders] CHECK  (([ReceiveDate]>=[OrderDate]))
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [CK_Orders]
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD  CONSTRAINT [CK_Reservations] CHECK  (([ReservationDate]>getdate()))
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [CK_Reservations]
GO
ALTER TABLE [dbo].[ReservationsFirmsDetails]  WITH CHECK ADD  CONSTRAINT [CK_ReservationsFirmsDetails] CHECK  (([PeopleCount]>=(2)))
GO
ALTER TABLE [dbo].[ReservationsFirmsDetails] CHECK CONSTRAINT [CK_ReservationsFirmsDetails]
GO
ALTER TABLE [dbo].[ReservationsFirmsEmployees]  WITH CHECK ADD  CONSTRAINT [CK_ReservationsFirmsEmployees] CHECK  (([PeopleCount]>=(2)))
GO
ALTER TABLE [dbo].[ReservationsFirmsEmployees] CHECK CONSTRAINT [CK_ReservationsFirmsEmployees]
GO
ALTER TABLE [dbo].[ReservationsIndividuals]  WITH CHECK ADD  CONSTRAINT [CK_ReservationsIndividuals] CHECK  (([PeopleCount]>=(2)))
GO
ALTER TABLE [dbo].[ReservationsIndividuals] CHECK CONSTRAINT [CK_ReservationsIndividuals]
GO
ALTER TABLE [dbo].[Tables]  WITH CHECK ADD  CONSTRAINT [CK_Tables] CHECK  (([Places]>=(2)))
GO
ALTER TABLE [dbo].[Tables] CHECK CONSTRAINT [CK_Tables]
GO
