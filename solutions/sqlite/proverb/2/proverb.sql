-- Schema:
-- CREATE TABLE proverb (
--     strings TEXT NOT NULL,    -- json array containing the input words
--     result  TEXT
-- );
--
-- Task: update proverb table and set result column based on the strings.

UPDATE proverb SET result = '' WHERE json_array_length(strings) = 0;
UPDATE proverb SET result = (
    WITH verses(n, i, stop, verse) AS (
        SELECT json_array_length(strings), 0, json_array_length(strings),
               format('And all for the want of a %s.', strings ->> 0)
        UNION
        SELECT i, i + 1, stop,
               format('For want of a %s the %s was lost.',
                      strings ->> i, strings ->> (i + 1))
        FROM verses WHERE i < stop
    )
    SELECT group_concat(verse, char(10))
    FROM (SELECT verse FROM verses WHERE i < stop ORDER BY n)
) WHERE result IS NULL;
