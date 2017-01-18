SPOOL project.out
SET ECHO ON


/*
Gabriel Stepanovich
Silas Vincent
Sean Holloway
Reece Baldwin
Zachary Gill
*/
--

DROP TABLE items CASCADE CONSTRAINTS;

DROP TABLE characters CASCADE CONSTRAINTS;

DROP TABLE carrying CASCADE CONSTRAINTS;

DROP TABLE skills CASCADE CONSTRAINTS;

DROP TABLE sells CASCADE CONSTRAINTS;

DROP TABLE shops CASCADE CONSTRAINTS;

DROP TABLE towns CASCADE CONSTRAINTS;

DROP TABLE regions CASCADE CONSTRAINTS;

DROP TABLE dungeons CASCADE CONSTRAINTS;

DROP TABLE monsters CASCADE CONSTRAINTS;

DROP TABLE infests CASCADE CONSTRAINTS;

DROP TABLE boss_monsters CASCADE CONSTRAINTS;

--

CREATE TABLE items
(
    iName VARCHAR(30),
    iDescription VARCHAR(100) NOT NULL,
    iType VARCHAR(15) NOT NULL,
	--
    CONSTRAINT iPK PRIMARY KEY (iName)
);

--

CREATE TABLE characters
(
    cName VARCHAR(30),
    cLevel INTEGER NOT NULL,
    race VARCHAR(15) NOT NULL,
    mp INTEGER NOT NULL,
    hp INTEGER NOT NULL,
    str INTEGER NOT NULL,
    int INTEGER NOT NULL,
    dex INTEGER NOT NULL, 
    mentor VARCHAR(30),
    cRegion VARCHAR(30),
	--
    CONSTRAINT cLVL CHECK (cLevel >= 1 AND cLevel <= 100),
    CONSTRAINT cPK PRIMARY KEY(cName)
);

--

CREATE TABLE carrying
(
    itemName VARCHAR(30),
    chName VARCHAR(30),
    --
    CONSTRAINT caPK PRIMARY KEY (itemName, chName)
);

--

CREATE TABLE skills
(
    kName VARCHAR(30),
    charName VARCHAR(30),
    --
    CONSTRAINT skPK PRIMARY KEY (kName, charName)
);

--

CREATE TABLE shops
(
    sName VARCHAR(30),
    sType VARCHAR(10) NOT NULL,
    sTown VARCHAR(30) NOT NULL,
    --
    CONSTRAINT shPK PRIMARY KEY (sName)
);

--

CREATE TABLE sells
(
    itemName VARCHAR(30),
    storeName VARCHAR(30) NOT NULL,
    iPrice NUMBER NOT NULL,
    --
    CONSTRAINT sePK PRIMARY KEY (itemName, storeName)
);

--

CREATE TABLE regions
(
    rName VARCHAR(30),
    population NUMBER,
    number_of_towns NUMBER,
    --
    CONSTRAINT rPK PRIMARY KEY (rName)
);

--

CREATE TABLE towns
(
    tName VARCHAR(30),
    tRegion VARCHAR(30) NOT NULL,
	--
    CONSTRAINT tPK PRIMARY KEY (tName)
);

--

CREATE TABLE dungeons
(
    dName VARCHAR(30),
    dLevel NUMBER NOT NULL,
    dRegion VARCHAR(30) NOT NULL,
    --
    CONSTRAINT dPK PRIMARY KEY (dName)
);

--

CREATE TABLE monsters
(
    mName VARCHAR(30),
    mLevel INTEGER NOT NULL,
    loot VARCHAR(30),
    mHP INTEGER,
    mMP INTEGER,
    mSTR INTEGER,
    mDEX INTEGER,
    mINT INTEGER,
    --
    CONSTRAINT mLoot CHECK (loot IS NOT NULL OR mLevel < 10), 
    CONSTRAINT mPK PRIMARY KEY (mName)
);

--

CREATE TABLE infests
(
    monster VARCHAR(30),
    dungeon VARCHAR(30),
    --
    CONSTRAINT infPK PRIMARY KEY (monster, dungeon)
);

--

