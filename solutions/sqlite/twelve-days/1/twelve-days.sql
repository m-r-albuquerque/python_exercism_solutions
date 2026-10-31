-- Schema:
-- CREATE TABLE "twelve-days" (
--     start_verse INTEGER NOT NULL,
--     end_verse   INTEGER NOT NULL,
--     result      TEXT
-- );
--
-- Task: update the twelve-days table and set result bases on the start_verse and end_verse.

UPDATE "twelve-days"
SET result = (
    WITH
    days(day, name) AS (
        VALUES
            (1, 'first'),
            (2, 'second'),
            (3, 'third'),
            (4, 'fourth'),
            (5, 'fifth'),
            (6, 'sixth'),
            (7, 'seventh'),
            (8, 'eighth'),
            (9, 'ninth'),
            (10, 'tenth'),
            (11, 'eleventh'),
            (12, 'twelfth')
    ),

    gifts(day, gift) AS (
        VALUES
            (1, 'a Partridge in a Pear Tree.'),
            (2, 'two Turtle Doves'),
            (3, 'three French Hens'),
            (4, 'four Calling Birds'),
            (5, 'five Gold Rings'),
            (6, 'six Geese-a-Laying'),
            (7, 'seven Swans-a-Swimming'),
            (8, 'eight Maids-a-Milking'),
            (9, 'nine Ladies Dancing'),
            (10, 'ten Lords-a-Leaping'),
            (11, 'eleven Pipers Piping'),
            (12, 'twelve Drummers Drumming')
    ),

    verses AS (
        SELECT
            d.day,
            'On the ' || d.name ||
            ' day of Christmas my true love gave to me: ' ||
            (
                SELECT group_concat(gift, ', ')
                FROM (
                    SELECT
                        CASE
                            WHEN g.day = 1 AND d.day > 1
                                THEN 'and ' || g.gift
                            ELSE g.gift
                        END AS gift
                    FROM gifts AS g
                    WHERE g.day <= d.day
                    ORDER BY g.day DESC
                )
            ) AS verse
        FROM days AS d
    )

    SELECT group_concat(verse, char(10))
    FROM verses
    WHERE day BETWEEN start_verse AND end_verse
    ORDER BY day
);
