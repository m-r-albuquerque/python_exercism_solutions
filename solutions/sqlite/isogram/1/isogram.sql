-- Schema: CREATE TABLE "isogram" ("phrase" TEXT, "is_isogram" INT);
-- Task: Given a phrase, determine if it is an isogram.

UPDATE isogram
SET is_isogram = (
    WITH RECURSIVE
    chars(pos, letter) AS (
        SELECT
            1,
            substr(lower(phrase), 1, 1)

        UNION ALL

        SELECT
            pos + 1,
            substr(lower(phrase), pos + 1, 1)
        FROM chars
        WHERE pos < length(phrase)
    ),
    letters AS (
        SELECT letter
        FROM chars
        WHERE letter GLOB '[a-z]'
    )
    SELECT COUNT(*) = COUNT(DISTINCT letter)
    FROM letters
);
