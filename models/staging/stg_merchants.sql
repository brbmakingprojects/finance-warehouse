SELECT
    merchant_id,
    TRIM(merchant_name)                AS merchant_name,
    TRIM(category)                     AS merchant_category,
    TRIM(country)                      AS merchant_country
FROM {{ source('raw', 'dim_merchant') }}