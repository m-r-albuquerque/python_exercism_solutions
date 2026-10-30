-- Schema: CREATE TABLE "bob" ("input" TEXT, "reply" TEXT);
-- Task: update the bob table and set the reply based on the input.

UPDATE "bob"
SET reply =
    CASE
        -- silêncio
        WHEN input IS NULL
             OR trim(input, ' ' || char(9) || char(10) || char(13)) = ''
            THEN 'Fine. Be that way!'

        -- pergunta + grito
        WHEN trim(input, ' ' || char(9) || char(10) || char(13)) LIKE '%?'
             AND upper(input) = input
             AND input GLOB '*[A-Z]*'
            THEN 'Calm down, I know what I''m doing!'

        -- pergunta
        WHEN trim(input, ' ' || char(9) || char(10) || char(13)) LIKE '%?'
            THEN 'Sure.'

        -- grito
        WHEN upper(input) = input
             AND input GLOB '*[A-Z]*'
            THEN 'Whoa, chill out!'

        ELSE 'Whatever.'
    END;


