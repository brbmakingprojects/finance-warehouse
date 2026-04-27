SELECT
    transaction_id,
    transaction_date,
    customer_name,
    customer_country,
    risk_tier,
    merchant_name,
    merchant_category,
    amount_gbp,
    payment_type,
    is_digital
FROM {{ ref('mart_transactions') }}
WHERE is_flagged = TRUE
ORDER BY amount_gbp DESC