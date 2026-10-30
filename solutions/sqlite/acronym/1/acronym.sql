-- Schema: CREATE TABLE acronym ( phrase TEXT PRIMARY KEY, result TEXT );
-- Task: update the acronym table and set the result based on the phrase.

WITH RECURSIVE
chars(phrase, pos, ch, result, in_word) AS (
    SELECT
        phrase,
        1,
        substr(phrase, 1, 1),
        CASE
            WHEN substr(phrase, 1, 1) GLOB '[A-Za-z]'
            THEN upper(substr(phrase, 1, 1))
            ELSE ''
        END,
        CASE
            WHEN substr(phrase, 1, 1) GLOB '[A-Za-z]'
            THEN 1
            ELSE 0
        END
    FROM acronym

    UNION ALL

    SELECT
        phrase,
        pos + 1,
        substr(phrase, pos + 1, 1),

        result ||
        CASE
            WHEN substr(phrase, pos + 1, 1) GLOB '[A-Za-z]'
                 AND in_word = 0
            THEN upper(substr(phrase, pos + 1, 1))
            ELSE ''
        END,

        CASE
            WHEN substr(phrase, pos + 1, 1) GLOB '[A-Za-z]'
            THEN 1
            WHEN substr(phrase, pos + 1, 1) IN (' ', '-')
            THEN 0
            ELSE in_word
        END

    FROM chars
    WHERE pos < length(phrase)
)
UPDATE acronym
SET result = (
    SELECT result
    FROM chars
    WHERE chars.phrase = acronym.phrase
      AND pos = length(acronym.phrase)
);
