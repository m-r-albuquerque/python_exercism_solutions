-- Schema: CREATE TABLE "reverse-string" (input TEXT NOT NULL, result TEXT);
-- Task: update the reverse-string table and set the result based on the input.

UPDATE "reverse-string"
SET result = (
    WITH chars(i, c) AS (
        SELECT length(input) - 1, substr(input, length(input), 1)
        UNION
        SELECT i - 1, substr(input, i, 1) FROM chars WHERE i >= 1
    )
    SELECT group_concat(c, '') FROM chars
);
