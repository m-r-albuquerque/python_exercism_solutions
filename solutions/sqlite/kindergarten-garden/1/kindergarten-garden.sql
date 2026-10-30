-- Schema: CREATE TABLE "kindergarten-garden" ("diagram" TEXT, "student" TEXT, "result" TEXT);
-- Task: update the kindergarten-garden table and set the result based on the diagram and student fields.

WITH positions AS (
    SELECT
        rowid AS id,
        diagram,
        student,
        CASE student
            WHEN 'Alice'   THEN 0
            WHEN 'Bob'     THEN 2
            WHEN 'Charlie' THEN 4
            WHEN 'David'   THEN 6
            WHEN 'Eve'     THEN 8
            WHEN 'Fred'    THEN 10
            WHEN 'Ginny'   THEN 12
            WHEN 'Harriet' THEN 14
            WHEN 'Ileana'  THEN 16
            WHEN 'Joseph'  THEN 18
            WHEN 'Kincaid' THEN 20
            WHEN 'Larry'   THEN 22
        END AS pos
    FROM "kindergarten-garden"
),
plants AS (
    SELECT
        id,
        substr(diagram, pos + 1, 2) ||
        substr(
            diagram,
            instr(diagram, char(10)) + pos + 1,
            2
        ) AS cups
    FROM positions
),
decoded AS (
    SELECT
        id,
        CASE substr(cups, 1, 1)
            WHEN 'G' THEN 'grass'
            WHEN 'C' THEN 'clover'
            WHEN 'R' THEN 'radishes'
            WHEN 'V' THEN 'violets'
        END
        || ',' ||
        CASE substr(cups, 2, 1)
            WHEN 'G' THEN 'grass'
            WHEN 'C' THEN 'clover'
            WHEN 'R' THEN 'radishes'
            WHEN 'V' THEN 'violets'
        END
        || ',' ||
        CASE substr(cups, 3, 1)
            WHEN 'G' THEN 'grass'
            WHEN 'C' THEN 'clover'
            WHEN 'R' THEN 'radishes'
            WHEN 'V' THEN 'violets'
        END
        || ',' ||
        CASE substr(cups, 4, 1)
            WHEN 'G' THEN 'grass'
            WHEN 'C' THEN 'clover'
            WHEN 'R' THEN 'radishes'
            WHEN 'V' THEN 'violets'
        END AS result
    FROM plants
)
UPDATE "kindergarten-garden"
SET result = (
    SELECT result
    FROM decoded
    WHERE decoded.id = "kindergarten-garden".rowid
);

