-- Schema:
-- CREATE TABLE "square-root" (
--     radicand INTEGER NOT NULL,
--     result   INTEGER
-- );
--
-- Task: update the square-root table and set the result based on the radicand.

WITH RECURSIVE
    seq(r, i) AS (
        SELECT rowid, 1
        FROM "square-root"

        UNION ALL

        SELECT seq.r, seq.i + 1
        FROM seq
        JOIN "square-root" AS s
            ON s.rowid = seq.r
        WHERE (seq.i + 1) * (seq.i + 1) <= s.radicand
    )
UPDATE "square-root"
SET result = (
    SELECT i
    FROM seq
    WHERE seq.r = "square-root".rowid
      AND i * i = "square-root".radicand
);
