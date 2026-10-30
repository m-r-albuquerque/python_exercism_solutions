-- Schema:
-- CREATE TABLE "phone-number" (
--   phrase TEXT NOT NULL,
--   result TEXT,
--   error TEXT
-- );
--
-- Task: update the phone-number table and set the result or the error columns based on the phrase.

update "phone-number"
set (result, error) = (
  with recursive
    split(ch) as (
      select substr(phrase, value, 1) from generate_series(1, length(phrase))
    ),
    phone(number) as (
      select group_concat(ch, '') from split where ch glob '[0-9]'
    ),
    phone2(number2) as (
      select iif(length(number) = 11, substr(number, 2), number) from phone
    ),
    validate(err) as (
      select case 
        when phrase glob '*[a-z]*' then 'letters not permitted'
        when phrase glob '*[@:!]*' then 'punctuations not permitted'
        when length(number) > 11 then 'must not be greater than 11 digits'
        when length(number) < 10 then 'must not be fewer than 10 digits'
        when length(number) = 11 and substr(number, 1, 1) <> '1' then '11 digits must start with 1'
        when substr(number2, 1, 1) = '0' then 'area code cannot start with zero'
        when substr(number2, 1, 1) = '1' then 'area code cannot start with one'
        when substr(number2, 4, 1) = '0' then 'exchange code cannot start with zero'
        when substr(number2, 4, 1) = '1' then 'exchange code cannot start with one'
      end
      from phone
      join phone2
    )
  select iif(err is null, number2, null), err
  from phone2
  right join validate
);
