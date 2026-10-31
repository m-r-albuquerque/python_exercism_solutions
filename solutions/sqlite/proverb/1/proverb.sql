-- Schema:
-- CREATE TABLE proverb (
--     strings TEXT NOT NULL,    -- json array containing the input words
--     result  TEXT
-- );
--
-- Task: update proverb table and set result column based on the strings.

UPDATE proverb
SET result = (
    WITH words AS (
        SELECT
            key,
            value
        FROM json_each(strings)
    ),
    lines AS (
        SELECT
            'For want of a ' || w1.value ||
            ' the ' || w2.value ||
            ' was lost.' AS line
        FROM words AS w1
        JOIN words AS w2
            ON w2.key = w1.key + 1
    ),
    body AS (
        SELECT
            COALESCE(group_concat(line, char(10)), '') AS text
        FROM lines
    )
    SELECT
        CASE
            WHEN EXISTS (
                SELECT 1
                FROM words
                WHERE key = 0
            )
            THEN
                body.text ||
                CASE
                    WHEN body.text <> '' THEN char(10)
                    ELSE ''
                END ||
                'And all for the want of a ' ||
                (SELECT value FROM words WHERE key = 0) ||
                '.'
            ELSE ''
        END
    FROM body
);
