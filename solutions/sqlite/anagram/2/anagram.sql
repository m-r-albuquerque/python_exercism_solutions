-- Schema: CREATE TABLE anagram (
--           subject    TEXT NOT NULL,
--           candidates TEXT NOT NULL,     -- json array of strings
--           result     TEXT               -- json array of strings
--         );
-- Task: update the anagram table and set the result based on valid
--       candidates for the subject field
--       * the candidates column contains a JSON-encoded list of strings.
--       * the result column should contain JSON-encoded list of
--         strings as well.

UPDATE anagram
SET result = (
  	WITH tmp1(low, i, c) AS (
    	SELECT lower(subject), 2, substr(lower(subject), 1, 1)
        UNION
        SELECT low, i+1, substr(low, i, 1) FROM tmp1 WHERE i <= length(low)
    ),
    word(low, norm) AS (
    	SELECT low, group_concat(c, '')
      	FROM (SELECT * FROM tmp1 ORDER BY c) GROUP BY low
    ),
  	tmp2(id, word, low, i, c) AS (
    	SELECT rowid, value, lower(value), 2, substr(lower(value), 1, 1)
        FROM json_each(candidates)
        UNION
      	SELECT id, word, low, i+1, substr(low, i, 1)
        FROM tmp2 WHERE i <= length(word)
    ),
  	words(word, low, norm) AS (
    	SELECT word, low, group_concat(c, '')
        FROM (SELECT * FROM tmp2 ORDER BY id, c) GROUP BY id
    )
	SELECT json_group_array(word)
  	FROM words, word
    WHERE words.low != word.low AND words.norm = word.norm
);