CREATE TABLE boss_monsters
(
    bName VARCHAR(30),
    dunName VARCHAR(30),
    bLevel INTEGER,
    bHP INTEGER,
    bMP INTEGER,
    bSTR INTEGER,
    bDEX INTEGER,
    bINT INTEGER,
    bLoot VARCHAR(30),
    --
    CONSTRAINT bPK PRIMARY KEY (bName)
);

--

--Foreign Keys

ALTER TABLE characters ADD CONSTRAINT cFK FOREIGN KEY (cRegion) references regions(rName);

ALTER TABLE carrying ADD CONSTRAINT carIFK FOREIGN KEY (itemName) references items(iName);

ALTER TABLE carrying ADD CONSTRAINT carCHFK FOREIGN KEY (chName) references characters(cName);

ALTER TABLE towns ADD CONSTRAINT tFK FOREIGN KEY (tRegion) references regions(rName);

ALTER TABLE skills ADD CONSTRAINT skillFK FOREIGN KEY (charName) references characters(cName);

ALTER TABLE shops ADD CONSTRAINT shopFK FOREIGN KEY (sTown) references towns(tName);

ALTER TABLE sells ADD CONSTRAINT sellsItemFK FOREIGN KEY (itemName) references items(iName);

ALTER TABLE sells ADD CONSTRAINT sellsStoreFK FOREIGN KEY (storeName) references shops(sName);

ALTER TABLE dungeons ADD CONSTRAINT dunFK FOREIGN KEY (dRegion) references regions(rName);

ALTER TABLE monsters ADD CONSTRAINT mFK FOREIGN KEY (loot) references items(iName);

ALTER TABLE infests ADD CONSTRAINT infestMonFK FOREIGN KEY (monster) references monsters(mName);

ALTER TABLE infests ADD CONSTRAINT infestDunFK FOREIGN KEY (dungeon) references dungeons(dName);

ALTER TABLE boss_monsters ADD CONSTRAINT bossDunFK FOREIGN KEY (dunName) references dungeons(dName);

ALTER TABLE boss_monsters ADD CONSTRAINT bossLootFK FOREIGN KEY (bLoot) references items(iName);

--


SET FEEDBACK OFF
--Inserts Below

--Items

INSERT INTO items VALUES('potion', 'A healing beverage', 'consumable');

INSERT INTO items VALUES ('ham', 'Delicious meat', 'consumable');

INSERT INTO items VALUES ('milk', 'Got it!', 'consumable');

INSERT INTO items VALUES ('Hellscream"s Doomblade', 'Death to the Alliance!', 'Sword');

INSERT INTO items VALUES ('Mystery meat', 'Please tell me you"re not going to eat this?', 'consumable');

INSERT INTO items VALUES ('Gungnir', 'Odin"s spear', 'Spear');

INSERT INTO items VALUES ('Rhongomiant', 'Athurian spear of legend', 'Spear');

INSERT INTO items VALUES ('Aiglos', 'Elven spear of Gil-galad', 'Spear');

INSERT INTO items VALUES ('Darkwood Staff', 'Stout staff', 'Staff');



--Regions

INSERT INTO regions VALUES ('Arcadia', 38000, 12);

INSERT INTO regions VALUES ('Shadow Isles', 400, 1);


--Monsters and dungeons


INSERT INTO monsters VALUES ('Goblin', 10, 'potion', 300, 90, 70, 55, 30);
INSERT INTO monsters VALUES ('Zombie', 15, 'Mystery meat', 500, 10, 90, 40, 5);
INSERT INTO monsters VALUES ('Ghoul', 15, 'milk', 400, 30, 80, 60, 25);
INSERT INTO monsters VALUES ('Dire Rat', 2, 'Mystery meat', 50, 10, 10, 10, 10);
INSERT INTO monsters VALUES ('Wolf', 10, 'ham', 250, 50, 70, 60, 20);



INSERT INTO dungeons VALUES ('Castle Ruins', 15, 'Arcadia');


INSERT INTO dungeons VALUES ('Abadoned Mines', 20, 'Shadow Isles');

INSERT INTO boss_monsters VALUES ('Goblin King', 'Castle Ruins', 15, 1500, 150, 120, 70, 50, 'potion');

