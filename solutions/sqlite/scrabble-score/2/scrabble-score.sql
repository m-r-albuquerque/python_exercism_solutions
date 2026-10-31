-- Schema: CREATE TABLE "scrabble-score" ( word TEXT NOT NULL, result INTEGER );
-- Task: update scrabble-score table and set the result based on the word.

UPDATE "scrabble-score" SET result = (
    WITH score(i, c, s) AS (
        SELECT 2, upper(substr(word, 1, 1)), 0
        UNION
        SELECT i + 1, upper(substr(word, i, 1)),
            s + CASE
                WHEN c IN ('A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T') THEN 1
                WHEN c IN ('D', 'G') THEN 2
                WHEN c IN ('B', 'C', 'M', 'P') THEN 3
                WHEN c IN ('F', 'H', 'V', 'W', 'Y') THEN 4
                WHEN c = 'K' THEN 5
                WHEN c IN ('J', 'X') THEN 8
                WHEN c IN ('Q', 'Z') THEN 10
            END
        FROM score WHERE i <= length(word) + 1
    )
    SELECT s FROM score WHERE i = length(word) + 2
);
