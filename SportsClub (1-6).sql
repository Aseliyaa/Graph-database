USE master;
DROP DATABASE IF EXISTS SportsClub;

CREATE DATABASE SportsClub;
USE SportsClub;

--������� �����
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

--������� ����
CREATE TABLE FamiliarWith AS EDGE;

CREATE TABLE LivesIn  AS EDGE;

CREATE TABLE MemberOf  AS EDGE;

CREATE TABLE LocatedIn  AS EDGE;

--������� �����������
ALTER TABLE FamiliarWith
ADD CONSTRAINT EC_FamiliarWith CONNECTION (Person TO Person);

ALTER TABLE LivesIn
ADD CONSTRAINT EC_LivesIn CONNECTION (Person TO City);

ALTER TABLE MemberOf
ADD CONSTRAINT EC_MemberOf CONNECTION (Person TO Club);

ALTER TABLE LocatedIn
ADD CONSTRAINT EC_LocatedIn CONNECTION (Club TO City);
GO

--���������� ������ �����
INSERT INTO Person (id, name)
VALUES (1, N'����������'),
	   (2, N'������'),
	   (3, N'���������'),
       (4, N'����'),
       (5, N'�����'),
       (6, N'����������'),
       (7, N'�������'),
       (8, N'������'),
       (9, N'�������'),
       (10, N'����');

INSERT INTO City (id, name, region)
VALUES (1, N'�����', N'������� �������'),
       (2, N'������', N'����������� �������'),
       (3, N'�����', N'��������� �������'),
       (4, N'������', N'��������� �������'),
       (5, N'������', N'���������� �������'),
       (6, N'������', N'���������� �������'),
       (7, N'��������', N'������� �������'),
       (8, N'����', N'����������� �������'),
       (9, N'���������', N'������� �������'),
       (10, N'�����', N'������� �������');

INSERT INTO Club (id, name, city)
VALUES (1, N'����', N'�����'),
       (2, N'���', N'������'),
       (3, N'������', N'������'),
       (4, N'�����', N'���������'),
       (5, N'�� ��������', N'��������'),
       (6, N'�� ����', N'����'),
       (7, N'������', N'������'),
       (8, N'�������', N'������'),
       (9, N'�������', N'�����'),
       (10, N'��������', N'�����');

--���������� ������ ����
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

--������� � Match

--������, � ��� ������ ����
SELECT person2.name AS person
FROM Person AS person1
	 , FamiliarWith
	 , Person AS person2
WHERE MATCH(person1-(FamiliarWith)->person2)
			AND person1.name = N'����';

--������, � ����� ���������� ������ ������� �������� ����������
SELECT person2.name AS person, Club.name AS club
FROM Person AS person1
	 , FamiliarWith
	 , Person AS person2
	 , MemberOf
	 , Club
WHERE MATCH(person1-(FamiliarWith)->person2-(MemberOf)->Club)
			AND person1.name = N'����������';

 --������, � ����� ������� ����� �������� �������
SELECT person2.name AS person, City.name AS city
FROM Person AS person1
	 , FamiliarWith
	 , Person AS person2
	 , LivesIn
	 , City
WHERE MATCH(person1-(FamiliarWith)->person2-(LivesIn)->City)
	        AND person1.name = N'���������';

--������, � ����� ������� ����������� ���������� �����, � ������� ������� �������� �����
SELECT person2.name AS person, Club.name AS club, City.name AS city
FROM Person AS person1
	 , FamiliarWith
	 , Person AS person2
     , MemberOf
     , Club
     , LocatedIn
     , City
WHERE MATCH(person1-(FamiliarWith)->person2-(MemberOf)->Club-(LocatedIn)->City)
			AND person1.name = N'����';

--������, ��� ���� � �������, � ������� ���������� ���������� ���� "���"
SELECT Club.name AS club, City.name AS city, person.name AS person 
FROM Club
	 , LocatedIn
	 , City
	 , LivesIn
	 , Person
WHERE MATCH(Club-(LocatedIn)->City<-(LivesIn)-Person)
			AND Club.name = N'���';


--������� � SHORTEST_PATH

--� ��� ����� ������������� ���� (id = 4)
SELECT Person1.name AS PersonName
	  , STRING_AGG(Person2.name, '->') WITHIN GROUP (GRAPH PATH) AS Friends
FROM Person AS Person1
     , FamiliarWith FOR PATH AS fo
     , Person FOR PATH AS Person2
WHERE MATCH(SHORTEST_PATH(Person1(-(fo)->Person2)+))
            AND Person1.id = 4;

--� ��� ����� ������������� ���� (id = 4) �� 3 ����
SELECT Person1.name AS PersonName
	  , STRING_AGG(Person2.name, '->') WITHIN GROUP (GRAPH PATH) AS Friends
FROM Person AS Person1
     , FamiliarWith FOR PATH AS fo
     , Person FOR PATH AS Person2
WHERE MATCH(SHORTEST_PATH(Person1(-(fo)->Person2){1,3}))
            AND Person1.id = 4;