INSERT INTO infests VALUES ('Goblin', 'Castle Ruins');

INSERT INTO boss_monsters VALUES ('Death Knight', 'Abadoned Mines', 25, 2000, 160, 150, 80, 70, 'Hellscream"s Doomblade');

INSERT INTO infests VALUES ('Zombie', 'Abadoned Mines');
INSERT INTO infests VALUES ('Ghoul', 'Abadoned Mines');


--Towns

INSERT INTO towns VALUES ('Veil', 'Arcadia');

INSERT INTO towns VALUES ('Port Prodigal', 'Shadow Isles');


--Shops

INSERT INTO shops VALUES ('Bob"s Bows', 'Weapon', 'Veil');

INSERT INTO shops VALUES ('Jeff"s Barn', 'Grocery', 'Port Prodigal');

INSERT INTO shops VALUES ('Polearm Emporium', 'Weapon', 'Port Prodigal');

INSERT INTO shops VALUES ('The Loot Bin', 'Misc', 'Veil');


--Sells

INSERT INTO sells VALUES ('potion', 'The Loot Bin', '150');

INSERT INTO sells VALUES ('ham', 'Jeff"s Barn', '25');

INSERT INTO sells VALUES ('milk', 'Jeff"s Barn', '20');

INSERT INTO sells VALUES ('Mystery meat', 'Jeff"s Barn', '10');

INSERT INTO sells VALUES ('Gungnir', 'Polearm Emporium', '150');

INSERT INTO sells VALUES ('Rhongomiant', 'Polearm Emporium', '250');

INSERT INTO sells VALUES ('Aiglos', 'Polearm Emporium', '400');

INSERT INTO sells VALUES ('Darkwood Staff', 'Polearm Emporium', '50');



--Characters

INSERT INTO characters VALUES('Syllphi Yaru', 45, 'Elf', 2500, 1700, 100, 178, 121, null, null);

INSERT INTO characters VALUES('Locke', 88, 'Human', 5400, 3020, 160, 500, 100, null, 'Shadow Isles');

INSERT INTO characters VALUES('Gebadia', 70, 'Human', 9001, 9001, 260, 140, 210, 'Locke', 'Shadow Isles');

INSERT INTO characters VALUES('Garrosh Hellscream', 99, 'Orc', 10500, 2000, 640, 190, 540, null, null);


--Char Skills and Carried items

INSERT INTO carrying VALUES ('potion', 'Syllphi Yaru');

INSERT INTO carrying VALUES ('Hellscream"s Doomblade', 'Garrosh Hellscream');

INSERT INTO skills VALUES ('Charge', 'Garrosh Hellscream');

INSERT INTO skills VALUES ('Cure', 'Syllphi Yaru');

INSERT INTO skills VALUES ('Summon Void Walker', 'Gebadia');

INSERT INTO skills VALUES ('Summon Imp', 'Gebadia');

INSERT INTO skills VALUES ('Summon Jaraxxus', 'Locke');

SET FEEDBACK ON
COMMIT
--


-- Printing out database
SELECT * FROM items;
SELECT * FROM sells;
SELECT * FROM characters;
SELECT * FROM shops;
SELECT * FROM carrying;
SELECT * FROM skills;
SELECT * FROM towns;
SELECT * FROM monsters;
SELECT * FROM infests;
SELECT * FROM boss_monsters;
SELECT * FROM dungeons;
SELECT * FROM regions;

--

-- Queries

-- Q1 - A join involving at least four relations
-- Find the itemName of every item sold in the same region a character (Locke) is from
SELECT DISTINCT SL.itemName
FROM shops S, sells SL, towns T, characters C
WHERE (SL.storeName = S.sName) AND (S.sTown = T.tName) AND (T.tRegion = C.cRegion);

-- Q2 - A self-join
-- Find pairs of character names, levels, and races that have a level higher than 30 but are different races.
SELECT C1.cName, C1.cLevel, C1.race, C2.cName, C2.cLevel, C2.race
FROM characters C1, characters C2
WHERE C1.cLevel > 30 AND
	C1.race != C2.race AND
	C2.cLevel > 30;

