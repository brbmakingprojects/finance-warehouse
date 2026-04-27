SELECT
    customer_id,
    TRIM(full_name)                    AS customer_name,
    TRIM(country)                      AS country,
    LOWER(TRIM(risk_tier))             AS risk_tier,
    CASE
        WHEN LOWER(TRIM(risk_tier)) IN ('low','medium','high')
        THEN TRUE ELSE FALSE
    END                                AS is_valid_risk_tier
FROM {{ source('raw', 'dim_customer') }}