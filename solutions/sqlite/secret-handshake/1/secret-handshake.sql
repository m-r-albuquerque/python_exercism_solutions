-- Schema:
-- CREATE TABLE "secret-handshake" (
--     number INTEGER NOT NULL,
--     result TEXT
-- );
--
-- Task: update secret-handshake table and set result column based on the number.

UPDATE "secret-handshake"
SET result = (
    WITH actions(action, value) AS (
        VALUES
            ('wink', 1),
            ('double blink', 2),
            ('close your eyes', 4),
            ('jump', 8)
    ),
    selected AS (
        SELECT action, value
        FROM actions
        WHERE number & value <> 0
    )
    SELECT COALESCE(
        (
            SELECT group_concat(action, ', ')
            FROM (
                SELECT action
                FROM selected
                ORDER BY
                    CASE WHEN number & 16 <> 0 THEN value END DESC,
                    CASE WHEN number & 16 = 0 THEN value END ASC
            )
        ),
        ''
    )
);
