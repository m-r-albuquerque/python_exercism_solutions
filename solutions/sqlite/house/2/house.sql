-- Schema:
-- CREATE TABLE house (
--     start_verse INTEGER NOT NULL,
--     end_verse   INTEGER NOT NULL,
--     result      TEXT
-- );
--
-- Task: update house table and set the result based on the start_verse and end_verse.

CREATE TABLE lines ( line TEXT );
INSERT INTO lines VALUES
    ('horse and the hound and the horn that belonged to'),
    ('farmer sowing his corn that kept'),
    ('rooster that crowed in the morn that woke'),
    ('priest all shaven and shorn that married'),
    ('man all tattered and torn that kissed'),
    ('maiden all forlorn that milked'),
    ('cow with the crumpled horn that tossed'),
    ('dog that worried'),
    ('cat that killed'),
    ('rat that ate'),
	('malt that lay in'),
	('house that Jack built.');
UPDATE house SET result = (
	SELECT group_concat(tail, char(10))
  	FROM (SELECT rowid, 'This is ' || group_concat(format('the %s', line), ' ') OVER (
                 	ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
    			 ) tail
          FROM lines WHERE rowid > 12 - end_verse ORDER BY rowid DESC)
  	WHERE rowid <= 13 - start_verse
);
