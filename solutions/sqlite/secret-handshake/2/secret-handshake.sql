-- Schema:
-- CREATE TABLE "secret-handshake" (
--     number INTEGER NOT NULL,
--     result TEXT
-- );
--
-- Task: update secret-handshake table and set result column based on the number.

UPDATE "secret-handshake" SET result = (
	WITH parts(e, shake) AS (
    	VALUES (1, 'wink'), (2, 'double blink'), (4, 'close your eyes'), (8, 'jump')
    )
    SELECT ifnull(group_concat(shake, ', '), '')
  	FROM (SELECT iif(number & 16, -e, e) e, shake
          FROM parts WHERE (number & e) ORDER BY e)
);
