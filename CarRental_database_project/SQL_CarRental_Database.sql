--Tabela poniżej przedstawia dane dotyczące marek:
CREATE TABLE [dbo].[df_brand](
    [brand_id] [int] NOT NULL,
    [brand_name] [varchar](255) NULL,
    [model] [varchar](255) NULL,
    [number_of_passengers] [varchar](255) NULL,
    [category_name] [varchar](255) NULL,
    CONSTRAINT [PK_df_brand] PRIMARY KEY CLUSTERED ([brand_id] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON
    ) ON [PRIMARY]
) ON [PRIMARY]
GO
    --Tabela poniżej przedstawia dane dotyczące pojazdów:
    CREATE TABLE [dbo].[df_car](
        [car_id] [int] NOT NULL,
        [localisation_id] [int] NULL,
        [category_id] [int] NULL,
        [brand_id] [int] NULL,
        [rent_price] [decimal](10, 2) NULL,
        CONSTRAINT [PK_df_car] PRIMARY KEY CLUSTERED ([car_id] ASC) WITH (
            PAD_INDEX = OFF,
            STATISTICS_NORECOMPUTE = OFF,
            IGNORE_DUP_KEY = OFF,
            ALLOW_ROW_LOCKS = ON,
            ALLOW_PAGE_LOCKS = ON
        ) ON [PRIMARY]
    ) ON [PRIMARY]
GO
ALTER TABLE
    [dbo].[df_car] WITH CHECK
ADD
    CONSTRAINT [FK_df_car_df_brand] FOREIGN KEY ([brand_id]) REFERENCES [dbo].[df_brand] ([brand_id])
GO
ALTER TABLE
    [dbo].[df_car] CHECK CONSTRAINT [FK_df_car_df_brand]
GO
ALTER TABLE
    [dbo].[df_car] WITH CHECK
ADD
    CONSTRAINT [FK_df_car_df_category] FOREIGN KEY ([category_id]) REFERENCES [dbo].[df_category] ([category_id])
GO
ALTER TABLE
    [dbo].[df_car] CHECK CONSTRAINT [FK_df_car_df_category]
GO
ALTER TABLE
    [dbo].[df_car] WITH CHECK
ADD
    CONSTRAINT [FK_df_car_df_localisation] FOREIGN KEY ([localisation_id]) REFERENCES [dbo].[df_localisation] ([localisation_id])
GO
ALTER TABLE
    [dbo].[df_car] CHECK CONSTRAINT [FK_df_car_df_localisation]
GO
    --Tabela poniżej przedstawia kategorie pojazdów:
    CREATE TABLE [dbo].[df_category](
        [category_id] [int] NOT NULL,
        [category_name] [varchar](255) NULL,
        CONSTRAINT [PK_df_category] PRIMARY KEY CLUSTERED ([category_id] ASC) WITH (
            PAD_INDEX = OFF,
            STATISTICS_NORECOMPUTE = OFF,
            IGNORE_DUP_KEY = OFF,
            ALLOW_ROW_LOCKS = ON,
            ALLOW_PAGE_LOCKS = ON
        ) ON [PRIMARY]
    ) ON [PRIMARY]
GO
    --Tabela poniżej przedstawia dane dotyczące klientów:
    CREATE TABLE [dbo].[df_client](
        [customer_id] [int] NOT NULL,
        [first_name] [varchar](50) NULL,
        [last_name] [varchar](50) NULL,
        [address] [varchar](100) NULL,
        [email_address] [varchar](50) NULL,
        [telephone_number] [varchar](12) NULL,
        [driver_license_number] [varchar](100) NULL,
        CONSTRAINT [PK_df_client] PRIMARY KEY CLUSTERED ([customer_id] ASC) WITH (
            PAD_INDEX = OFF,
            STATISTICS_NORECOMPUTE = OFF,
            IGNORE_DUP_KEY = OFF,
            ALLOW_ROW_LOCKS = ON,
            ALLOW_PAGE_LOCKS = ON
        ) ON [PRIMARY]
    ) ON [PRIMARY]
GO
    --Tabela poniżej przedstawia dane dotyczące pracowników:
    CREATE TABLE [dbo].[df_employee](
        [employee_id] [int] NOT NULL,
        [first_name] [varchar](50) NULL,
        [last_name] [varchar](50) NULL,
        [localisation_id] [int] NULL,
        [email_address] [varchar](50) NULL,
        [telephone_number] [varchar](12) NULL,
        [employee_type] [varchar](50) NULL,
        CONSTRAINT [PK_df_employee] PRIMARY KEY CLUSTERED ([employee_id] ASC) WITH (
            PAD_INDEX = OFF,
            STATISTICS_NORECOMPUTE = OFF,
            IGNORE_DUP_KEY = OFF,
            ALLOW_ROW_LOCKS = ON,
            ALLOW_PAGE_LOCKS = ON
        ) ON [PRIMARY]
    ) ON [PRIMARY]
GO
ALTER TABLE
    [dbo].[df_employee] WITH CHECK
ADD
    CONSTRAINT [FK_df_employee_df_localisation] FOREIGN KEY ([localisation_id]) REFERENCES [dbo].[df_localisation] ([localisation_id])
GO
ALTER TABLE
    [dbo].[df_employee] CHECK CONSTRAINT [FK_df_employee_df_localisation]