-- Q3 - UNION, INTERSECT, and/or MINUS
-- Find the mName, mLevel, and mSTR of Monsters that have a level above 9 and a STR above 40 AND infests the Castle Ruins
SELECT M.mName, M.mLevel, M.mSTR
FROM	monsters M
WHERE   (M.mLevel > 9) AND (M.mSTR > 40)
INTERSECT
SELECT M.mName, M.mLevel, M.mSTR
FROM	monsters M, infests I
WHERE	(M.mName = I.monster) AND (I.dungeon = 'Castle Ruins');

-- Q4 - SUM, AVG, MAX, and/or MIN.
-- Find, listed by dungeon, the AVG, MIN, and MAX mLevel and mHP for every monster in that infests that dungeon.
SELECT I.dungeon, AVG(mLevel), MIN(mLevel), MAX(mLevel), AVG(mHP), MIN(mHP), MAX(mHP)
FROM	monsters M, infests I
WHERE  I.monster = M.mName
GROUP BY I.dungeon;

-- Q5 - GROUP BY, HAVING, and ORDER BY, all appearing in the same query
-- Find the sName, sTown, and number of items sold by all shops that sell more than 2 items, sorted greatest number sold to least
SELECT S.sName, S.sTown, COUNT(*)
FROM	shops S, sells SE
WHERE	SE.storeName = S.sName
GROUP BY S.sName, S.sTown
HAVING	COUNT(*) > 2
ORDER BY COUNT(*) DESC;

-- Q6 - A correlated subquery
-- Find the sName of shops that are in the town called Veil and sell no items.
SELECT S.sName
FROM shops S
WHERE S.sTown = 'Veil' AND
	NOT EXISTS (SELECT *
			FROM sells SE
			WHERE SE.storeName = S.sName);

-- Q7 -	A non-correlated subquery
-- Find the sName of shops that are in the town called Veil and sell no items.
SELECT S.sName
FROM shops S
WHERE S.sTown = 'Veil' AND
	S.sName NOT IN (SELECT SE.storeName
			FROM sells SE);

-- Q8 - A relational DIVISION query.
-- Find the sName, sType of all stores in the Shadow Isles regions.
SELECT S.sName, S.sType
FROM	shops S
WHERE	NOT EXISTS((SELECT R.rName
		    FROM regions R
		    WHERE R.rName = 'Shadow Isles')
		MINUS
		(SELECT R.rName
		FROM towns T, regions R
		WHERE T.tRegion = R.rName AND
			T.tName = S.sTown AND
			R.rName = 'Shadow Isles'));


-- Q9 - An outer join query
-- Find the cName, race, level, and carried items for every character, and show the items for those who carry them.
SELECT C.cName, C.race, C.cLevel, I.itemName
FROM	characters C LEFT OUTER JOIN carrying I ON C.cName = I.chName;


-- Testing ICs

-- Testing: rePK
-- Should reject, since this is not a unique region value, we already have an Arcadia
INSERT INTO regions VALUES ('Arcadia', 1515, 20);

-- Testing: cFK
-- Should be rejected, since no region called 'Test' exists.
INSERT INTO characters VALUES('Tester McTestington', 88, 'Human', 5400, 3020, 160, 500, 100, null, 'Test');


-- Testing: cLVL
-- Reject, since level is greater than 100.
INSERT INTO characters VALUES('Uber Level Man', 150, 'Human', 5400, 3020, 160, 500, 100, null, 'Shadow Isles');

-- Reject, since level is less than 1.
INSERT INTO characters VALUES('Impossible Level Man', -5, 'Human', 5400, 3020, 160, 500, 100, null, 'Shadow Isles');

-- Testing: mLoot
-- Reject, since level is not less than 10 and loot IS NULL
INSERT INTO monsters VALUES ('Rejected Monster', 25, null, 300, 90, 70, 55, 30);

-- Accept, since loot is not null, but level is not less than 10.
INSERT INTO monsters VALUES ('Accepted Tough Monster', 20, 'potion', 300, 90, 70, 55, 30);

-- Accept, since loot is null but level is less than 10.
INSERT INTO monsters VALUES ('Accepted Weak Monster', 2, null, 300, 90, 70, 55, 30);


SET ECHO OFF

SPOOL OFF
