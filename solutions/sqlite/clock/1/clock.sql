-- Schema:
-- CREATE TABLE clock (
--   property TEXT NOT NULL,
--   input    TEXT NOT NULL,   -- json object
--   result   TEXT
-- );
--
-- Task: update the clock table and set the result column based on the input.

WITH data AS (
    SELECT
        rowid AS id,
        property,
        json_extract(input, '$.hour') AS hour,
        json_extract(input, '$.minute') AS minute,
        json_extract(input, '$.value') AS value,
        json_extract(input, '$.clock1.hour') AS hour1,
        json_extract(input, '$.clock1.minute') AS minute1,
        json_extract(input, '$.clock2.hour') AS hour2,
        json_extract(input, '$.clock2.minute') AS minute2
    FROM clock
),
normalized AS (
    SELECT
        id,
        property,
        ((hour * 60 + minute) % 1440 + 1440) % 1440 AS created,
        ((hour * 60 + minute + value) % 1440 + 1440) % 1440 AS added,
        ((hour * 60 + minute - value) % 1440 + 1440) % 1440 AS subtracted,
        ((hour1 * 60 + minute1) % 1440 + 1440) % 1440 AS clock1,
        ((hour2 * 60 + minute2) % 1440 + 1440) % 1440 AS clock2
    FROM data
)
UPDATE clock
SET result = (
    SELECT
        CASE property
            WHEN 'create' THEN
                printf('%02d:%02d', created / 60, created % 60)

            WHEN 'add' THEN
                printf('%02d:%02d', added / 60, added % 60)

            WHEN 'subtract' THEN
                printf('%02d:%02d', subtracted / 60, subtracted % 60)

            WHEN 'equal' THEN
                CAST(clock1 = clock2 AS TEXT)
        END
    FROM normalized
    WHERE normalized.id = clock.rowid
);

