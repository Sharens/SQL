
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
	voivodeship VARCHAR(100)) AS NODE;

-- Tworzenie tabeli zawierającej informacje o drogach
CREATE TABLE Routes(
	LENGTH DECIMAL) AS EDGE;


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
	('Lublin','lubelskie'),
	('Łódź','łódzkie'),
	('Olsztyn','warmińsko-mazurskie'),
	('Opole','opolskie'),
	('Poznań','wielkopolskie'),
	('Rzeszów','podkarpackie'),
	('Szczecin','zachodniopomorskie'),
	('Toruń','kujawsko-pomorskie'),
	('Warszawa','mazowieckie'),
	('Wrocław','dolnośląskie'),
	('Zielona Góra','lubuskie')

-- Tworzenie krawędzi
INSERT INTO routes
	VALUES 
	 ((SELECT $node_id FROM cities WHERE id = 1), (SELECT $node_id FROM cities WHERE id = 10), 233),
	 ((SELECT $node_id FROM cities WHERE id = 1), (SELECT $node_id FROM cities WHERE id = 16), 189),
	 ((SELECT $node_id FROM cities WHERE id = 1), (SELECT $node_id FROM cities WHERE id = 8), 237),
	 ((SELECT $node_id FROM cities WHERE id = 2), (SELECT $node_id FROM cities WHERE id = 15), 45),
	 ((SELECT $node_id FROM cities WHERE id = 2), (SELECT $node_id FROM cities WHERE id = 10), 212),
	 ((SELECT $node_id FROM cities WHERE id = 2), (SELECT $node_id FROM cities WHERE id = 3), 176),
	 ((SELECT $node_id FROM cities WHERE id = 2), (SELECT $node_id FROM cities WHERE id = 14), 254),
	 ((SELECT $node_id FROM cities WHERE id = 2), (SELECT $node_id FROM cities WHERE id = 12), 127),
	 ((SELECT $node_id FROM cities WHERE id = 2), (SELECT $node_id FROM cities WHERE id = 14), 198),
	 ((SELECT $node_id FROM cities WHERE id = 3), (SELECT $node_id FROM cities WHERE id = 14), 358),
	 ((SELECT $node_id FROM cities WHERE id = 3), (SELECT $node_id FROM cities WHERE id = 10), 214),
	 ((SELECT $node_id FROM cities WHERE id = 3), (SELECT $node_id FROM cities WHERE id = 17), 198),
	 ((SELECT $node_id FROM cities WHERE id = 3), (SELECT $node_id FROM cities WHERE id = 2), 176),
	 ((SELECT $node_id FROM cities WHERE id = 4), (SELECT $node_id FROM cities WHERE id = 14), 104),
	 ((SELECT $node_id FROM cities WHERE id = 4), (SELECT $node_id FROM cities WHERE id = 12), 158),
	 ((SELECT $node_id FROM cities WHERE id = 4), (SELECT $node_id FROM cities WHERE id = 18), 110),
	 ((SELECT $node_id FROM cities WHERE id = 5), (SELECT $node_id FROM cities WHERE id = 11), 113),
	 ((SELECT $node_id FROM cities WHERE id = 5), (SELECT $node_id FROM cities WHERE id = 9), 203),
	 ((SELECT $node_id FROM cities WHERE id = 5), (SELECT $node_id FROM cities WHERE id = 7), 78),
	 ((SELECT $node_id FROM cities WHERE id = 5), (SELECT $node_id FROM cities WHERE id = 6), 154),
	 ((SELECT $node_id FROM cities WHERE id = 6), (SELECT $node_id FROM cities WHERE id = 5), 154),
	 ((SELECT $node_id FROM cities WHERE id = 6), (SELECT $node_id FROM cities WHERE id = 7), 114),
	 ((SELECT $node_id FROM cities WHERE id = 6), (SELECT $node_id FROM cities WHERE id = 13), 154),
	 ((SELECT $node_id FROM cities WHERE id = 6), (SELECT $node_id FROM cities WHERE id = 8), 183),
	 ((SELECT $node_id FROM cities WHERE id = 6), (SELECT $node_id FROM cities WHERE id = 16), 176),
	 ((SELECT $node_id FROM cities WHERE id = 6), (SELECT $node_id FROM cities WHERE id = 9), 160),
	 ((SELECT $node_id FROM cities WHERE id = 7), (SELECT $node_id FROM cities WHERE id = 6), 114),
	 ((SELECT $node_id FROM cities WHERE id = 7), (SELECT $node_id FROM cities WHERE id = 5), 78),  
	 ((SELECT $node_id FROM cities WHERE id = 7), (SELECT $node_id FROM cities WHERE id = 13), 167),
	 ((SELECT $node_id FROM cities WHERE id = 8), (SELECT $node_id FROM cities WHERE id = 6), 183),
	 ((SELECT $node_id FROM cities WHERE id = 8), (SELECT $node_id FROM cities WHERE id = 2), 198),
	 ((SELECT $node_id FROM cities WHERE id = 8), (SELECT $node_id FROM cities WHERE id = 1), 237),
	 ((SELECT $node_id FROM cities WHERE id = 8), (SELECT $node_id FROM cities WHERE id = 16), 174),
 	 ((SELECT $node_id FROM cities WHERE id = 9), (SELECT $node_id FROM cities WHERE id = 5), 203), 
 	 ((SELECT $node_id FROM cities WHERE id = 9), (SELECT $node_id FROM cities WHERE id = 2), 226), 
	 ((SELECT $node_id FROM cities WHERE id = 9), (SELECT $node_id FROM cities WHERE id = 16), 145),
	 ((SELECT $node_id FROM cities WHERE id = 9), (SELECT $node_id FROM cities WHERE id = 12), 210),
	 ((SELECT $node_id FROM cities WHERE id = 9), (SELECT $node_id FROM cities WHERE id = 15), 180),
	 ((SELECT $node_id FROM cities WHERE id = 9), (SELECT $node_id FROM cities WHERE id = 17), 208),
	 ((SELECT $node_id FROM cities WHERE id = 10), (SELECT $node_id FROM cities WHERE id = 3), 214), 
	 ((SELECT $node_id FROM cities WHERE id = 10), (SELECT $node_id FROM cities WHERE id = 2), 212), 
	 ((SELECT $node_id FROM cities WHERE id = 10), (SELECT $node_id FROM cities WHERE id = 1), 233),
	 ((SELECT $node_id FROM cities WHERE id = 10), (SELECT $node_id FROM cities WHERE id = 15), 170),
	 ((SELECT $node_id FROM cities WHERE id = 10), (SELECT $node_id FROM cities WHERE id = 16), 221),
	 ((SELECT $node_id FROM cities WHERE id = 11), (SELECT $node_id FROM cities WHERE id = 5), 113),
	 ((SELECT $node_id FROM cities WHERE id = 11), (SELECT $node_id FROM cities WHERE id = 17), 99),
	 ((SELECT $node_id FROM cities WHERE id = 12), (SELECT $node_id FROM cities WHERE id = 9), 210),
	 ((SELECT $node_id FROM cities WHERE id = 12), (SELECT $node_id FROM cities WHERE id = 2), 127),
	 ((SELECT $node_id FROM cities WHERE id = 12), (SELECT $node_id FROM cities WHERE id = 4), 158),
	 ((SELECT $node_id FROM cities WHERE id = 12), (SELECT $node_id FROM cities WHERE id = 18), 164),
	 ((SELECT $node_id FROM cities WHERE id = 12), (SELECT $node_id FROM cities WHERE id = 17), 184),
	 ((SELECT $node_id FROM cities WHERE id = 12), (SELECT $node_id FROM cities WHERE id = 15), 161),
	 ((SELECT $node_id FROM cities WHERE id = 12), (SELECT $node_id FROM cities WHERE id = 4), 158),
	 ((SELECT $node_id FROM cities WHERE id = 13), (SELECT $node_id FROM cities WHERE id = 7), 167),
	 ((SELECT $node_id FROM cities WHERE id = 13), (SELECT $node_id FROM cities WHERE id = 6), 154),
	 ((SELECT $node_id FROM cities WHERE id = 13), (SELECT $node_id FROM cities WHERE id = 4), 158),
	 ((SELECT $node_id FROM cities WHERE id = 14), (SELECT $node_id FROM cities WHERE id = 4), 104),
	 ((SELECT $node_id FROM cities WHERE id = 14), (SELECT $node_id FROM cities WHERE id = 3), 358),
	 ((SELECT $node_id FROM cities WHERE id = 14), (SELECT $node_id FROM cities WHERE id = 2), 254),
	 ((SELECT $node_id FROM cities WHERE id = 14), (SELECT $node_id FROM cities WHERE id = 2), 254),
	 ((SELECT $node_id FROM cities WHERE id = 15), (SELECT $node_id FROM cities WHERE id = 12), 161),
	 ((SELECT $node_id FROM cities WHERE id = 15), (SELECT $node_id FROM cities WHERE id = 10), 170),
	 ((SELECT $node_id FROM cities WHERE id = 15), (SELECT $node_id FROM cities WHERE id = 9), 180),
	 ((SELECT $node_id FROM cities WHERE id = 15), (SELECT $node_id FROM cities WHERE id = 2), 45),
	 ((SELECT $node_id FROM cities WHERE id = 15), (SELECT $node_id FROM cities WHERE id = 16), 212),
	 ((SELECT $node_id FROM cities WHERE id = 16), (SELECT $node_id FROM cities WHERE id = 10), 221),
	 ((SELECT $node_id FROM cities WHERE id = 16), (SELECT $node_id FROM cities WHERE id = 9), 145),
	 ((SELECT $node_id FROM cities WHERE id = 16), (SELECT $node_id FROM cities WHERE id = 8), 174),
	 ((SELECT $node_id FROM cities WHERE id = 16), (SELECT $node_id FROM cities WHERE id = 6), 176),
	 ((SELECT $node_id FROM cities WHERE id = 16), (SELECT $node_id FROM cities WHERE id = 1), 189),
	 ((SELECT $node_id FROM cities WHERE id = 17), (SELECT $node_id FROM cities WHERE id = 18), 187),
	 ((SELECT $node_id FROM cities WHERE id = 17), (SELECT $node_id FROM cities WHERE id = 12), 184),
	 ((SELECT $node_id FROM cities WHERE id = 17), (SELECT $node_id FROM cities WHERE id = 11), 99),
	 ((SELECT $node_id FROM cities WHERE id = 17), (SELECT $node_id FROM cities WHERE id = 9), 208), 
	 ((SELECT $node_id FROM cities WHERE id = 17), (SELECT $node_id FROM cities WHERE id = 3), 198),
	 ((SELECT $node_id FROM cities WHERE id = 18), (SELECT $node_id FROM cities WHERE id = 17), 187),
	 ((SELECT $node_id FROM cities WHERE id = 18), (SELECT $node_id FROM cities WHERE id = 12), 164),
	 ((SELECT $node_id FROM cities WHERE id = 18), (SELECT $node_id FROM cities WHERE id = 4), 110)
	 ;
