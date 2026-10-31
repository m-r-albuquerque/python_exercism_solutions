-- Schema:
-- CREATE TABLE "food-chain" (
--   start_verse INTEGER NOT NULL,
--   end_verse   INTEGER NOT NULL,
--   result      TEXT
-- );
--
-- Task: update the food-chain table and set the result column based on the start_verse and end_verse.

UPDATE "food-chain" SET result = (
    WITH ps(n, animal, addition) AS (
        VALUES (1, 'fly',    'I don''t know why she swallowed the fly. Perhaps she''ll die.'),
               (2, 'spider', 'It wriggled and jiggled and tickled inside her.'),
               (3, 'bird',   'How absurd to swallow a bird!'),
               (4, 'cat',    'Imagine that, to swallow a cat!'),
               (5, 'dog',    'What a hog, to swallow a dog!'),
               (6, 'goat',   'Just opened her throat and swallowed a goat!'),
               (7, 'cow',    'I don''t know how she swallowed a cow!'),
               (8, 'horse',  'She''s dead, of course!')
    ),
    ts(n, last_animal, tail) AS (
        SELECT 2, 'fly', char(10) || 'I don''t know why she swallowed the fly. Perhaps she''ll die.'
        UNION ALL
        SELECT ts.n + 1,
               animal || iif(animal = 'spider', ' that wriggled and jiggled and tickled inside her', ''),
               iif(ts.n = 8, '', format(char(10) || 'She swallowed the %s to catch the %s.%s',
                                        animal, last_animal, tail))
        FROM ts, ps WHERE ts.n <= end_verse AND ts.n = ps.n
    )
    SELECT group_concat(format('I know an old lady who swallowed a %s.%s%s',
                               animal, iif(ps.n = 1, '', char(10) || addition), tail),
                        char(10) || char(10))
    FROM ps, ts WHERE ps.n BETWEEN start_verse AND end_verse AND ts.n = ps.n + 1
);
