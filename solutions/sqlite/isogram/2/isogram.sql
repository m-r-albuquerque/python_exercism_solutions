-- Schema: CREATE TABLE "isogram" ("phrase" TEXT, "is_isogram" INT);
-- Task: Given a phrase, determine if it is an isogram.

CREATE TABLE alphabet (letter);
INSERT INTO alphabet (letter) VALUES ('a'), ('b'), ('c'), ('d'), ('e'), ('f'), ('g'), ('h'), ('i'), ('j'), ('k'), ('l'), ('m'), ('n'), ('o'), ('p'), ('q'), ('r'), ('s'), ('t'), ('u'), ('v'), ('w'), ('x'), ('y'), ('z');
UPDATE isogram
SET is_isogram = (
    SELECT IIF(MAX(c) > 1, 0, 1) FROM (SELECT LENGTH(phrase) - LENGTH(REPLACE(LOWER(phrase), letter, '')) as c FROM alphabet)
);
