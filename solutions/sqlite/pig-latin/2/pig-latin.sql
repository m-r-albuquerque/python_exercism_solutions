-- Schema: CREATE TABLE "pig-latin" ( phrase TEXT NOT NULL, result TEXT );
-- Task: update the pig-latin table and set the result based on the phrase.

UPDATE "pig-latin" SET result = (
    WITH words(i, w, c) AS (
    	SELECT 2, 0, substr(phrase, 1, 1)
      	UNION
      	SELECT i + 1, w + iif(c = ' ', 1, 0), substr(phrase, i, 1)
      	FROM words WHERE i <= length(phrase)
    ),
  	split(w, i, suf, split) AS (
        SELECT w, 1, w, iif(w GLOB '[aeiou]*' OR substr(w, 1, 2) IN ('xr', 'yt'), 1, 0)
      	FROM (SELECT group_concat(c, '') w FROM words WHERE c != ' ' GROUP BY w)
        UNION
        SELECT w, i + 1, substr(suf, 2),
               CASE
                   WHEN suf GLOB 'qu*' THEN i + 2
                   WHEN (i > 1 AND suf GLOB 'y*') OR suf GLOB '[aeiou]*' THEN i
                   ELSE 0
                END
      	FROM split WHERE split = 0
    )
  	SELECT group_concat(w, ' ')
  	FROM (SELECT (substr(w, split) || substr(w, 1, split - 1) || 'ay') w
          FROM split WHERE split != 0)
);