GO
    --Tabela poniżej przedstawia dane dotyczące lokalizacji:
    CREATE TABLE [dbo].[df_localisation](
        [localisation_id] [int] NOT NULL,
        [localisation_name] [varchar](255) NULL,
        [localisation_address] [varchar](255) NULL,
        [telephone_number] [varchar](12) NULL,
        CONSTRAINT [PK_df_localisation] PRIMARY KEY CLUSTERED ([localisation_id] ASC) WITH (
            PAD_INDEX = OFF,
            STATISTICS_NORECOMPUTE = OFF,
            IGNORE_DUP_KEY = OFF,
            ALLOW_ROW_LOCKS = ON,
            ALLOW_PAGE_LOCKS = ON
        ) ON [PRIMARY]
    ) ON [PRIMARY]
GO
    --Tabela poniżej przedstawia dane dotyczące płatności:
    CREATE TABLE [dbo].[df_payment](
        [payment_id] [int] IDENTITY(1, 1) NOT NULL,
        [reservation_id] [int] NULL,
        [customer_id] [int] NULL,
        [payment_amount] [decimal](10, 2) NULL,
        [payment_date] [datetime] NULL,
        [payment_type] [varchar](50) NULL,
        [payment_status] [varchar](50) NULL,
        PRIMARY KEY CLUSTERED ([payment_id] ASC) WITH (
            PAD_INDEX = OFF,
            STATISTICS_NORECOMPUTE = OFF,
            IGNORE_DUP_KEY = OFF,
            ALLOW_ROW_LOCKS = ON,
            ALLOW_PAGE_LOCKS = ON
        ) ON [PRIMARY]
    ) ON [PRIMARY]
GO
ALTER TABLE
    [dbo].[df_payment] WITH CHECK
ADD
    CONSTRAINT [FK_df_payment_df_client] FOREIGN KEY([customer_id]) REFERENCES [dbo].[df_client] ([customer_id])
GO
ALTER TABLE
    [dbo].[df_payment] CHECK CONSTRAINT [FK_df_payment_df_client]
GO
ALTER TABLE
    [dbo].[df_payment] WITH CHECK
ADD
    CONSTRAINT [FK_df_payment_df_reservation] FOREIGN KEY([reservation_id]) REFERENCES [dbo].[df_reservation] ([reservation_id])
GO
ALTER TABLE
    [dbo].[df_payment] CHECK CONSTRAINT [FK_df_payment_df_reservation]
GO
    --Tabela poniżej przedstawia informację dotyczące rezerwacji:
    CREATE TABLE [dbo].[df_reservation](
        [reservation_id] [int] NOT NULL,
        [customer_id] [int] NOT NULL,
        [car_id] [int] NOT NULL,
        [pickup_date] [datetime] NOT NULL,
        [drop_date] [datetime] NOT NULL,
        [pickup_point_id] [int] NOT NULL,
        [drop_point_id] [int] NOT NULL,
        [reservation_status] [varchar](50) NOT NULL,
        [rent_price] [decimal](10, 2) NOT NULL,
        [rent_price_total] [decimal](10, 2) NOT NULL,
        [reservation_from] [datetime] NOT NULL,
        [reservation_to] [datetime] NOT NULL,
        CONSTRAINT [PK_df_reservation] PRIMARY KEY CLUSTERED ([reservation_id] ASC) WITH (
            PAD_INDEX = OFF,
            STATISTICS_NORECOMPUTE = OFF,
            IGNORE_DUP_KEY = OFF,
            ALLOW_ROW_LOCKS = ON,
            ALLOW_PAGE_LOCKS = ON
        ) ON [PRIMARY]
    ) ON [PRIMARY]
GO
ALTER TABLE
    [dbo].[df_reservation] WITH CHECK
ADD
    CONSTRAINT [FK_df_reservation_df_car] FOREIGN KEY([car_id]) REFERENCES [dbo].[df_car] ([car_id])
GO
ALTER TABLE
    [dbo].[df_reservation] CHECK CONSTRAINT [FK_df_reservation_df_car]
GO
ALTER TABLE
    [dbo].[df_reservation] WITH CHECK
ADD
    CONSTRAINT [FK_df_reservation_df_client] FOREIGN KEY([customer_id]) REFERENCES [dbo].[df_client] ([customer_id])
GO
ALTER TABLE
    [dbo].[df_reservation] CHECK CONSTRAINT [FK_df_reservation_df_client]
GO
ALTER TABLE
    [dbo].[df_reservation] WITH CHECK
ADD
    CONSTRAINT [FK_df_reservation_df_localisation] FOREIGN KEY([pickup_point_id]) REFERENCES [dbo].[df_localisation] ([localisation_id])
GO
ALTER TABLE
    [dbo].[df_reservation] CHECK CONSTRAINT [FK_df_reservation_df_localisation]
GO
ALTER TABLE
    [dbo].[df_reservation] WITH CHECK
ADD
    CONSTRAINT [FK_df_reservation_df_localisation1] FOREIGN KEY([drop_point_id]) REFERENCES [dbo].[df_localisation] ([localisation_id])
GO
ALTER TABLE
    [dbo].[df_reservation] CHECK CONSTRAINT [FK_df_reservation_df_localisation1];
GO
