USE master;
DROP DATABASE IF EXISTS SportsClub;

CREATE DATABASE SportsClub;
USE SportsClub;

--Таблицы узлов
CREATE TABLE Person
(
id INT NOT NULL PRIMARY KEY,
name NVARCHAR(30) NOT NULL
) AS NODE;

CREATE TABLE City
(
id INT NOT NULL PRIMARY KEY,
name NVARCHAR(30) NOT NULL,
region NVARCHAR(30) NOT NULL
) AS NODE;

CREATE TABLE Club
(
id INT NOT NULL PRIMARY KEY,
name NVARCHAR(30) NOT NULL,
city NVARCHAR(30) NOT NULL
) AS NODE;

--Таблицы рёбер
CREATE TABLE FamiliarWith AS EDGE;

CREATE TABLE LivesIn  AS EDGE;

CREATE TABLE MemberOf  AS EDGE;

CREATE TABLE LocatedIn  AS EDGE;

--Добавим ограничения
ALTER TABLE FamiliarWith
ADD CONSTRAINT EC_FamiliarWith CONNECTION (Person TO Person);

ALTER TABLE LivesIn
ADD CONSTRAINT EC_LivesIn CONNECTION (Person TO City);

ALTER TABLE MemberOf
ADD CONSTRAINT EC_MemberOf CONNECTION (Person TO Club);

ALTER TABLE LocatedIn
ADD CONSTRAINT EC_LocatedIn CONNECTION (Club TO City);
GO

--Заполнение таблиц узлов
INSERT INTO Person (id, name)
VALUES (1, N'Александра'),
	   (2, N'Даниил'),
	   (3, N'Екатерина'),
       (4, N'Глеб'),
       (5, N'Ирина'),
       (6, N'Константин'),
       (7, N'Людмила'),
       (8, N'Михаил'),
       (9, N'Наталья'),
       (10, N'Олег');

INSERT INTO City (id, name, region)
VALUES (1, N'Минск', N'Минская область'),
       (2, N'Гродно', N'Гродненская область'),
       (3, N'Брест', N'Брестская область'),
       (4, N'Полоцк', N'Витебская область'),
       (5, N'Гомель', N'Гомельская область'),
       (6, N'Могилёв', N'Могилёвская область'),
       (7, N'Березино', N'Минская область'),
       (8, N'Лида', N'Гродненская область'),
       (9, N'Солигорск', N'Минская область'),
       (10, N'Слуцк', N'Минская область');

INSERT INTO Club (id, name, city)
VALUES (1, N'Случ', N'Слуцк'),
       (2, N'Сож', N'Гомель'),
       (3, N'Эридан', N'Полоцк'),
       (4, N'Шахтёр', N'Солигорск'),
       (5, N'КО Березино', N'Березино'),
       (6, N'КО Лида', N'Лида'),
       (7, N'Кронан', N'Гродно'),
       (8, N'Торпедо', N'Могилёв'),
       (9, N'Камволь', N'Минск'),
       (10, N'Берестье', N'Брест');

--Заполнение таблиц рёбер
INSERT INTO FamiliarWith ($from_id, $to_id)
VALUES  ((SELECT $node_id FROM Person WHERE id = 1),
		 (SELECT $node_id FROM Person WHERE id = 2)),
		((SELECT $node_id FROM Person WHERE id = 1),
		 (SELECT $node_id FROM Person WHERE id = 5)),
		((SELECT $node_id FROM Person WHERE id = 2),
		 (SELECT $node_id FROM Person WHERE id = 3)),
		((SELECT $node_id FROM Person WHERE id = 3),
		 (SELECT $node_id FROM Person WHERE id = 9)),
		((SELECT $node_id FROM Person WHERE id = 3),
		 (SELECT $node_id FROM Person WHERE id = 6)),
		((SELECT $node_id FROM Person WHERE id = 4),
		 (SELECT $node_id FROM Person WHERE id = 2)),
		((SELECT $node_id FROM Person WHERE id = 5),
		 (SELECT $node_id FROM Person WHERE id = 4)),
		((SELECT $node_id FROM Person WHERE id = 6),
		 (SELECT $node_id FROM Person WHERE id = 8)),
		((SELECT $node_id FROM Person WHERE id = 8),
		 (SELECT $node_id FROM Person WHERE id = 9)),
		((SELECT $node_id FROM Person WHERE id = 10),
		 (SELECT $node_id FROM Person WHERE id = 6)),
		((SELECT $node_id FROM Person WHERE id = 10),
		 (SELECT $node_id FROM Person WHERE id = 7)),
		((SELECT $node_id FROM Person WHERE id = 10),
		 (SELECT $node_id FROM Person WHERE id = 9));
