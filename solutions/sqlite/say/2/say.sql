-- Schema:
-- CREATE TABLE say (
--     number INTEGER NOT NULL,
--     result TEXT,
--     error  TEXT
-- );
--
-- Task: update the say table and set the result or the error columns based on the number.

CREATE TABLE words (n INT, digit TEXT, teens TEXT, tens TEXT);
INSERT INTO words VALUES
	(0, '',      'ten',       NULL),
    (1, 'one',   'eleven',    NULL),
    (2, 'two',   'twelve',    'twenty'),
    (3, 'three', 'thirteen',  'thirty'),
    (4, 'four',  'fourteen',  'forty'),
    (5, 'five',  'fifteen',   'fifty'),
    (6, 'six',   'sixteen',   'sixty'),
    (7, 'seven', 'seventeen', 'seventy'),
    (8, 'eight', 'eighteen',  'eighty'),
    (9, 'nine',  'nineteen',  'ninety');
CREATE TABLE units(n INT, word TEXT);
INSERT INTO units VALUES  -- tests only need up to a billion ;)
	(0, ''), (1, ' thousand'), (2, ' million'), (3, ' billion'); -- ...
UPDATE say SET error = CASE
	WHEN number < 0 OR 999999999999 < number THEN 'input out of range'
END;
UPDATE say SET result = (
  	WITH bs(b, rem, num) AS (  -- blocks of 3 digits, starting from the right
    	SELECT 0, number / 1000, number % 1000
      	UNION
      	SELECT b + 1, rem / 1000, rem % 1000 FROM bs WHERE rem > 0
    ),
  	ws(b, i, rem, d, word) AS (  -- "say" each block
    	SELECT b, 1, num / 10 - NOT num, num % 10, iif(number, NULL, 'zero')
      	FROM bs
      	UNION
      	SELECT b, i + 1, rem / 10 - NOT rem, rem % 10, CASE
     		   WHEN i = 1 AND rem % 10 = 1 THEN teens
               WHEN i = 1 THEN digit
               WHEN i = 2 AND d = 1 THEN word
               WHEN i = 2 THEN tens || iif(word != '', '-' || word, '')
      		   ELSE digit || ' hundred' || iif(word != '', ' ' || word, '')
      		END
      	FROM ws, words WHERE d = n AND rem >= 0
    )
  	SELECT group_concat(ws.word || iif(ws.word != '', us.word, ''), ' ')  -- add units
  	FROM (SELECT b, word FROM ws WHERE rem = -1 ORDER BY b DESC) ws,
         (SELECT * FROM units ORDER BY n) us
    WHERE ws.b = us.n
) WHERE NOT error IS NOT NULL;
