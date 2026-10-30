-- Schema:
-- CREATE TABLE hamming (
--     strand1 TEXT NOT NULL,
--     strand2 TEXT NOT NULL,
--     result  INTEGER,
--     error   TEXT
-- );
--
-- Task: update the hamming table and set the result column or the error column based on the comparison between strand1 and strand2.

WITH RECURSIVE
hamming_distance(id, pos, distance) AS (
    SELECT
        rowid,
        1,
        0
    FROM hamming
    WHERE length(strand1) = length(strand2)

    UNION ALL

    SELECT
        hd.id,
        hd.pos + 1,
        hd.distance +
            (
                substr(h.strand1, hd.pos, 1) <>
                substr(h.strand2, hd.pos, 1)
            )
    FROM hamming AS h
    JOIN hamming_distance AS hd
        ON hd.id = h.rowid
    WHERE hd.pos <= length(h.strand1)
),
distances AS (
    SELECT
        id,
        distance
    FROM hamming_distance
    WHERE pos > (
        SELECT length(strand1)
        FROM hamming
        WHERE rowid = hamming_distance.id
    )
)
UPDATE hamming
SET
    result = (
        SELECT distance
        FROM distances
        WHERE distances.id = hamming.rowid
    ),
    error = CASE
        WHEN length(strand1) <> length(strand2)
        THEN 'strands must be of equal length'
        ELSE NULL
    END;

