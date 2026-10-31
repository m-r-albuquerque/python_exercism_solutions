-- Schema:
-- CREATE TABLE house (
--     start_verse INTEGER NOT NULL,
--     end_verse   INTEGER NOT NULL,
--     result      TEXT
-- );
--
-- Task: update house table and set the result based on the start_verse and end_verse.

UPDATE house
SET result = (
    WITH RECURSIVE
    verses(n, line) AS (
        VALUES
            (1, 'This is the house that Jack built.')

        UNION ALL

        SELECT
            n + 1,
            CASE n + 1
                WHEN 2 THEN
                    'This is the malt that lay in the house that Jack built.'

                WHEN 3 THEN
                    'This is the rat that ate the malt that lay in the house that Jack built.'

                WHEN 4 THEN
                    'This is the cat that killed the rat that ate the malt that lay in the house that Jack built.'

                WHEN 5 THEN
                    'This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.'

                WHEN 6 THEN
                    'This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.'

                WHEN 7 THEN
                    'This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.'

                WHEN 8 THEN
                    'This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.'

                WHEN 9 THEN
                    'This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.'

                WHEN 10 THEN
                    'This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.'

                WHEN 11 THEN
                    'This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.'

                WHEN 12 THEN
                    'This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.'
            END
        FROM verses
        WHERE n < 12
    )
    SELECT group_concat(line, char(10))
    FROM verses
    WHERE n BETWEEN start_verse AND end_verse
    ORDER BY n
);
