-- Schema: CREATE TABLE "eliuds-eggs" ("number" INT, "result" INT);
-- Task: update the eliuds-eggs table and set the result based on the number field.

UPDATE "eliuds-eggs"
SET result = (
    WITH RECURSIVE bits(n, eggs) AS (
        SELECT number, 0

        UNION ALL

        SELECT
            n >> 1,
            eggs + (n & 1)
        FROM bits
        WHERE n > 0
    )
    SELECT eggs
    FROM bits
    ORDER BY n
    LIMIT 1
);
