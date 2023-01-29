
/*
Zadanie 1

Przygotować grafową bazę danych zawierającą wszystkie (16) miasta wojewódzkie w Polsce oraz odległości w kilometrach pomiędzy nimi dla najdogodniejszej trasy.

Trasa powinna biec autostradami i/lub drogami ekspresowymi. W razie wątpliwości należy wybrać trasę proponowaną przez Google Maps. Nie należy przejmować się tym, że miasto leży w pewnej odległości od trasy (np Łódź czy Sieradz).

Nie definiujemy tras biegnących poprzez inne miasta wojewódzkie, np. nie definiujemy trasy Wrocław >> Kraków ponieważ prowadzi ona przez Katowice. Zamiast niej w bazie powinny być trasy Wrocław >> Katowice i Katowice >> Kraków.

Aby przetestować bazę należy przygotować następujące zapytania:

Najkrótsze trasy pomiędzy:
Szczecin - Rzeszów
Wrocław - Białystok
Poznań - Olsztyn
Olsztyn - Katowice

Które miasto ma najdogodniejsze połączenia ze wszystkimi pozostałymi (czyli najmniej skoków miasto-miasto)? Pewnie, któreś w centrum, może Łódź, może Warszawa...

*/

-- Tworzenie nowej bazy danych
CREATE DATABASE Graph_database;

USE Graph_database;

-- Tworzenie tabeli zawierającej informacje o miastach
CREATE TABLE City(
	ID integer PRIMARY KEY IDENTITY(1,1),
	name VARCHAR(100),
	voivodeship VARCHAR(100));

-- Tworzenie tabeli zawierającej informacje o drogach
CREATE TABLE Routes(
	ROUTE_ID integer PRIMARY KEY IDENTITY(1,1),
	CITY_FROM VARCHAR(100),
	CITY_TO VARCHAR(100),
	LENGTH DECIMAL(5,2));
	
-- Tworzenie tabeli grafowej zawierającej informacje o dystansie
CREATE TABLE Distance(length INTEGER) as EDGE;


-- Wrzucenie danych na temat miast do tabeli City
INSERT INTO City (name, voivodeship)
VALUES
	('Białystok','podlaskie'),
	('Bydgoszcz','kujawsko-pomorskie'),
	('Gdańsk','pomorskie'),
	('Gorzów Wielkopolski','lubuskie'),
	('Katowice','śląskie'),
	('Kielce','świętokrzyskie'),
	('Kraków','małopolskie'),
	('Łódź','łódzkie'),
	('Lublin','lubelskie'),
	('Olsztyn','warmińsko-mazurskie'),
	('Opole','opolskie'),
	('Poznań','wielkopolskie'),
	('Rzeszów','podkarpackie'),
	('Szczecin','zachodniopomorskie'),
	('Toruń','kujawsko-pomorskie'),
	('Warszawa','mazowieckie'),
	('Wrocław','dolnośląskie'),
	('Zielona Góra','lubuskie')
