-- Procedura umożliwia sprawdzenie szczegółów konkretnej rezerwacji po jej ID
CREATE PROCEDURE [dbo].[p_reservation_detail]
    @reservation_id INT
AS
BEGIN
    IF @reservation_id IS NULL
 BEGIN
        RAISERROR('argument nie moze byc null',16,1);
        RETURN
    END
    IF @reservation_id NOT IN (SELECT reservation_id
    FROM df_reservation)
 BEGIN
        RAISERROR('Brak rezerwacji',16,1);
        RETURN
    END
    SELECT *
    FROM v_reservations
    WHERE reservation_id = @reservation_id
END
go

-- Procedura wyszukująca samochody po cenie od do.
CREATE PROCEDURE [dbo].[p_car_price_from_to]
    @price_from DECIMAL,
    @price_to DECIMAL
AS
SELECT CONCAT(brand_name, ' ', model) AS Car,
    number_of_passengers,
    category_name,
    rent_price
FROM df_car
    inner join df_brand
    ON df_car.brand_id = df_brand.brand_id
WHERE rent_price >= @price_from
    and rent_price <= @price_to
ORDER BY rent_price
GO

-- Procedura dodawania nowych uzytkowników
CREATE PROCEDURE [dbo].[p_add_client]
    @first_name varchar(50),
    @last_name varchar(50),
    @address varchar(100),
    @email_address varchar(50),
    @telephone_number varchar(12),
    @driver_license_number varchar(100)
AS
BEGIN
    IF @first_name IS NULL
        OR @last_name IS NULL
        OR @address IS NULL
        OR @email_address IS NULL
        OR @telephone_number IS NULL
        OR @driver_license_number IS NULL
 BEGIN
        RAISERROR('Żaden z argumentów nie może być nullem', 16, 1);
        RETURN
    END
    IF @driver_license_number in (
 SELECT driver_license_number
    from df_client
 )
 BEGIN
        RAISERROR('Klient z podanym numerem prawa jazdy już istnieje', 16, 1);
        RETURN
    END
    IF @email_address in (
 SELECT email_address
    from df_client
 )
 BEGIN
        RAISERROR('Klient z podanym adresem email już istnieje', 16, 1);
        RETURN
    END
    IF @telephone_number in (
 SELECT telephone_number
    from df_client
 )
 BEGIN
        RAISERROR('Klient z podanym numerem telefonu już istnieje', 16, 1);
        RETURN
    END
    INSERT INTO df_client
        (
        customer_id,
        first_name,
        last_name,
        address,
        email_address,
        telephone_number,
        driver_license_number
        )
    VALUES
        (
            (
 SELECT MAX(customer_id) + 1
            FROM df_client
 ),
            @first_name,
            @last_name,
            @address,
            @email_address,
            @telephone_number,
            @driver_license_number
 )
END;

--Procedura dodawania nowych samochodów do bazy danych
CREATE PROCEDURE [dbo].[p_add_new_car]
    @localisation_id INT,
    @category_id INT,
    @brand_id INT,
    @rent_price DECIMAL(10, 2)
AS
BEGIN
    IF @localisation_id IS NULL
 BEGIN
        RAISERROR('ID lokalizacji nie może być nullem', 16, 1);
        RETURN
    END
    IF @category_id IS NULL
 BEGIN
        RAISERROR('ID kategorii nie może być nullem', 16, 1);
        RETURN
    END
    IF @brand_id IS NULL
 BEGIN
        RAISERROR('ID marki nie może być nullem', 16, 1);
        RETURN
    END
    IF @rent_price IS NULL
 BEGIN
        RAISERROR('Cena wypożyczenia nie może być nullem', 16, 1);
        RETURN
    END
    IF @rent_price <= 0
 BEGIN
        RAISERROR('Cena musi być większa od zera', 16, 1);
        RETURN
    END
    IF @localisation_id NOT IN (
 SELECT localisation_id
    from df_localisation
 )
 BEGIN
        RAISERROR('Nie istnieje lokalizacja o takim ID', 16, 1);
        RETURN
    END
    IF @category_id NOT IN (
 SELECT category_id
    from df_category
 )
 BEGIN
        RAISERROR('Nie istnieje kategoria o takim ID', 16, 1);
        RETURN
    END
    IF @brand_id NOT IN (
 SELECT brand_id
    from df_brand
 )
 BEGIN
        RAISERROR('Nie istnieje marka o takim ID', 16, 1);
        RETURN
    END
    INSERT INTO df_car
        (
        car_id,
        localisation_id,
        category_id,
        brand_id,
        rent_price
        )
    VALUES
        (
            (
 SELECT MAX(car_id) + 1
            FROM df_car
 ),
            @localisation_id,
            @category_id,
            @brand_id,
            @rent_price
 )
END;

-- Procedura rezerwacji danego samochodu aby móc go wypożyczyć

CREATE PROCEDURE [dbo].[p_add_reservation]
    @customer_id INT,
    @car_id INT,
    @pickup_date DATETIME,
    @drop_date DATETIME,
    @pickup_point_id INT,
    @drop_point_id INT
