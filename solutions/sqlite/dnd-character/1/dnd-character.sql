-- Schema:
-- CREATE TABLE "dnd-character" (
--   property     TEXT    NOT NULL,
--   input        TEXT    NOT NULL,
--   strength     INTEGER         ,
--   dexterity    INTEGER         ,
--   constitution INTEGER         ,
--   intelligence INTEGER         ,
--   wisdom       INTEGER         ,
--   charisma     INTEGER         ,
--   modifier     INTEGER         ,
--   hitpoints    INTEGER
-- );
--
-- Task: update the dnd-character table and set the appropriate columns based on the property and the input.

-- Abilities
WITH RECURSIVE
    rolls AS (
        SELECT
            ROW_NUMBER() OVER () AS n,
            1 + abs(random()) % 6 AS roll
        FROM generate_series(1, 24)
    ),
    abilities AS (
        SELECT
            (n - 1) / 4 AS ability,
            SUM(roll) - MIN(roll) AS score
        FROM (
            SELECT
                n,
                roll
            FROM rolls
        )
        GROUP BY (n - 1) / 4
    )
UPDATE "dnd-character"
SET
    strength     = (SELECT score FROM abilities WHERE ability = 0),
    dexterity    = (SELECT score FROM abilities WHERE ability = 1),
    constitution = (SELECT score FROM abilities WHERE ability = 2),
    intelligence = (SELECT score FROM abilities WHERE ability = 3),
    wisdom       = (SELECT score FROM abilities WHERE ability = 4),
    charisma     = (SELECT score FROM abilities WHERE ability = 5)
WHERE input <> 'score';


-- Modifier
UPDATE "dnd-character"
SET modifier = floor((constitution - 10) / 2.0)
WHERE property = 'modifier'
  AND input = 'score';


-- Hitpoints
UPDATE "dnd-character"
SET
    modifier = (
        SELECT modifier
        FROM "dnd-character"
        WHERE property = 'modifier'
          AND input = 'score'
    ),
    hitpoints = 10 + (
        SELECT modifier
        FROM "dnd-character"
        WHERE property = 'modifier'
          AND input = 'score'
    )
WHERE property = 'character'
  AND input = 'random';
