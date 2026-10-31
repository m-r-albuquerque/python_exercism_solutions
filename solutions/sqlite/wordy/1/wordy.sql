-- Schema:
-- CREATE TABLE wordy (
--   question TEXT    NOT NULL,
--   result   INTEGER         ,
--   error    TEXT
-- );
--
-- Task: update the wordy table and set the result or the error columns bases on the question.

UPDATE wordy SET error = CASE
    WHEN NOT question LIKE 'What is%?' THEN 'unknown operation'
END;
UPDATE wordy SET (result, error) = (
    WITH split(string, i, n, ch) AS (
        SELECT 'plus ' || iif(string = '', 'X', string) || ' plus 0', 2, 0, 'p'
        FROM (SELECT replace(rtrim(substr(question, 9), '?'), ' by', '_by') string)
        UNION ALL
        SELECT string, i + 1, n + (ch IN (' ', '')), substr(string, i, 1)
        FROM split WHERE ch != ''
    ),
    ws(n, word) AS (
        SELECT n, group_concat(ch, '') FROM split WHERE ch != ' ' GROUP BY n
    ),
    res(n, stop, op, res) AS (
        SELECT 0, (SELECT max(n) + 1 FROM ws), 0, 0
        UNION ALL
        SELECT iif(res LIKE 'e:%', stop, res.n + 1), stop, word,
      		   iif(res.n % 2,
      		       CASE
                      WHEN CAST(op AS INT) = op THEN 'e:syntax error'
                      WHEN op NOT IN ('plus', 'minus', 'multiplied_by', 'divided_by')
                          THEN 'e:unknown operation'
                      WHEN CAST(word AS INT) != word THEN 'e:syntax error'
                      WHEN op = 'plus'          THEN res + word
                      WHEN op = 'minus'         THEN res - word
                      WHEN op = 'multiplied_by' THEN res * word
                      WHEN op = 'divided_by'    THEN res / word
      		       END, res)
        FROM res, ws WHERE res.n < stop AND res.n = ws.n
    )
  	SELECT iif(res LIKE 'e:%', NULL, res), iif(res LIKE 'e:%', substr(res, 3), NULL)
    FROM res WHERE n = stop
) WHERE error IS NULL;
