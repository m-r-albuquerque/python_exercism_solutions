-- Schema: CREATE TABLE "reverse-string" (input TEXT NOT NULL, result TEXT);
-- Task: update the reverse-string table and set the result based on the input.

UPDATE "reverse-string"
SET result = (
    WITH RECURSIVE reversed(pos, text) AS (
        SELECT
            length(input),
            ''

        UNION ALL

        SELECT
            pos - 1,
            text || substr(input, pos, 1)
        FROM reversed
        WHERE pos > 0
    )
    SELECT text
    FROM reversed
    WHERE pos = 0
);
