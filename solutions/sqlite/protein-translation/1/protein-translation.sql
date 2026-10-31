-- Schema:
-- CREATE TABLE "protein-translation" (
--   strand TEXT NOT NULL,
--   result TEXT         ,
--   error  TEXT
-- );
--
-- Task: update the protein-translation and set the result or the error columns based on strand.

UPDATE "protein-translation"
SET
    error = (
        WITH RECURSIVE
        codons(i, codon) AS (
            SELECT
                1,
                substr(strand, 1, 3)
            WHERE length(strand) > 0

            UNION ALL

            SELECT
                i + 3,
                substr(strand, i + 3, 3)
            FROM codons
            WHERE i + 3 <= length(strand)
              AND codon NOT IN ('UAA', 'UAG', 'UGA')
        )
        SELECT
            CASE
                WHEN EXISTS (
                    SELECT 1
                    FROM codons
                    WHERE length(codon) != 3
                       OR codon NOT IN (
                            'AUG',
                            'UUU', 'UUC',
                            'UUA', 'UUG',
                            'UCU', 'UCC', 'UCA', 'UCG',
                            'UAU', 'UAC',
                            'UGU', 'UGC',
                            'UGG',
                            'UAA', 'UAG', 'UGA'
                       )
                )
                THEN 'Invalid codon'
            END
    );

UPDATE "protein-translation"
SET result = (
    WITH RECURSIVE
    codons(i, codon) AS (
        SELECT
            1,
            substr(strand, 1, 3)
        WHERE length(strand) > 0

        UNION ALL

        SELECT
            i + 3,
            substr(strand, i + 3, 3)
        FROM codons
        WHERE i + 3 <= length(strand)
          AND codon NOT IN ('UAA', 'UAG', 'UGA')
    ),

    proteins(codon, protein) AS (
        VALUES
            ('AUG', 'Methionine'),
            ('UUU', 'Phenylalanine'),
            ('UUC', 'Phenylalanine'),
            ('UUA', 'Leucine'),
            ('UUG', 'Leucine'),
            ('UCU', 'Serine'),
            ('UCC', 'Serine'),
            ('UCA', 'Serine'),
            ('UCG', 'Serine'),
            ('UAU', 'Tyrosine'),
            ('UAC', 'Tyrosine'),
            ('UGU', 'Cysteine'),
            ('UGC', 'Cysteine'),
            ('UGG', 'Tryptophan')
    )

    SELECT COALESCE(
        (
            SELECT group_concat(protein, ', ')
            FROM (
                SELECT
                    codons.i,
                    proteins.protein
                FROM codons
                JOIN proteins
                    ON proteins.codon = codons.codon
                WHERE codons.codon NOT IN ('UAA', 'UAG', 'UGA')
                ORDER BY codons.i
            )
        ),
        ''
    )
)
WHERE error IS NULL;
