
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

-- Tworzenie krawędzi
INSERT INTO routes
	VALUES 
		((SELECT $node_id FROM City WHERE ID = 1), (SELECT $node_id FROM City WHERE ID = 16), 198), -- Białystok <-> Warszawa
		((SELECT $node_id FROM City WHERE ID = 1), (SELECT $node_id FROM City WHERE ID = 3), 429), -- Białystok <-> Gdańsk
		((SELECT $node_id FROM City WHERE ID = 1), (SELECT $node_id FROM City WHERE ID = 9), 254), -- Białystok <-> Lublin
		((SELECT $node_id FROM City WHERE ID = 1), (SELECT $node_id FROM City WHERE ID = 10), 243), -- Białystok <-> Olsztyn
		((SELECT $node_id FROM City WHERE ID = 2), (SELECT $node_id FROM City WHERE ID = 10), 212), -- Bydgoszcz <-> Olsztyn
		((SELECT $node_id FROM City WHERE ID = 2), (SELECT $node_id FROM City WHERE ID = 3), 167), -- Bydgoszcz <-> Gdańsk
		((SELECT $node_id FROM City WHERE ID = 2), (SELECT $node_id FROM City WHERE ID = 4), 212), -- Bydgoszcz <-> Gorzów Wielkopolski
		((SELECT $node_id FROM City WHERE ID = 2), (SELECT $node_id FROM City WHERE ID = 15), 46), -- Bydgoszcz <-> Toruń
		((SELECT $node_id FROM City WHERE ID = 2), (SELECT $node_id FROM City WHERE ID = 12), 140), -- Bydgoszcz <-> Poznań
		((SELECT $node_id FROM City WHERE ID = 2), (SELECT $node_id FROM City WHERE ID = 14), 259), -- Bydgoszcz <-> Szczecin
		((SELECT $node_id FROM City WHERE ID = 2), (SELECT $node_id FROM City WHERE ID = 16),304),
		((SELECT $node_id FROM City WHERE ID = 3), (SELECT $node_id FROM City WHERE ID = 1),249),
		((SELECT $node_id FROM City WHERE ID = 3), (SELECT $node_id FROM City WHERE ID = 2),167),
		((SELECT $node_id FROM City WHERE ID = 3), (SELECT $node_id FROM City WHERE ID = 4),520),
		((SELECT $node_id FROM City WHERE ID = 3), (SELECT $node_id FROM City WHERE ID = 5),468),
		((SELECT $node_id FROM City WHERE ID = 3), (SELECT $node_id FROM City WHERE ID = 7),154),
		((SELECT $node_id FROM City WHERE ID = 3), (SELECT $node_id FROM City WHERE ID = 9),81),
		((SELECT $node_id FROM City WHERE ID = 3), (SELECT $node_id FROM City WHERE ID = 10),413),
		((SELECT $node_id FROM City WHERE ID = 3), (SELECT $node_id FROM City WHERE ID = 11),203),
		((SELECT $node_id FROM City WHERE ID = 3), (SELECT $node_id FROM City WHERE ID = 12),473),
		((SELECT $node_id FROM City WHERE ID = 3), (SELECT $node_id FROM City WHERE ID = 14),113),
		((SELECT $node_id FROM City WHERE ID = 3), (SELECT $node_id FROM City WHERE ID = 15),381),
		((SELECT $node_id FROM City WHERE ID = 3), (SELECT $node_id FROM City WHERE ID = 16),245),
		((SELECT $node_id FROM City WHERE ID = 4), (SELECT $node_id FROM City WHERE ID = 2),293),
		((SELECT $node_id FROM City WHERE ID = 4), (SELECT $node_id FROM City WHERE ID = 5),468),
		((SELECT $node_id FROM City WHERE ID = 4), (SELECT $node_id FROM City WHERE ID = 12),164),
		((SELECT $node_id FROM City WHERE ID = 4), (SELECT $node_id FROM City WHERE ID = 14),105),
		((SELECT $node_id FROM City WHERE ID = 4), (SELECT $node_id FROM City WHERE ID = 17),292),
		((SELECT $node_id FROM City WHERE ID = 4), (SELECT $node_id FROM City WHERE ID = 18),112),
		((SELECT $node_id FROM City WHERE ID = 5), (SELECT $node_id FROM City WHERE ID = 2),406),
		((SELECT $node_id FROM City WHERE ID = 5), (SELECT $node_id FROM City WHERE ID = 3),520),
		((SELECT $node_id FROM City WHERE ID = 5), (SELECT $node_id FROM City WHERE ID = 4),468),
		((SELECT $node_id FROM City WHERE ID = 5), (SELECT $node_id FROM City WHERE ID = 6),154),
		((SELECT $node_id FROM City WHERE ID = 5), (SELECT $node_id FROM City WHERE ID = 7),81),
		((SELECT $node_id FROM City WHERE ID = 5), (SELECT $node_id FROM City WHERE ID = 8),413),
		((SELECT $node_id FROM City WHERE ID = 5), (SELECT $node_id FROM City WHERE ID = 9),203),
		((SELECT $node_id FROM City WHERE ID = 5), (SELECT $node_id FROM City WHERE ID = 10),473),
		((SELECT $node_id FROM City WHERE ID = 5), (SELECT $node_id FROM City WHERE ID = 11),113),
		((SELECT $node_id FROM City WHERE ID = 5), (SELECT $node_id FROM City WHERE ID = 12),381),
		((SELECT $node_id FROM City WHERE ID = 5), (SELECT $node_id FROM City WHERE ID = 13),245),
		((SELECT $node_id FROM City WHERE ID = 5), (SELECT $node_id FROM City WHERE ID = 14),571),
		((SELECT $node_id FROM City WHERE ID = 5), (SELECT $node_id FROM City WHERE ID = 15),362),
		((SELECT $node_id FROM City WHERE ID = 5), (SELECT $node_id FROM City WHERE ID = 16),294),
		((SELECT $node_id FROM City WHERE ID = 5), (SELECT $node_id FROM City WHERE ID = 17),194),
		((SELECT $node_id FROM City WHERE ID = 5), (SELECT $node_id FROM City WHERE ID = 18),365),
		((SELECT $node_id FROM City WHERE ID = 6), (SELECT $node_id FROM City WHERE ID = 2),363),
		((SELECT $node_id FROM City WHERE ID = 6), (SELECT $node_id FROM City WHERE ID = 3),471),
		((SELECT $node_id FROM City WHERE ID = 6), (SELECT $node_id FROM City WHERE ID = 5),154),
		((SELECT $node_id FROM City WHERE ID = 6), (SELECT $node_id FROM City WHERE ID = 7),114),
		((SELECT $node_id FROM City WHERE ID = 6), (SELECT $node_id FROM City WHERE ID = 8),193),
		((SELECT $node_id FROM City WHERE ID = 6), (SELECT $node_id FROM City WHERE ID = 9),154),
		((SELECT $node_id FROM City WHERE ID = 6), (SELECT $node_id FROM City WHERE ID = 12),365),
		((SELECT $node_id FROM City WHERE ID = 6), (SELECT $node_id FROM City WHERE ID = 13),165),
		((SELECT $node_id FROM City WHERE ID = 6), (SELECT $node_id FROM City WHERE ID = 15),312),
		((SELECT $node_id FROM City WHERE ID = 6), (SELECT $node_id FROM City WHERE ID = 16),177),
		((SELECT $node_id FROM City WHERE ID = 6), (SELECT $node_id FROM City WHERE ID = 17),348),
		((SELECT $node_id FROM City WHERE ID = 8), (SELECT $node_id FROM City WHERE ID = 1),325),
		((SELECT $node_id FROM City WHERE ID = 8), (SELECT $node_id FROM City WHERE ID = 5),413),
		((SELECT $node_id FROM City WHERE ID = 8), (SELECT $node_id FROM City WHERE ID = 6),193),
		((SELECT $node_id FROM City WHERE ID = 8), (SELECT $node_id FROM City WHERE ID = 13),178),
		((SELECT $node_id FROM City WHERE ID = 8), (SELECT $node_id FROM City WHERE ID = 16),174),
		((SELECT $node_id FROM City WHERE ID = 9), (SELECT $node_id FROM City WHERE ID = 2),223),
		((SELECT $node_id FROM City WHERE ID = 9), (SELECT $node_id FROM City WHERE ID = 3),337),
		((SELECT $node_id FROM City WHERE ID = 9), (SELECT $node_id FROM City WHERE ID = 5),203),
		((SELECT $node_id FROM City WHERE ID = 9), (SELECT $node_id FROM City WHERE ID = 6),154),
		((SELECT $node_id FROM City WHERE ID = 9), (SELECT $node_id FROM City WHERE ID = 10),294),
		((SELECT $node_id FROM City WHERE ID = 9), (SELECT $node_id FROM City WHERE ID = 11),203),
		((SELECT $node_id FROM City WHERE ID = 9), (SELECT $node_id FROM City WHERE ID = 12),206),
		((SELECT $node_id FROM City WHERE ID = 9), (SELECT $node_id FROM City WHERE ID = 13),445),
		((SELECT $node_id FROM City WHERE ID = 9), (SELECT $node_id FROM City WHERE ID = 15),183),
		((SELECT $node_id FROM City WHERE ID = 9), (SELECT $node_id FROM City WHERE ID = 16),140),
		((SELECT $node_id FROM City WHERE ID = 9), (SELECT $node_id FROM City WHERE ID = 17),221),
		((SELECT $node_id FROM City WHERE ID = 10), (SELECT $node_id FROM City WHERE ID = 1),225),
		((SELECT $node_id FROM City WHERE ID = 10), (SELECT $node_id FROM City WHERE ID = 2),212),
		((SELECT $node_id FROM City WHERE ID = 10), (SELECT $node_id FROM City WHERE ID = 3),167),
		((SELECT $node_id FROM City WHERE ID = 10), (SELECT $node_id FROM City WHERE ID = 5),473),
		((SELECT $node_id FROM City WHERE ID = 10), (SELECT $node_id FROM City WHERE ID = 9),294),
		((SELECT $node_id FROM City WHERE ID = 10), (SELECT $node_id FROM City WHERE ID = 11),492),
		((SELECT $node_id FROM City WHERE ID = 10), (SELECT $node_id FROM City WHERE ID = 12),356),
		((SELECT $node_id FROM City WHERE ID = 10), (SELECT $node_id FROM City WHERE ID = 14),536),
		((SELECT $node_id FROM City WHERE ID = 10), (SELECT $node_id FROM City WHERE ID = 15),170),
		((SELECT $node_id FROM City WHERE ID = 10), (SELECT $node_id FROM City WHERE ID = 16),214),
		((SELECT $node_id FROM City WHERE ID = 10), (SELECT $node_id FROM City WHERE ID = 17),509),
		((SELECT $node_id FROM City WHERE ID = 11), (SELECT $node_id FROM City WHERE ID = 3),538),
		((SELECT $node_id FROM City WHERE ID = 11), (SELECT $node_id FROM City WHERE ID = 5),113),
		((SELECT $node_id FROM City WHERE ID = 11), (SELECT $node_id FROM City WHERE ID = 9),203),
		((SELECT $node_id FROM City WHERE ID = 11), (SELECT $node_id FROM City WHERE ID = 10),492),
		((SELECT $node_id FROM City WHERE ID = 11), (SELECT $node_id FROM City WHERE ID = 15),380),
		((SELECT $node_id FROM City WHERE ID = 11), (SELECT $node_id FROM City WHERE ID = 16),312),
		((SELECT $node_id FROM City WHERE ID = 11), (SELECT $node_id FROM City WHERE ID = 17),97),
		((SELECT $node_id FROM City WHERE ID = 11), (SELECT $node_id FROM City WHERE ID = 18),268),
		((SELECT $node_id FROM City WHERE ID = 11), (SELECT $node_id FROM City WHERE ID = 14),474),
		((SELECT $node_id FROM City WHERE ID = 12), (SELECT $node_id FROM City WHERE ID = 2),140),
		((SELECT $node_id FROM City WHERE ID = 12), (SELECT $node_id FROM City WHERE ID = 3),311),
		((SELECT $node_id FROM City WHERE ID = 12), (SELECT $node_id FROM City WHERE ID = 4),164),
		((SELECT $node_id FROM City WHERE ID = 12), (SELECT $node_id FROM City WHERE ID = 5),381),
		((SELECT $node_id FROM City WHERE ID = 12), (SELECT $node_id FROM City WHERE ID = 6),365),
		((SELECT $node_id FROM City WHERE ID = 12), (SELECT $node_id FROM City WHERE ID = 9),206),
		((SELECT $node_id FROM City WHERE ID = 12), (SELECT $node_id FROM City WHERE ID = 10),356),
		((SELECT $node_id FROM City WHERE ID = 12), (SELECT $node_id FROM City WHERE ID = 14),266),
		((SELECT $node_id FROM City WHERE ID = 12), (SELECT $node_id FROM City WHERE ID = 15),186),
		((SELECT $node_id FROM City WHERE ID = 12), (SELECT $node_id FROM City WHERE ID = 16),311),
		((SELECT $node_id FROM City WHERE ID = 12), (SELECT $node_id FROM City WHERE ID = 17),183),
		((SELECT $node_id FROM City WHERE ID = 12), (SELECT $node_id FROM City WHERE ID = 18),153),
		((SELECT $node_id FROM City WHERE ID = 13), (SELECT $node_id FROM City WHERE ID = 5),245),
		((SELECT $node_id FROM City WHERE ID = 13), (SELECT $node_id FROM City WHERE ID = 6),165),
		((SELECT $node_id FROM City WHERE ID = 13), (SELECT $node_id FROM City WHERE ID = 8),178),
		((SELECT $node_id FROM City WHERE ID = 13), (SELECT $node_id FROM City WHERE ID = 9),445),
		((SELECT $node_id FROM City WHERE ID = 13), (SELECT $node_id FROM City WHERE ID = 16),332),
		((SELECT $node_id FROM City WHERE ID = 14), (SELECT $node_id FROM City WHERE ID = 2),259),
		((SELECT $node_id FROM City WHERE ID = 14), (SELECT $node_id FROM City WHERE ID = 3),371),
		((SELECT $node_id FROM City WHERE ID = 14), (SELECT $node_id FROM City WHERE ID = 4),105),
		((SELECT $node_id FROM City WHERE ID = 14), (SELECT $node_id FROM City WHERE ID = 5),571),
		((SELECT $node_id FROM City WHERE ID = 14), (SELECT $node_id FROM City WHERE ID = 10),536),
		((SELECT $node_id FROM City WHERE ID = 14), (SELECT $node_id FROM City WHERE ID = 11),474),
		((SELECT $node_id FROM City WHERE ID = 14), (SELECT $node_id FROM City WHERE ID = 12),266),
		((SELECT $node_id FROM City WHERE ID = 14), (SELECT $node_id FROM City WHERE ID = 17),394),
		((SELECT $node_id FROM City WHERE ID = 14), (SELECT $node_id FROM City WHERE ID = 18),213),
		((SELECT $node_id FROM City WHERE ID = 15), (SELECT $node_id FROM City WHERE ID = 2),45),
		((SELECT $node_id FROM City WHERE ID = 15), (SELECT $node_id FROM City WHERE ID = 3),179),
		((SELECT $node_id FROM City WHERE ID = 15), (SELECT $node_id FROM City WHERE ID = 5),362),
		((SELECT $node_id FROM City WHERE ID = 15), (SELECT $node_id FROM City WHERE ID = 6),312),
		((SELECT $node_id FROM City WHERE ID = 15), (SELECT $node_id FROM City WHERE ID = 9),183),
		((SELECT $node_id FROM City WHERE ID = 15), (SELECT $node_id FROM City WHERE ID = 10),170),
		((SELECT $node_id FROM City WHERE ID = 15), (SELECT $node_id FROM City WHERE ID = 11),380),
		((SELECT $node_id FROM City WHERE ID = 15), (SELECT $node_id FROM City WHERE ID = 12),186),
		((SELECT $node_id FROM City WHERE ID = 15), (SELECT $node_id FROM City WHERE ID = 16),262),
		((SELECT $node_id FROM City WHERE ID = 16), (SELECT $node_id FROM City WHERE ID = 1),198),
		((SELECT $node_id FROM City WHERE ID = 16), (SELECT $node_id FROM City WHERE ID = 2),304),
		((SELECT $node_id FROM City WHERE ID = 16), (SELECT $node_id FROM City WHERE ID = 3),340),
		((SELECT $node_id FROM City WHERE ID = 16), (SELECT $node_id FROM City WHERE ID = 5),294),
		((SELECT $node_id FROM City WHERE ID = 16), (SELECT $node_id FROM City WHERE ID = 6),177),
		((SELECT $node_id FROM City WHERE ID = 16), (SELECT $node_id FROM City WHERE ID = 8),174),
		((SELECT $node_id FROM City WHERE ID = 16), (SELECT $node_id FROM City WHERE ID = 9),140),
		((SELECT $node_id FROM City WHERE ID = 16), (SELECT $node_id FROM City WHERE ID = 10),214),
		((SELECT $node_id FROM City WHERE ID = 16), (SELECT $node_id FROM City WHERE ID = 11),312),
		((SELECT $node_id FROM City WHERE ID = 16), (SELECT $node_id FROM City WHERE ID = 12),311),
		((SELECT $node_id FROM City WHERE ID = 16), (SELECT $node_id FROM City WHERE ID = 13),332),
		((SELECT $node_id FROM City WHERE ID = 16), (SELECT $node_id FROM City WHERE ID = 15),262),
		((SELECT $node_id FROM City WHERE ID = 16), (SELECT $node_id FROM City WHERE ID = 17),355),
		((SELECT $node_id FROM City WHERE ID = 17), (SELECT $node_id FROM City WHERE ID = 4),292),
		((SELECT $node_id FROM City WHERE ID = 17), (SELECT $node_id FROM City WHERE ID = 5),194),
		((SELECT $node_id FROM City WHERE ID = 17), (SELECT $node_id FROM City WHERE ID = 6),348),
		((SELECT $node_id FROM City WHERE ID = 17), (SELECT $node_id FROM City WHERE ID = 9),221),
		((SELECT $node_id FROM City WHERE ID = 17), (SELECT $node_id FROM City WHERE ID = 10),509),
		((SELECT $node_id FROM City WHERE ID = 17), (SELECT $node_id FROM City WHERE ID = 11),97),
		((SELECT $node_id FROM City WHERE ID = 17), (SELECT $node_id FROM City WHERE ID = 12),183),
		((SELECT $node_id FROM City WHERE ID = 17), (SELECT $node_id FROM City WHERE ID = 14),394),
		((SELECT $node_id FROM City WHERE ID = 17), (SELECT $node_id FROM City WHERE ID = 16),355),
		((SELECT $node_id FROM City WHERE ID = 17), (SELECT $node_id FROM City WHERE ID = 18),187),
		((SELECT $node_id FROM City WHERE ID = 18), (SELECT $node_id FROM City WHERE ID = 4),112),
		((SELECT $node_id FROM City WHERE ID = 18), (SELECT $node_id FROM City WHERE ID = 5),365),
		((SELECT $node_id FROM City WHERE ID = 18), (SELECT $node_id FROM City WHERE ID = 11),268),
		((SELECT $node_id FROM City WHERE ID = 18), (SELECT $node_id FROM City WHERE ID = 12),153),
		((SELECT $node_id FROM City WHERE ID = 18), (SELECT $node_id FROM City WHERE ID = 14),213),
		((SELECT $node_id FROM City WHERE ID = 18), (SELECT $node_id FROM City WHERE ID = 17),187),
		((SELECT $node_id FROM City WHERE ID = 7), (SELECT $node_id FROM City WHERE ID = 8),335),
		((SELECT $node_id FROM City WHERE ID = 7), (SELECT $node_id FROM City WHERE ID = 9),280),
		((SELECT $node_id FROM City WHERE ID = 7), (SELECT $node_id FROM City WHERE ID = 13),167),
		((SELECT $node_id FROM City WHERE ID = 7), (SELECT $node_id FROM City WHERE ID = 16),290),
		((SELECT $node_id FROM City WHERE ID = 7), (SELECT $node_id FROM City WHERE ID = 6),114),
		((SELECT $node_id FROM City WHERE ID = 7), (SELECT $node_id FROM City WHERE ID = 5),81),
		((SELECT $node_id FROM City WHERE ID = 7), (SELECT $node_id FROM City WHERE ID = 3),596),
		((SELECT $node_id FROM City WHERE ID = 7), (SELECT $node_id FROM City WHERE ID = 2),482),
		((SELECT $node_id FROM City WHERE ID = 7), (SELECT $node_id FROM City WHERE ID = 1),485),
		((SELECT $node_id FROM City WHERE ID = 16), (SELECT $node_id FROM City WHERE ID = 7),290),
		((SELECT $node_id FROM City WHERE ID = 13), (SELECT $node_id FROM City WHERE ID = 7),167),
		((SELECT $node_id FROM City WHERE ID = 8), (SELECT $node_id FROM City WHERE ID = 7),335),
		((SELECT $node_id FROM City WHERE ID = 9), (SELECT $node_id FROM City WHERE ID = 7),280)

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