-- Schema:
-- CREATE TABLE say (
--     number INTEGER NOT NULL,
--     result TEXT,
--     error  TEXT
-- );
--
-- Task: update the say table and set the result or the error columns based on the number.

UPDATE say
SET error = 'input out of range'
WHERE number < 0
   OR number > 999999999999;

UPDATE say
SET result = (
    WITH
    ones(n, word) AS (
        VALUES
            (0, ''),
            (1, 'one'),
            (2, 'two'),
            (3, 'three'),
            (4, 'four'),
            (5, 'five'),
            (6, 'six'),
            (7, 'seven'),
            (8, 'eight'),
            (9, 'nine'),
            (10, 'ten'),
            (11, 'eleven'),
            (12, 'twelve'),
            (13, 'thirteen'),
            (14, 'fourteen'),
            (15, 'fifteen'),
            (16, 'sixteen'),
            (17, 'seventeen'),
            (18, 'eighteen'),
            (19, 'nineteen')
    ),

    tens(n, word) AS (
        VALUES
            (2, 'twenty'),
            (3, 'thirty'),
            (4, 'forty'),
            (5, 'fifty'),
            (6, 'sixty'),
            (7, 'seventy'),
            (8, 'eighty'),
            (9, 'ninety')
    ),

    scales(pos, divisor, name) AS (
        VALUES
            (3, 1000000000, 'billion'),
            (2, 1000000,    'million'),
            (1, 1000,       'thousand'),
            (0, 1,          '')
    ),

    groups AS (
        SELECT
            pos,
            name,
            (number / divisor) % 1000 AS n
        FROM scales
    ),

    parts AS (
        SELECT
            pos,
            name,
            n,
            CASE
                WHEN n = 0 THEN ''

                WHEN n < 20 THEN
                    (SELECT word
                     FROM ones
                     WHERE ones.n = groups.n)

                WHEN n < 100 THEN
                    (SELECT word
                     FROM tens
                     WHERE tens.n = groups.n / 10) ||
                    CASE
                        WHEN n % 10 = 0 THEN ''
                        ELSE '-' ||
                            (SELECT word
                             FROM ones
                             WHERE ones.n = groups.n % 10)
                    END

                ELSE
                    (SELECT word
                     FROM ones
                     WHERE ones.n = groups.n / 100) ||
                    ' hundred' ||
                    CASE
                        WHEN n % 100 = 0 THEN ''

                        WHEN n % 100 < 20 THEN
                            ' ' ||
                            (SELECT word
                             FROM ones
                             WHERE ones.n = groups.n % 100)

                        ELSE
                            ' ' ||
                            (SELECT word
                             FROM tens
                             WHERE tens.n = (groups.n % 100) / 10) ||
                            CASE
                                WHEN n % 10 = 0 THEN ''
                                ELSE '-' ||
                                    (SELECT word
                                     FROM ones
                                     WHERE ones.n = groups.n % 10)
                            END
                    END
            END AS words
        FROM groups
    )

    SELECT CASE
        WHEN number = 0 THEN 'zero'
        ELSE (
            SELECT group_concat(
                words ||
                CASE
                    WHEN name = '' THEN ''
                    ELSE ' ' || name
                END,
                ' '
            )
            FROM (
                SELECT pos, name, words
                FROM parts
                WHERE n <> 0
                ORDER BY pos DESC
            )
        )
    END
)
WHERE number BETWEEN 0 AND 999999999999;