-------------------------------------
--Weryfikacja tras między miastami
-------------------------------------

-- Szczecin - Rzeszów
SELECT
	name,
	routes,
	length
FROM
	(
	 SELECT 
		city.name,
		STRING_AGG(pth.name, '>') WITHIN GROUP (GRAPH PATH) as routes,
		LAST_VALUE(pth.name) WITHIN GROUP (GRAPH PATH) AS LAST_NODE,
		COUNT(pth.name) WITHIN GROUP (GRAPH PATH) CNT,
		SUM(rt.length) WITHIN GROUP (GRAPH PATH) length
	 FROM
		city,
		routes FOR PATH as rt,
		city FOR PATH as pth
	 WHERE MATCH(SHORTEST_PATH(city(-(rt)->pth)+))
	AND city.name = 'Szczecin'
) AS a
WHERE a.LAST_NODE = 'Rzeszów'


-- Wrocław - Białystok
SELECT
	name,
	routes,
	length
FROM
	(
	 SELECT 
		city.name,
		STRING_AGG(pth.name, '>') WITHIN GROUP (GRAPH PATH) as routes,
		LAST_VALUE(pth.name) WITHIN GROUP (GRAPH PATH) AS LAST_NODE,
		COUNT(pth.name) WITHIN GROUP (GRAPH PATH) CNT,
		SUM(rt.length) WITHIN GROUP (GRAPH PATH) length
	 FROM
		city,
		routes FOR PATH as rt,
		city FOR PATH as pth
	 WHERE MATCH(SHORTEST_PATH(city(-(rt)->pth)+))
	AND city.name = 'Wrocław'
) AS a
WHERE a.LAST_NODE = 'Białystok'


