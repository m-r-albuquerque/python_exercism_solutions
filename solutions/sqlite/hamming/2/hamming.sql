-- Schema:
-- CREATE TABLE hamming (
--     strand1 TEXT NOT NULL,
--     strand2 TEXT NOT NULL,
--     result  INTEGER,
--     error   TEXT
-- );
--
-- Task: update the hamming table and set the result column or the error column based on the comparison between strand1 and strand2.

UPDATE hamming SET (result, error) = (
    WITH chars(i, dist, err) AS (
        SELECT 1,
               iif(length(strand1) != length(strand2), NULL, 0),
               iif(length(strand1) != length(strand2), 'strands must be of equal length', NULL)
        UNION
        SELECT i + 1, dist + (substr(strand1, i, 1) != substr(strand2, i, 1)), err
        FROM chars WHERE err IS NULL AND i <= length(strand1)
    )
    SELECT dist, err FROM chars ORDER BY i DESC LIMIT 1
);
