-- Schema: CREATE TABLE "rna-transcription" ("dna" TEXT, "result" TEXT);
-- Task: update the rna-transcription table and set the result based on the dna field.

WITH RECURSIVE chars(pos, dna, result) AS (
    SELECT
        1,
        dna,
        ''
    FROM "rna-transcription"

    UNION ALL

    SELECT
        pos + 1,
        dna,
        result ||
        CASE substr(dna, pos, 1)
            WHEN 'G' THEN 'C'
            WHEN 'C' THEN 'G'
            WHEN 'T' THEN 'A'
            WHEN 'A' THEN 'U'
        END
    FROM chars
    WHERE pos <= length(dna)
)
UPDATE "rna-transcription"
SET result = (
    SELECT result
    FROM chars
    WHERE chars.dna = "rna-transcription".dna
      AND pos = length(chars.dna) + 1
);
