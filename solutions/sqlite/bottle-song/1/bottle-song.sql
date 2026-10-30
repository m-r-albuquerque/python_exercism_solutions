-- Schema:
-- CREATE TABLE "bottle-song" (
--         start_bottles INTEGER NOT NULL,
--         take_down     INTEGER NOT NULL,
--         result        TEXT
-- );
-- Task: update bottle-song table and set the result based on the
-- start_bottles and take_down.

UPDATE "bottle-song"
SET result = (
    WITH RECURSIVE
    numbers(n, word) AS (
        VALUES
            (0, 'no'),
            (1, 'one'),
            (2, 'two'),
            (3, 'three'),
            (4, 'four'),
            (5, 'five'),
            (6, 'six'),
            (7, 'seven'),
            (8, 'eight'),
            (9, 'nine'),
            (10, 'ten')
    ),

    verses(n) AS (
        SELECT start_bottles

        UNION ALL

        SELECT n - 1
        FROM verses
        WHERE n > start_bottles - take_down + 1
    ),

    lyrics AS (
        SELECT
            v.n,

            UPPER(SUBSTR(current.word, 1, 1)) ||
            SUBSTR(current.word, 2) ||
            ' green bottle' ||
            CASE WHEN v.n = 1 THEN '' ELSE 's' END ||
            ' hanging on the wall,' ||
            char(10) ||

            UPPER(SUBSTR(current.word, 1, 1)) ||
            SUBSTR(current.word, 2) ||
            ' green bottle' ||
            CASE WHEN v.n = 1 THEN '' ELSE 's' END ||
            ' hanging on the wall,' ||
            char(10) ||

            'And if one green bottle should accidentally fall,' ||
            char(10) ||

            'There''ll be ' ||
            next.word ||
            ' green bottle' ||
            CASE WHEN v.n - 1 = 1 THEN '' ELSE 's' END ||
            ' hanging on the wall.'
            AS verse

        FROM verses AS v
        JOIN numbers AS current
            ON current.n = v.n
        JOIN numbers AS next
            ON next.n = v.n - 1
    )

    SELECT GROUP_CONCAT(verse, char(10) || char(10))
    FROM (
        SELECT verse
        FROM lyrics
        ORDER BY n DESC
    )
);
