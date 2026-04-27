SELECT
    t.transaction_id,
    t.amount_gbp,
    t.is_flagged,
    t.data_quality_flag,

    -- Customer
    c.customer_name,
    c.country                          AS customer_country,
    c.risk_tier,

    -- Merchant
    m.merchant_name,
    m.merchant_category,
    m.merchant_country,

    -- Date
    d.full_date                        AS transaction_date,
    d.month_name,
    d.month_num,
    d.quarter,
    d.year,
    d.is_weekend,

    -- Payment
    p.method_type                      AS payment_type,
    p.provider                         AS payment_provider,
    p.is_digital

FROM {{ ref('stg_transactions') }}    t
LEFT JOIN {{ ref('stg_customers') }}  c  ON t.customer_id       = c.customer_id
LEFT JOIN {{ ref('stg_merchants') }}  m  ON t.merchant_id       = m.merchant_id
LEFT JOIN {{ ref('stg_dates') }}      d  ON t.date_id           = d.date_id
LEFT JOIN {{ ref('stg_payment_methods') }} p ON t.payment_method_id = p.payment_method_id