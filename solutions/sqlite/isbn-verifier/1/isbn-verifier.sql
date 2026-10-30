-- Schema: CREATE TABLE "isbn-verifier" (isbn TEXT NOT NULL, result BOOL);
-- Task: update the isbn-verifier table and set the result based on the isbn.

WITH cleaned AS (
    SELECT
        isbn,
        REPLACE(isbn, '-', '') AS clean_isbn
    FROM "isbn-verifier"
),

calculated AS (
    SELECT
        isbn,
        clean_isbn,

        -- Soma ponderada do ISBN-10
        (
            CAST(substr(clean_isbn, 1, 1) AS INTEGER) * 10 +
            CAST(substr(clean_isbn, 2, 1) AS INTEGER) * 9 +
            CAST(substr(clean_isbn, 3, 1) AS INTEGER) * 8 +
            CAST(substr(clean_isbn, 4, 1) AS INTEGER) * 7 +
            CAST(substr(clean_isbn, 5, 1) AS INTEGER) * 6 +
            CAST(substr(clean_isbn, 6, 1) AS INTEGER) * 5 +
            CAST(substr(clean_isbn, 7, 1) AS INTEGER) * 4 +
            CAST(substr(clean_isbn, 8, 1) AS INTEGER) * 3 +
            CAST(substr(clean_isbn, 9, 1) AS INTEGER) * 2 +
            CASE
                WHEN substr(clean_isbn, 10, 1) = 'X' THEN 10
                ELSE CAST(substr(clean_isbn, 10, 1) AS INTEGER)
            END
        ) AS checksum

    FROM cleaned
)

UPDATE "isbn-verifier"
SET result = (
    SELECT
        length(clean_isbn) = 10
        AND substr(clean_isbn, 1, 9) NOT GLOB '*[^0-9]*'
        AND (
            substr(clean_isbn, 10, 1) GLOB '[0-9]'
            OR substr(clean_isbn, 10, 1) = 'X'
        )
        AND checksum % 11 = 0
    FROM calculated
    WHERE calculated.isbn = "isbn-verifier".isbn
);
