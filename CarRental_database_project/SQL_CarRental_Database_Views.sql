-- Widok określa lokalizacje pojazdów
CREATE VIEW [dbo].[v_car_localisation]
AS
 SELECT a.car_id,
 b.brand_name,
 b.model,
 b.category_name,
 a.rent_price,
 a.localisation_id,
 c.localisation_address,
 c.telephone_number
 FROM (SELECT car_id,
 localisation_id,
 rent_price,
 brand_id
 FROM df_car) a
 INNER JOIN (SELECT brand_id,
 brand_name,
model,
category_name
 FROM df_brand) b
 ON a.brand_id = b.brand_id
 INNER JOIN (SELECT localisation_id,
 localisation_address,
telephone_number
 FROM df_localisation) c
 ON a.localisation_id = c.localisation_id;

-- Widok pokazuje dochód według określonych miesięcy
CREATE VIEW [dbo].[v_month_income]
AS
    SELECT DISTINCT Datename(month, payment_date) AS MONTH_NAME,
        Sum(payment_amount) AS INCOME
    FROM df_payment
    GROUP BY Datename(month, payment_date);
go


--widok pokazuje szczegolowe informacje na temat rezerwacji
CREATE VIEW [dbo].[v_reservations]
AS
    SELECT a.customer_id,
        a.reservation_id,
        b.first_name,
        b.last_name,
        b.email_address,
        c.car_id,
        a.payment_amount,
        a.payment_status,
        e.category_name,
        CONCAT(e.brand_name, ' ', e.model) as car_name
    FROM df_payment a
        INNER JOIN df_client b
        ON a.customer_id = b.customer_id
        INNER JOIN df_reservation c
        ON a.reservation_id = c.reservation_id
        INNER JOIN df_car d
        ON c.car_id = d.car_id
        INNER JOIN df_brand e
        ON e.brand_id = d.brand_id
    WHERE c.reservation_from > GETDATE()
        AND c.reservation_to > GETDATE()
GO

--widok pokazuję dostępne pojazdy
CREATE VIEW [dbo].[v_available_car]
AS
    SELECT b.car_id,
        a.brand_name,
        a.model,
        a.category_name,
        a.number_of_passengers,
        b.rent_price
    FROM (SELECT brand_id,
            brand_name,
            model,
            category_name,
            number_of_passengers
        FROM df_brand) a
        INNER JOIN (SELECT car_id,
            rent_price,
            brand_id
        FROM df_car) b
        ON a.brand_id = b.brand_id
    WHERE b.car_id NOT IN (SELECT car_id
    FROM df_reservation
    WHERE reservation_status = 'Zarezerwowany')
go

--widok pokazuje oczekujące płatności
CREATE VIEW [dbo].[v_waiting_payments]
AS
    SELECT a.customer_id,
        a.reservation_id,
        a.payment_amount,
        b.first_name,
        b.last_name,
        b.email_address,
        c.car_id,
        a.payment_status
    FROM df_payment a
        INNER JOIN(SELECT customer_id,
            first_name,
            last_name,
            email_address
        FROM df_client) b
        ON a.customer_id = b.customer_id
        INNER JOIN(SELECT car_id,
            reservation_id
        FROM df_reservation) c
        ON a.reservation_id = c.reservation_id
    WHERE a.payment_amount != 'paid';
go

-- Widok pokazuje wszystkie samochody
CREATE VIEW [dbo].[v_all_cars]
AS
    SELECT b.car_id,
        a.brand_name,
        a.model,
        a.category_name,
        a.number_of_passengers,
        b.rent_price,
        ISNULL(c.reservation_status, 'Dostępny') as 'car_status'
    FROM df_brand a
        INNER JOIN df_car b
        ON a.brand_id = b.brand_id
        left join df_reservation c
        on b.car_id = c.car_id
GO

-- Widok pokazuje wszystkich klientów
CREATE VIEW [dbo].[v_all_customers]
AS
    SELECT a.customer_id,
        a.first_name,
        a.last_name,
        case
 when b.reservation_status IS not null then
 'YES'
 else
 'NO'
 end as 'has_any_reservation'
    FROM df_client a
        left JOIN df_reservation b
        ON a.customer_id = b.customer_id
GO

-- Widok umożliwiający wyświetlenie wszystkich zarezerwowanych samochodów znajdujących się w bazie danych
CREATE VIEW [dbo].[v_cars_with_reservations]
AS
    SELECT c.reservation_id,
        b.car_id,
        a.brand_name,
        a.model,
        a.category_name,
        a.number_of_passengers,
        b.rent_price,
        c.reservation_status,
        c.reservation_from,
        c.reservation_to
    FROM df_brand a
        INNER JOIN df_car b
        ON a.brand_id = b.brand_id
        inner join df_reservation c
        on b.car_id = c.car_id
    WHERE b.car_id IN (
 SELECT car_id
        FROM df_reservation
        WHERE reservation_status = 'Zarezerwowany'
 )
        AND c.reservation_from > GETDATE()
        AND c.reservation_to > GETDATE()
GO

-- Widok pokazuje listę klientów, którzy mają aktualnie utworzoną rezerwację
CREATE VIEW [dbo].[v_clients_with_rented_cars]
AS
    SELECT b.customer_id, b.first_name, b.last_name, a.car_id, a.reservation_status,
        a.drop_date
    FROM
        df_reservation a
        INNER JOIN
        df_client b
        ON a.customer_id = b.customer_id
    WHERE
reservation_status = 'Zarezerwowany'
        AND
        a.reservation_from > GETDATE() AND a.reservation_to > GETDATE()
GO

