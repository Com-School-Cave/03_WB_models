-- SELECTS 1:1

-- Einzeltabellen
SELECT * FROM mydb.cats;
SELECT * FROM mydb.servants;

-- Kreuzprodukt (Kartesisches Produkt)
SELECT * FROM mydb.cats JOIN mydb.servants;

-- Kreuzprodukt (gefiltert)
SELECT * FROM mydb.cats JOIN mydb.servants
WHERE cat_name = "Grizabella"
;

-- Inner Join 1 / Gesamte Tabelle
SELECT
	*
FROM mydb.cats INNER JOIN mydb.servants
-- Werte Primärschlüssel/MT = Werte Fremdschlüssel/DT
ON mydb.cats.id = mydb.servants.cats_id
;

-- Inner Join 2 / (Wer dient wem?)
-- Wer dient Grizabella?
-- Wem dient Daniel?
SELECT
	cat_name AS Herrschaft,
    servant_name AS Diener
FROM mydb.cats INNER JOIN mydb.servants
ON mydb.cats.id = mydb.servants.cats_id
#WHERE cat_name = "Grizabella"
#WHERE servant_name = "Daniel"
WHERE Diener = "Daniel" 
;

-- Inner Join 2a / (Wer dient wem?)
-- "X ist der Diener von Y"  / Dienstverhältnis
SELECT
	CONCAT(servant_name, " ist der Diener von ", cat_name, ".") AS Dienstverhältnis
FROM mydb.cats INNER JOIN mydb.servants
ON mydb.cats.id = mydb.servants.cats_id
WHERE cat_name = "Mausi"
;

-- Inner Join 3 / Dienstzeit
SELECT
	servant_name AS Diener,
    yrs_served AS Dienstzeit
FROM mydb.cats INNER JOIN mydb.servants
ON mydb.cats.id = mydb.servants.cats_id
;

-- Inner Join 4 / Dienstzeit als zusammengesetzter String
-- "X - der Diener von Y - ist der Diener mit der längsten Dienstzeit" // MAX()

-- 1. Variante:  LIMIT (QUICK & DIRTY / Nur bei einem MAX-Wert vollständige Lösung)
SELECT
    CONCAT(servant_name, " - der Diener von ", cat_name, " - ist der Diener mit der längsten Dienstzeit.") AS Dienstzeit
FROM mydb.cats INNER JOIN mydb.servants
ON mydb.cats.id = mydb.servants.cats_id
ORDER BY yrs_served DESC
LIMIT 1
;

-- 2. Variante: Subquery

-- Test Subquery
#SELECT MAX(yrs_served) FROM mydb.servants

-- Subquery in WHERE
SELECT
    CONCAT(servant_name, " - der Diener von ", cat_name, " - ist der Diener mit der längsten Dienstzeit.") AS Dienstzeit
FROM mydb.cats INNER JOIN mydb.servants
ON mydb.cats.id = mydb.servants.cats_id
WHERE yrs_served = (SELECT MAX(yrs_served) FROM mydb.servants)
;


    


