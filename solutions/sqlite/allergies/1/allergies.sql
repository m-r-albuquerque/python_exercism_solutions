-- Schema: CREATE TABLE "allergies" ("task" TEXT, "item" TEXT, "score" INT NOT NULL, "result" TEXT);
-- Task: update the bob allergies and set the result based on the task.
--       - The `allergicTo` task expects `true` or `false` based on the `score` and the `item` fields.
--       - For the `list` task you have to write corresponding items to the result field

WITH allergens(item, value) AS (
    VALUES
        ('eggs', 1),
        ('peanuts', 2),
        ('shellfish', 4),
        ('strawberries', 8),
        ('tomatoes', 16),
        ('chocolate', 32),
        ('pollen', 64),
        ('cats', 128)
)
UPDATE allergies
SET result =
    CASE task

        WHEN 'allergicTo' THEN (
            SELECT
                CASE
                    WHEN score & value <> 0 THEN 'true'
                    ELSE 'false'
                END
            FROM allergens
            WHERE allergens.item = allergies.item
        )

        WHEN 'list' THEN (
            SELECT COALESCE(group_concat(item, ', '), '')
            FROM allergens
            WHERE score & value <> 0
        )

    END;
