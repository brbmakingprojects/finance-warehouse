SELECT
    payment_method_id,
    TRIM(method_type)                  AS method_type,
    TRIM(provider)                     AS provider,
    is_digital
FROM {{ source('raw', 'dim_payment_method') }}