-- Schema:
-- CREATE TABLE "twelve-days" (
--     start_verse INTEGER NOT NULL,
--     end_verse   INTEGER NOT NULL,
--     result      TEXT
-- );
--
-- Task: update the twelve-days table and set result bases on the start_verse and end_verse.

UPDATE "twelve-days" SET result = (
	WITH rs(id, nth, object) AS (
		VALUES
          (2, 'second', 'three French Hens, '),
          (3, 'third', 'four Calling Birds, '),
          (4, 'fourth', 'five Gold Rings, '),
          (5, 'fifth', 'six Geese-a-Laying, '),
          (6, 'sixth', 'seven Swans-a-Swimming, '),
          (7, 'seventh', 'eight Maids-a-Milking, '),
          (8, 'eighth', 'nine Ladies Dancing, '),
          (9, 'ninth', 'ten Lords-a-Leaping, '),
          (10, 'tenth', 'eleven Pipers Piping, '),
          (11, 'eleventh', 'twelve Drummers Drumming, '),
          (12, 'twelfth', '')
	),
  	vs(i, v, os) AS (
    	SELECT 2,
      		   'On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.',
               'two Turtle Doves, and a Partridge in a Pear Tree.'
      	UNION
      	SELECT i + 1,
               format('On the %s day of Christmas my true love gave to me: %s', nth, os),
               object || os
        FROM vs, rs WHERE id = i AND i <= end_verse
    )
  	SELECT group_concat(v, char(10))
    FROM vs WHERE i - 1 BETWEEN start_verse AND end_verse
);
