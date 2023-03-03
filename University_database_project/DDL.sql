CREATE DATABASE University

USE University

------------------------------
--Creating tables 
------------------------------

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[STUDENCI](
[id_studenta] [int] NOT NULL,
[imie] varchar NULL,
[nazwisko] varchar NULL,
[data_urodzenia] [date] NULL,
[kierunek] varchar NULL,
[rok_studiow] [int] NULL,
[adres] varchar NULL,
[numer_telefonu] varchar NULL,
CONSTRAINT [PK_STUDENCI] PRIMARY KEY CLUSTERED
(
[id_studenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[KURSY](
[id_kursu] [int] NOT NULL,
[nazwa_kursu] varchar NULL,
[liczba_godzin] [int] NULL,
[opis] varchar NULL,
[wymagania] varchar NULL,
CONSTRAINT [PK_KURSY] PRIMARY KEY CLUSTERED
(
[id_kursu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[OCENY](
[id_oceny] [int] NOT NULL,
[id_studenta] [int] NOT NULL,
[id_kursu] [int] NOT NULL,
[rodzaj_oceny] varchar NULL,
[punkty_ects] [int] NULL,
CONSTRAINT [PK_OCENY] PRIMARY KEY CLUSTERED
(
[id_oceny] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[OCENY] WITH CHECK ADD CONSTRAINT [FK_OCENY_KURSY] FOREIGN KEY([id_kursu])
REFERENCES [dbo].[KURSY] ([id_kursu])
GO

ALTER TABLE [dbo].[OCENY] CHECK CONSTRAINT [FK_OCENY_KURSY]
GO

ALTER TABLE [dbo].[OCENY] WITH CHECK ADD CONSTRAINT [FK_OCENY_STUDENCI] FOREIGN KEY([id_studenta])
REFERENCES [dbo].[STUDENCI] ([id_studenta])
GO

ALTER TABLE [dbo].[OCENY] CHECK CONSTRAINT [FK_OCENY_STUDENCI]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NAUCZYCIELE](
    [id_nauczyciela] [int] NOT NULL,
    [imie] [varchar](50) NOT NULL,
    [nazwisko] [varchar](50) NOT NULL,
    [tytul_naukowy] [varchar](50) NULL,
    [stopien_naukowy] [varchar](50) NULL,
    [dzial_nauczyciela] [varchar](50) NULL,
    CONSTRAINT [PK_NAUCZYCIELE] PRIMARY KEY CLUSTERED 
    (
        [id_nauczyciela] ASC
    )WITH (
        PAD_INDEX = OFF, 
        STATISTICS_NORECOMPUTE = OFF, 
        IGNORE_DUP_KEY = OFF, 
        ALLOW_ROW_LOCKS = ON, 
        ALLOW_PAGE_LOCKS = ON, 
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[SALE](
    [numer_sali] [int] NOT NULL,
    [pojemnosc] [int] NOT NULL,
    [dostepnosc] [varchar](50) NULL,
    CONSTRAINT [PK_SALE] PRIMARY KEY CLUSTERED 
    (
        [numer_sali] ASC
    )WITH (
        PAD_INDEX = OFF, 
        STATISTICS_NORECOMPUTE = OFF, 
        IGNORE_DUP_KEY = OFF, 
        ALLOW_ROW_LOCKS = ON, 
        ALLOW_PAGE_LOCKS = ON, 
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[WYDZIALY](
    [id_wydzialu] [int] NOT NULL,
    [nazwa_wydzialu] [varchar](50) NOT NULL,
    [kierunki_studiow] [varchar](50) NULL,
    [opis_wydzialu] [varchar](500) NULL,
    CONSTRAINT [PK_WYDZIALY] PRIMARY KEY CLUSTERED 
    (
        [id_wydzialu] ASC
    )WITH (
        PAD_INDEX = OFF, 
        STATISTICS_NORECOMPUTE = OFF, 
        IGNORE_DUP_KEY = OFF, 
        ALLOW_ROW_LOCKS = ON, 
        ALLOW_PAGE_LOCKS = ON, 
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[GRUPY_ZAJECIOWE] (
[id_grupy] INT PRIMARY KEY,
[id_kursu] INT FOREIGN KEY REFERENCES [dbo].KURSY,
[numer_grupy] INT,
[liczba_studentow] INT,
[data_rozpoczecia] DATE
);

CREATE TABLE [dbo].[ZAPISY](
[id_zapisu] [int] NOT NULL,
[id_studenta] [int] NOT NULL,
[id_kursu] [int] NOT NULL,
[id_grupy] [int] NOT NULL,
[status_zapisu] varchar NULL,
[data_zapisu] [date] NULL,
CONSTRAINT [PK_ZAPISY] PRIMARY KEY CLUSTERED
(
[id_zapisu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
CONSTRAINT [FK_ZAPISY_STUDENCI] FOREIGN KEY ([id_studenta]) REFERENCES [dbo].STUDENCI,
CONSTRAINT [FK_ZAPISY_KURSY] FOREIGN KEY ([id_kursu]) REFERENCES [dbo].KURSY,
CONSTRAINT [FK_ZAPISY_GRUPY_ZAJECIOWE] FOREIGN KEY ([id_grupy]) REFERENCES [dbo].GRUPY_ZAJECIOWE
) ON [PRIMARY]

CREATE TABLE [dbo].[PRZEDMIOTY] (
[id_przedmiotu] INT PRIMARY KEY,
[nazwa_przedmiotu] VARCHAR(50),
[liczba_ects] INT,
[poziom_trudnosci] VARCHAR(50)
);

CREATE TABLE [dbo].[PLAN_ZAJEC] (
[id_planu] INT PRIMARY KEY,
[id_grupy] INT FOREIGN KEY REFERENCES [dbo].GRUPY_ZAJECIOWE,
[id_sali] INT FOREIGN KEY REFERENCES [dbo].SALE,
[id_nauczyciela] INT FOREIGN KEY REFERENCES [dbo].NAUCZYCIELE,
[id_kursu] INT FOREIGN KEY REFERENCES [dbo].KURSY,
[dzien_tygodnia] VARCHAR(50),
[godzina_rozpoczecia] TIME,
[godzina_zakonczenia] TIME
);