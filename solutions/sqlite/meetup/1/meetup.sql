-- Schema: CREATE TABLE "meetup" ( "year" INTEGER, "month" INTEGER, "week" TEXT, "dayofweek" TEXT, "result" TEXT);
-- Task: update the meetup table and set the result based on the other fields.

WITH base AS (
    SELECT
        rowid AS id,
        year,
        month,
        week,
        dayofweek,
        date(
            printf('%04d-%02d-01', year, month)
        ) AS first_day
    FROM meetup
),
mapped AS (
    SELECT
        *,
        CASE dayofweek
            WHEN 'Sunday'    THEN 0
            WHEN 'Monday'    THEN 1
            WHEN 'Tuesday'   THEN 2
            WHEN 'Wednesday' THEN 3
            WHEN 'Thursday'  THEN 4
            WHEN 'Friday'    THEN 5
            WHEN 'Saturday'  THEN 6
        END AS dow
    FROM base
),
first_occurrence AS (
    SELECT
        *,
        date(
            first_day,
            '+' ||
            (
                (dow - CAST(strftime('%w', first_day) AS INTEGER) + 7) % 7
            ) ||
            ' days'
        ) AS first_date
    FROM mapped
),
results AS (
    SELECT
        *,
        CASE week
            WHEN 'first'
                THEN first_date

            WHEN 'second'
                THEN date(first_date, '+7 days')

            WHEN 'third'
                THEN date(first_date, '+14 days')

            WHEN 'fourth'
                THEN date(first_date, '+21 days')

            WHEN 'teenth' THEN (
                SELECT MIN(
                    date(first_day, '+' || n || ' days')
                )
                FROM (
                    SELECT 12 AS n
                    UNION ALL SELECT 13
                    UNION ALL SELECT 14
                    UNION ALL SELECT 15
                    UNION ALL SELECT 16
                    UNION ALL SELECT 17
                    UNION ALL SELECT 18
                )
                WHERE strftime(
                    '%w',
                    date(first_day, '+' || n || ' days')
                ) = CAST(dow AS TEXT)
            )

            WHEN 'last' THEN (
                SELECT date(
                    last_day,
                    '-' ||
                    (
                        (CAST(strftime('%w', last_day) AS INTEGER) - dow + 7) % 7
                    ) ||
                    ' days'
                )
                FROM (
                    SELECT date(
                        first_day,
                        '+1 month',
                        '-1 day'
                    ) AS last_day
                )
            )
        END AS result_date
    FROM first_occurrence
)
UPDATE meetup
SET result = (
    SELECT strftime('%Y-%m-%d', result_date)
    FROM results
    WHERE results.id = meetup.rowid
);