GO

INSERT INTO LivesIn ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Person WHERE ID = 1),
		(SELECT $node_id FROM City WHERE ID = 10)),
	   ((SELECT $node_id FROM Person WHERE ID = 2),
		(SELECT $node_id FROM City WHERE ID = 9)),
	   ((SELECT $node_id FROM Person WHERE ID = 3),
		(SELECT $node_id FROM City WHERE ID = 8)),
	   ((SELECT $node_id FROM Person WHERE ID = 4),
		(SELECT $node_id FROM City WHERE ID = 7)),
	   ((SELECT $node_id FROM Person WHERE ID = 5),
		(SELECT $node_id FROM City WHERE ID = 6)),
	   ((SELECT $node_id FROM Person WHERE ID = 6),
		 (SELECT $node_id FROM City WHERE ID = 5)),
	   ((SELECT $node_id FROM Person WHERE ID = 7),
		 (SELECT $node_id FROM City WHERE ID = 4)),
	   ((SELECT $node_id FROM Person WHERE ID = 8),
		 (SELECT $node_id FROM City WHERE ID = 3)),
	   ((SELECT $node_id FROM Person WHERE ID = 9),
		 (SELECT $node_id FROM City WHERE ID = 2)),
	   ((SELECT $node_id FROM Person WHERE ID = 10),
		 (SELECT $node_id FROM City WHERE ID = 1));
GO


INSERT INTO MemberOf ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Person WHERE ID = 1),
		(SELECT $node_id FROM Club WHERE ID = 10)),
	   ((SELECT $node_id FROM Person WHERE ID = 2),
		(SELECT $node_id FROM Club WHERE ID = 9)),
	   ((SELECT $node_id FROM Person WHERE ID = 3),
		(SELECT $node_id FROM Club WHERE ID = 8)),
	   ((SELECT $node_id FROM Person WHERE ID = 4),
		(SELECT $node_id FROM Club WHERE ID = 7)),
	   ((SELECT $node_id FROM Person WHERE ID = 5),
		(SELECT $node_id FROM Club WHERE ID = 6)),
	   ((SELECT $node_id FROM Person WHERE ID = 6),
		 (SELECT $node_id FROM Club WHERE ID = 5)),
	   ((SELECT $node_id FROM Person WHERE ID = 7),
		 (SELECT $node_id FROM Club WHERE ID = 4)),
	   ((SELECT $node_id FROM Person WHERE ID = 8),
		 (SELECT $node_id FROM Club WHERE ID = 3)),
	   ((SELECT $node_id FROM Person WHERE ID = 9),
		 (SELECT $node_id FROM Club WHERE ID = 2)),
	   ((SELECT $node_id FROM Person WHERE ID = 10),
		 (SELECT $node_id FROM Club WHERE ID = 1));
GO

