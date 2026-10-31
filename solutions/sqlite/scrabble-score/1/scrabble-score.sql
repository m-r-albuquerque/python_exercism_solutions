-- Schema: CREATE TABLE "scrabble-score" ( word TEXT NOT NULL, result INTEGER );
-- Task: update scrabble-score table and set the result based on the word.

UPDATE "scrabble-score"
SET result = (
    WITH scores(letter, points) AS (
        VALUES
            ('A', 1), ('E', 1), ('I', 1), ('O', 1), ('U', 1),
            ('L', 1), ('N', 1), ('R', 1), ('S', 1), ('T', 1),
            ('D', 2), ('G', 2),
            ('B', 3), ('C', 3), ('M', 3), ('P', 3),
            ('F', 4), ('H', 4), ('V', 4), ('W', 4), ('Y', 4),
            ('K', 5),
            ('J', 8), ('X', 8),
            ('Q', 10), ('Z', 10)
    ),
    letters AS (
        SELECT
            upper(substr(word, value, 1)) AS letter
        FROM generate_series(1, length(word))
    )
    SELECT
        COALESCE(SUM(scores.points), 0)
    FROM letters
    JOIN scores
        ON scores.letter = letters.letter
);
