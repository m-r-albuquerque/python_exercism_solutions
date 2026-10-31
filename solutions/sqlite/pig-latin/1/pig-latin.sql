-- Schema: CREATE TABLE "pig-latin" ( phrase TEXT NOT NULL, result TEXT );
-- Task: update the pig-latin table and set the result based on the phrase.

UPDATE "pig-latin"
SET result = (
    WITH RECURSIVE

    words(rowid, pos, word, rest) AS (
        SELECT
            rowid,
            0,
            '',
            phrase || ' '
        FROM "pig-latin"
        WHERE rowid = "pig-latin".rowid

        UNION ALL

        SELECT
            rowid,
            pos + 1,
            substr(rest, 1, instr(rest, ' ') - 1),
            substr(rest, instr(rest, ' ') + 1)
        FROM words
        WHERE rest <> ''
    ),

    scan(rowid, pos, word, i, cut) AS (
        SELECT
            rowid,
            pos,
            word,
            1,
            CASE
                WHEN lower(substr(word, 1, 1))
                     IN ('a', 'e', 'i', 'o', 'u')
                    THEN 1

                WHEN lower(substr(word, 1, 2))
                     IN ('xr', 'yt')
                    THEN 1

                WHEN lower(substr(word, 1, 2)) = 'qu'
                    THEN 3
            END
        FROM words
        WHERE word <> ''

        UNION ALL

        SELECT
            rowid,
            pos,
            word,
            i + 1,
            CASE
                WHEN lower(substr(word, i + 1, 2)) = 'qu'
                    THEN i + 3

                WHEN lower(substr(word, i + 1, 1)) = 'y'
                    THEN i + 1

                WHEN lower(substr(word, i + 1, 1))
                     IN ('a', 'e', 'i', 'o', 'u')
                    THEN i + 1
            END
        FROM scan
        WHERE cut IS NULL
          AND i < length(word)
    ),

    translated AS (
        SELECT
            rowid,
            pos,
            substr(word, cut) ||
            substr(word, 1, cut - 1) ||
            'ay' AS word
        FROM scan
        WHERE cut IS NOT NULL
    )

    SELECT group_concat(word, ' ')
    FROM translated
    WHERE translated.rowid = "pig-latin".rowid
    ORDER BY pos
);
