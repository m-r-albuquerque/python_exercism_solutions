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

WITH RECURSIVE
alphabet(letter) AS (
    SELECT 'a'
    UNION ALL
    SELECT char(unicode(letter) + 1)
    FROM alphabet
    WHERE letter < 'z'
),
candidates AS (
    SELECT
        a.rowid AS id,
        j.key AS position,
        j.value AS candidate
    FROM anagram AS a,
         json_each(a.candidates) AS j
),
valid_candidates AS (
    SELECT
        c.id,
        c.position,
        c.candidate
    FROM candidates AS c
    WHERE lower(c.candidate) <> (
        SELECT lower(subject)
        FROM anagram
        WHERE rowid = c.id
    )
    AND NOT EXISTS (
        SELECT 1
        FROM alphabet AS a
        WHERE
            (
                length(lower(c.candidate))
                - length(replace(lower(c.candidate), a.letter, ''))
            )
            <>
            (
                SELECT
                    length(lower(subject))
                    - length(replace(lower(subject), a.letter, ''))
                FROM anagram
                WHERE rowid = c.id
            )
    )
)
UPDATE anagram
SET result = (
    SELECT json_group_array(candidate)
    FROM (
        SELECT candidate
        FROM valid_candidates
        WHERE valid_candidates.id = anagram.rowid
        ORDER BY position
    )
);

