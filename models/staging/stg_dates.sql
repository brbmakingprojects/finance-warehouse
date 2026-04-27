SELECT
    date_id,
    full_date,
    month_num,
    quarter,
    year,
    is_weekend,
    TO_CHAR(full_date, 'Month')        AS month_name
FROM {{ source('raw', 'dim_date') }}