INSERT INTO LocatedIn ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Club WHERE ID = 1),
		(SELECT $node_id FROM City WHERE ID = 10)),
	   ((SELECT $node_id FROM Club WHERE ID = 2),
		(SELECT $node_id FROM City WHERE ID = 5)),
	   ((SELECT $node_id FROM Club WHERE ID = 3),
		(SELECT $node_id FROM City WHERE ID = 4)),
	   ((SELECT $node_id FROM Club WHERE ID = 4),
		(SELECT $node_id FROM City WHERE ID = 9)),
	   ((SELECT $node_id FROM Club WHERE ID = 5),
		(SELECT $node_id FROM City WHERE ID = 7)),
	   ((SELECT $node_id FROM Club WHERE ID = 6),
		 (SELECT $node_id FROM City WHERE ID = 8)),
	   ((SELECT $node_id FROM Club WHERE ID = 7),
		 (SELECT $node_id FROM City WHERE ID = 2)),
	   ((SELECT $node_id FROM Club WHERE ID = 8),
		 (SELECT $node_id FROM City WHERE ID = 6)),
	   ((SELECT $node_id FROM Club WHERE ID = 9),
		 (SELECT $node_id FROM City WHERE ID = 1)),
	   ((SELECT $node_id FROM Club WHERE ID = 10),
		 (SELECT $node_id FROM City WHERE ID = 3));
GO

--Запросы с Match

--Узнаем, с кем знаком Олег
SELECT person2.name AS person
FROM Person AS person1
	 , FamiliarWith
	 , Person AS person2
WHERE MATCH(person1-(FamiliarWith)->person2)
			AND person1.name = N'Олег';

--Узнаем, в каких спортивных клубах состоят знакомые Александры
SELECT person2.name AS person, Club.name AS club
FROM Person AS person1
	 , FamiliarWith
	 , Person AS person2
	 , MemberOf
	 , Club
WHERE MATCH(person1-(FamiliarWith)->person2-(MemberOf)->Club)
			AND person1.name = N'Александра';

 --Узнаем, в каких городах живут знакомые Даниила
SELECT person2.name AS person, City.name AS city
FROM Person AS person1
	 , FamiliarWith
	 , Person AS person2
	 , LivesIn
	 , City
WHERE MATCH(person1-(FamiliarWith)->person2-(LivesIn)->City)
	        AND person1.name = N'Екатерина';

--Узнаем, в каких городах расположены спортивные клубы, в которых состоят знакомые Олега
SELECT person2.name AS person, Club.name AS club, City.name AS city
FROM Person AS person1
	 , FamiliarWith
	 , Person AS person2
     , MemberOf
     , Club
     , LocatedIn
     , City
WHERE MATCH(person1-(FamiliarWith)->person2-(MemberOf)->Club-(LocatedIn)->City)
			AND person1.name = N'Олег';

--Узнаем, кто живёт в городах, в которых расположен спортивный клуб "Сож"
SELECT Club.name AS club, City.name AS city, person.name AS person 
FROM Club
	 , LocatedIn
	 , City
	 , LivesIn
	 , Person
WHERE MATCH(Club-(LocatedIn)->City<-(LivesIn)-Person)
			AND Club.name = N'Сож';


--Запросы с SHORTEST_PATH

--С кем может познакомиться Глеб (id = 4)
SELECT Person1.name AS PersonName
	  , STRING_AGG(Person2.name, '->') WITHIN GROUP (GRAPH PATH) AS Friends
FROM Person AS Person1
     , FamiliarWith FOR PATH AS fo
     , Person FOR PATH AS Person2
WHERE MATCH(SHORTEST_PATH(Person1(-(fo)->Person2)+))
            AND Person1.id = 4;

--С кем может познакомиться Глеб (id = 4) за 3 шага
SELECT Person1.name AS PersonName
	  , STRING_AGG(Person2.name, '->') WITHIN GROUP (GRAPH PATH) AS Friends
FROM Person AS Person1
     , FamiliarWith FOR PATH AS fo
     , Person FOR PATH AS Person2
WHERE MATCH(SHORTEST_PATH(Person1(-(fo)->Person2){1,3}))
            AND Person1.id = 4;