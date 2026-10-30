-- Schema: CREATE TABLE pangram (sentence TEXT NOT NULL, result BOOLEAN);
-- Task: update pangram table and set result based on sentence.

WITH RECURSIVE alphabet(letter) AS (
    SELECT 'a'

    UNION ALL

    SELECT char(unicode(letter) + 1)
    FROM alphabet
    WHERE letter < 'z'
),
checked AS (
    SELECT
        p.rowid AS id,
        COUNT(a.letter) AS letters_found
    FROM pangram AS p
    CROSS JOIN alphabet AS a
    WHERE instr(lower(p.sentence), a.letter) > 0
    GROUP BY p.rowid
)
UPDATE pangram
SET result = COALESCE(
    (
        SELECT letters_found = 26
        FROM checked
        WHERE checked.id = pangram.rowid
    ),
    FALSE
);