-- Poznań - Olsztyn
SELECT
	name,
	routes,
	length
FROM
	(
	 SELECT 
		city.name,
		STRING_AGG(pth.name, '>') WITHIN GROUP (GRAPH PATH) as routes,
		LAST_VALUE(pth.name) WITHIN GROUP (GRAPH PATH) AS LAST_NODE,
		COUNT(pth.name) WITHIN GROUP (GRAPH PATH) CNT,
		SUM(rt.length) WITHIN GROUP (GRAPH PATH) length
	 FROM
		city,
		routes FOR PATH as rt,
		city FOR PATH as pth
	 WHERE MATCH(SHORTEST_PATH(city(-(rt)->pth)+))
	AND city.name = 'Poznań'
) AS a
WHERE a.LAST_NODE = 'Olsztyn'

-- Olsztyn - Katowice
SELECT
	name,
	routes,
	length
FROM
	(
	 SELECT 
		city.name,
		STRING_AGG(pth.name, '>') WITHIN GROUP (GRAPH PATH) as routes,
		LAST_VALUE(pth.name) WITHIN GROUP (GRAPH PATH) AS LAST_NODE,
		COUNT(pth.name) WITHIN GROUP (GRAPH PATH) CNT,
		SUM(rt.length) WITHIN GROUP (GRAPH PATH) length
	 FROM
		city,
		routes FOR PATH as rt,
		city FOR PATH as pth
	 WHERE MATCH(SHORTEST_PATH(city(-(rt)->pth)+))
	AND city.name = 'Olsztyn'
) AS a
WHERE a.LAST_NODE = 'Katowice'

-------------------------------------
--Miasto z największą ilością połączeń
-------------------------------------

SELECT 
	name, 
	COUNT(*) AS connections
FROM 
	routes
JOIN 
	city 
	AS node ON routes.$from_id = $node_id
GROUP BY name
ORDER BY connections DESC;

-----------------------------------------------------------
-- Sprawdzenie, jakie miasto ma najmniejszą ilością skoków
-----------------------------------------------------------

SELECT
	StartPoint,
	SUM(Points) AS AllCities
FROM (
	SELECT
		FromCity.name AS StartPoint,
		COUNT(AnotherCity.name)				WITHIN GROUP (GRAPH PATH) AS Points
	FROM
		City AS FromCity,
		Routes FOR PATH,
		City FOR PATH AS AnotherCity
	WHERE MATCH(SHORTEST_PATH(FromCity(-(Routes)->AnotherCity)+))
) AS AllShortestPaths
GROUP BY AllShortestPaths.StartPoint
ORDER BY SUM(Points);