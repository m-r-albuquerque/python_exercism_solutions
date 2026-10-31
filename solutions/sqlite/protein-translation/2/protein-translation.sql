-- Schema:
-- CREATE TABLE "protein-translation" (
--   strand TEXT NOT NULL,
--   result TEXT         ,
--   error  TEXT
-- );
--
-- Task: update the protein-translation and set the result or the error columns based on strand.

UPDATE "protein-translation" SET (result, error) = (
	WITH scan(i, stop, condon, acid) AS (
    	SELECT 4, length(strand) + 3, substr(strand, 1, 3), ''
      	UNION
      	SELECT i + 3, stop, substr(strand, i, 3),
               CASE
      		       WHEN condon = 'AUG' THEN 'Methionine'
                   WHEN condon IN ('UUU', 'UUC') THEN 'Phenylalanine'
                   WHEN condon IN ('UUA', 'UUG') THEN 'Leucine'
                   WHEN condon IN ('UCU', 'UCC', 'UCA', 'UCG') THEN 'Serine'
                   WHEN condon IN ('UAU', 'UAC') THEN 'Tyrosine'
                   WHEN condon IN ('UGU', 'UGC') THEN 'Cysteine'
                   WHEN condon = 'UGG' THEN 'Tryptophan'
                   WHEN condon IN ('UAA', 'UAG', 'UGA') THEN 'STOP'
                   ELSE 'ERROR'
      		  END
      	FROM scan WHERE i <= stop AND acid NOT IN ('STOP', 'ERROR')
	)
	SELECT iif(NOT acids LIKE '%ERROR', acids, NULL),
           iif(acids LIKE '%ERROR', 'Invalid codon', NULL)
    FROM (SELECT coalesce(group_concat(acid, ', '), '') acids
      	  FROM scan WHERE acid NOT IN ('', 'STOP'))
);