AS
IF @pickup_date < GETDATE()
BEGIN
    RAISERROR('Podaj przyszłą datę', 16, 1);
    RETURN
END
IF @drop_date < GETDATE()
BEGIN
    RAISERROR('Podaj przyszłą datę', 16, 1);
    RETURN
END
IF @pickup_point_id NOT IN (
 SELECT localisation_id
FROM df_localisation
 )
BEGIN
    RAISERROR('Brak lokalizacji o takim id', 16, 1);
    RETURN
END
IF @drop_point_id NOT IN (
 SELECT localisation_id
FROM df_localisation
 )
BEGIN
    RAISERROR('Brak lokalizacji o takim id', 16, 1);
    RETURN
END
IF @car_id IN (
 select car_id
from df_reservation
WHERE car_id = @car_id
    AND reservation_from
between @pickup_date AND @drop_date
    AND reservation_status = 'Zarezerwowany'
 )
 RAISERROR('Samochod jest w tym czasie juz zarezerwowany (RESERVATION_FROM)',
16, 1);
IF @car_id IN (
 select car_id
from df_reservation
WHERE car_id = @car_id
    AND reservation_to
 between @pickup_date AND @drop_date
    AND reservation_status = 'Zarezerwowany'
 )
 RAISERROR('Samochod jest w tym czasie juz zarezerwowany (RESERVATION_TO)', 16,
1);
BEGIN
    INSERT INTO df_reservation
        (
        reservation_id,
        customer_id,
        car_id,
        pickup_date,
        reservation_from,
        reservation_to,
        drop_date,
        pickup_point_id,
        drop_point_id,
        reservation_status,
        rent_price,
        rent_price_total
        )
    VALUES
        (
            (
 SELECT MAX(reservation_id) + 1
            FROM df_reservation
 ),
            @customer_id,
            @car_id,
            @pickup_date,
            DATEADD(day, -1, @pickup_date),
            DATEADD(day, 1, @drop_date),
            @drop_date,
            @pickup_point_id,
            @drop_point_id,
            'Zarezerwowany',
            (
 SELECT rent_price
            FROM df_car
            WHERE car_id = @car_id
 ),
            (
 SELECT (DATEDIFF(DAY, @pickup_date, @drop_date)) *
 (
 SELECT rent_price
                FROM df_car
                WHERE car_id = @car_id
 )
 )
 )
END;
GO

-- Procedura umożliwiająca zmianę ceny wynajmu samochodu
CREATE PROCEDURE [dbo].[p_change_car_price]
    @car_id INT,
    @rent_price DECIMAL(10, 2)
AS
BEGIN
    IF @car_id IS NULL
 BEGIN
        RAISERROR('ID samochodu nie może być nullem', 16, 1);
        RETURN
    END
    IF @rent_price IS NULL
 BEGIN
        RAISERROR('Cena wypożyczenia nie może być nullem', 16, 1);
        RETURN
    END
    IF @rent_price <= 0
 BEGIN
        RAISERROR('Cena musi być większa od zera', 16, 1);
        RETURN
    END
    IF @car_id NOT IN (
 SELECT car_id
    from df_car
 )
 BEGIN
        RAISERROR('Nie istnieje samochód o takim ID', 16, 1);
        RETURN
    END
    UPDATE df_car
 SET rent_price = @rent_price
 WHERE car_id = @car_id
END;

-- Procedura umożliwiająca pracownikowi edycję informacji o użytkownikach
CREATE PROCEDURE [dbo].[p_change_client_info]
    @customer_id INT,
    @address varchar(100),
    @email_address varchar(50),
    @telephone_number varchar(12)
AS
BEGIN
    IF @customer_id IS NULL
 BEGIN
        RAISERROR('ID klienta nie może być nullem', 16, 1);
        RETURN
    END
    IF @address IS NULL
 BEGIN
        RAISERROR('Adres nie może być nullem', 16, 1);
        RETURN
    END
    IF @email_address IS NULL
 BEGIN
        RAISERROR('Adres email nie może być nullem', 16, 1);
        RETURN
    END
    IF @telephone_number IS NULL
 BEGIN
        RAISERROR('Numer telefonu nie może być nullem', 16, 1);
        RETURN
    END
    IF @email_address in (
 SELECT email_address
    from df_client
 )
 BEGIN
        RAISERROR('Klient z podanym adresem email już istnieje', 16, 1);
        RETURN
    END
    IF @telephone_number in (
 SELECT telephone_number
    from df_client
 )
 BEGIN
        RAISERROR('Klient z podanym numerem telefonu już istnieje', 16, 1);
        RETURN
    END
    IF @customer_id NOT IN (
 SELECT customer_id
    from df_client
 )
 BEGIN
        RAISERROR('Nie istnieje klient o takim ID', 16, 1);
        RETURN
    END
    UPDATE df_client
 SET address = @address,
 email_address = @email_address,
 telephone_number = @telephone_number
 WHERE customer_id = @customer_id
END;