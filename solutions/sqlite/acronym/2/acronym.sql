-- Schema: CREATE TABLE acronym ( phrase TEXT PRIMARY KEY, result TEXT );
-- Task: update the acronym table and set the result based on the phrase.

UPDATE acronym
SET result = (
  WITH RECURSIVE
    chars(pos, ch, prev_ch) AS (
      SELECT 1, substr(phrase, 1, 1), ' '
      UNION ALL
      SELECT pos + 1, substr(phrase, pos + 1, 1), substr(phrase, pos, 1)
      FROM chars
      WHERE pos < length(phrase)
    ),
    edges(ch) AS (
      SELECT upper(ch) FROM chars WHERE (ch glob '[a-zA-Z]') AND NOT (prev_ch glob '[a-zA-Z'']')
    )
  SELECT group_concat(ch, '') FROM edges
);
