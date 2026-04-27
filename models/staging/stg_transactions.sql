SELECT
    transaction_id,
    customer_id,
    merchant_id,
    date_id,
    payment_method_id,
    amount_gbp,
    is_flagged,
    CASE
        WHEN amount_gbp <= 0          THEN 'invalid_amount'
        WHEN customer_id IS NULL      THEN 'missing_customer'
        WHEN merchant_id IS NULL      THEN 'missing_merchant'
        ELSE 'ok'
    END                                AS data_quality_flag
FROM {{ source('raw', 'fact_transactions') }}