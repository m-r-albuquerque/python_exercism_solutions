-- Schema: CREATE TABLE "rna-transcription" ("dna" TEXT, "result" TEXT);
-- Task: update the rna-transcription table and set the result based on the dna field.

UPDATE "rna-transcription"
SET result = UPPER( REPLACE(
                    REPLACE(
                    REPLACE(
                    REPLACE(dna, 'G', 'c')
                               , 'C', 'g')
                               , 'T', 'a')
                               , 'A', 'u'));
