-- Schema: CREATE TABLE IF NOT EXISTS color_code ( color1 TEXT, color2 TEXT, color3 TEXT, result TEXT );
-- Task: update the color_code table and set the result based on the colors.

UPDATE color_code
SET result =
    CASE
        WHEN value < 1000 THEN
            CAST(value AS INTEGER) || ' ohms'

        WHEN value < 1000000 THEN
            CAST(value / 1000 AS INTEGER) || ' kiloohms'

        WHEN value < 1000000000 THEN
            CAST(value / 1000000 AS INTEGER) || ' megaohms'

        ELSE
            CAST(value / 1000000000 AS INTEGER) || ' gigaohms'
    END
FROM (
    SELECT
        rowid,
        (
            CASE color1
                WHEN 'black' THEN 0
                WHEN 'brown' THEN 1
                WHEN 'red' THEN 2
                WHEN 'orange' THEN 3
                WHEN 'yellow' THEN 4
                WHEN 'green' THEN 5
                WHEN 'blue' THEN 6
                WHEN 'violet' THEN 7
                WHEN 'grey' THEN 8
                WHEN 'white' THEN 9
            END * 10
            +
            CASE color2
                WHEN 'black' THEN 0
                WHEN 'brown' THEN 1
                WHEN 'red' THEN 2
                WHEN 'orange' THEN 3
                WHEN 'yellow' THEN 4
                WHEN 'green' THEN 5
                WHEN 'blue' THEN 6
                WHEN 'violet' THEN 7
                WHEN 'grey' THEN 8
                WHEN 'white' THEN 9
            END
        )
        *
        POWER(
            10,
            CASE color3
                WHEN 'black' THEN 0
                WHEN 'brown' THEN 1
                WHEN 'red' THEN 2
                WHEN 'orange' THEN 3
                WHEN 'yellow' THEN 4
                WHEN 'green' THEN 5
                WHEN 'blue' THEN 6
                WHEN 'violet' THEN 7
                WHEN 'grey' THEN 8
                WHEN 'white' THEN 9
            END
        ) AS value
    FROM color_code
) AS values_table
WHERE color_code.rowid = values_table.rowid;
