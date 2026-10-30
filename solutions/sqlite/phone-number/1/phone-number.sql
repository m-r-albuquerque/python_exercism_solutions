-- Schema:
-- CREATE TABLE "phone-number" (
--   phrase TEXT NOT NULL,
--   result TEXT,
--   error TEXT
-- );
--
-- Task: update the phone-number table and set the result or the error columns based on the phrase.

WITH cleaned AS (
    SELECT
        rowid AS id,
        phrase,
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(phrase, ' ', ''),
                            '-', ''
                        ),
                        '.', ''
                    ),
                    '(', ''
                ),
                ')', ''
            ),
            '+', ''
        ) AS number
    FROM "phone-number"
),
validated AS (
    SELECT
        id,
        number,
        CASE
            WHEN phrase GLOB '*[A-Za-z]*'
                THEN 'letters not permitted'

            WHEN phrase GLOB '*[^0-9 .()+-]*'
                THEN 'punctuations not permitted'

            WHEN length(number) < 10
                THEN 'must not be fewer than 10 digits'

            WHEN length(number) > 11
                THEN 'must not be greater than 11 digits'

            WHEN length(number) = 11
                 AND substr(number, 1, 1) <> '1'
                THEN '11 digits must start with 1'

            WHEN substr(
                    CASE
                        WHEN length(number) = 11
                        THEN substr(number, 2)
                        ELSE number
                    END,
                    1, 1
                 ) = '0'
                THEN 'area code cannot start with zero'

            WHEN substr(
                    CASE
                        WHEN length(number) = 11
                        THEN substr(number, 2)
                        ELSE number
                    END,
                    1, 1
                 ) = '1'
                THEN 'area code cannot start with one'

            WHEN substr(
                    CASE
                        WHEN length(number) = 11
                        THEN substr(number, 2)
                        ELSE number
                    END,
                    4, 1
                 ) = '0'
                THEN 'exchange code cannot start with zero'

            WHEN substr(
                    CASE
                        WHEN length(number) = 11
                        THEN substr(number, 2)
                        ELSE number
                    END,
                    4, 1
                 ) = '1'
                THEN 'exchange code cannot start with one'

            ELSE NULL
        END AS error
    FROM cleaned
)
UPDATE "phone-number"
SET
    result = CASE
        WHEN validated.error IS NULL THEN
            CASE
                WHEN length(validated.number) = 11
                    THEN substr(validated.number, 2)
                ELSE validated.number
            END
        ELSE NULL
    END,
    error = validated.error
FROM validated
WHERE "phone-number".rowid = validated.id;
