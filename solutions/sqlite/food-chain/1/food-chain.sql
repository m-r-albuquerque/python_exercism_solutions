-- Schema:
-- CREATE TABLE "food-chain" (
--   start_verse INTEGER NOT NULL,
--   end_verse   INTEGER NOT NULL,
--   result      TEXT
-- );
--
-- Task: update the food-chain table and set the result column based on the start_verse and end_verse.

UPDATE "food-chain"
SET result = (
    WITH RECURSIVE

    animals(id, animal, intro, special) AS (
        VALUES
            (1, 'fly',
             'I know an old lady who swallowed a fly.',
             'I don''t know why she swallowed the fly. Perhaps she''ll die.'),

            (2, 'spider',
             'I know an old lady who swallowed a spider.',
             'It wriggled and jiggled and tickled inside her.'),

            (3, 'bird',
             'I know an old lady who swallowed a bird.',
             'How absurd to swallow a bird!'),

            (4, 'cat',
             'I know an old lady who swallowed a cat.',
             'Imagine that, to swallow a cat!'),

            (5, 'dog',
             'I know an old lady who swallowed a dog.',
             'What a hog, to swallow a dog!'),

            (6, 'goat',
             'I know an old lady who swallowed a goat.',
             'Just opened her throat and swallowed a goat!'),

            (7, 'cow',
             'I know an old lady who swallowed a cow.',
             'I don''t know how she swallowed a cow!'),

            (8, 'horse',
             'I know an old lady who swallowed a horse.',
             'She''s dead, of course!')
    ),

    chain(verse_id, animal_id, text) AS (

        -- Versos 2 a 7:
        -- cada um começa no seu próprio animal
        SELECT
            id,
            id,
            intro || char(10) || special
        FROM animals
        WHERE id BETWEEN 2 AND 7

        UNION ALL

        -- Desce pela cadeia:
        -- cow -> goat -> dog -> cat -> bird -> spider
        SELECT
            c.verse_id,
            c.animal_id - 1,

            c.text || char(10) ||
            'She swallowed the ' ||
            current.animal ||
            ' to catch the ' ||
            previous.animal ||
            CASE
                WHEN previous.id = 2
                    THEN ' that wriggled and jiggled and tickled inside her.'
                ELSE '.'
            END

        FROM chain AS c

        JOIN animals AS current
            ON current.id = c.animal_id

        JOIN animals AS previous
            ON previous.id = c.animal_id - 1

        WHERE c.animal_id > 2
    ),

    verses AS (

        -- Verso 1
        SELECT
            1 AS verse_id,
            intro || char(10) || special AS text
        FROM animals
        WHERE id = 1

        UNION ALL

        -- Versos 2 a 7:
        -- pegamos somente o estado final da recursão
        SELECT
            c.verse_id,

            c.text ||
            char(10) ||
            'She swallowed the spider to catch the fly.' ||
            char(10) ||
            'I don''t know why she swallowed the fly. Perhaps she''ll die.'
        FROM chain AS c
        WHERE c.animal_id = 2

        UNION ALL

        -- Verso 8: caso especial, sem cadeia
        SELECT
            8 AS verse_id,
            intro || char(10) || special AS text
        FROM animals
        WHERE id = 8
    )

    SELECT group_concat(text, char(10) || char(10))
    FROM (
        SELECT verse_id, text
        FROM verses
        WHERE verse_id BETWEEN start_verse AND end_verse
        ORDER BY verse_id
    )
);
