-- Loss Ratio Analysis by Region
-- Business Question: Which regions are most unprofitable?
-- Loss Ratio = Total Claims Paid / Total Premiums Collected
-- A ratio above 1.0 means paying out more than collecting


WITH regional_summary AS (
  SELECT
    c.region
    , COUNT(*) AS total_claims
    , ROUND(SUM(p.policy_annual_premium), 2) AS total_premiums
    , ROUND(SUM(c.total_claim_amount), 2) AS total_claims_paid
    , ROUND(AVG(c.total_claim_amount), 2) AS avg_claim_amount
    , ROUND(AVG(p.policy_annual_premium), 2) AS avg_premium
    , SUM(c.fraud_reported) AS fraud_count
    , ROUND(AVG(c.fraud_reported) * 100, 1) AS fraud_rate_pct
  FROM
    fact_claims c
    JOIN dim_policies p
  ON c.policy_number = p.policy_number
  GROUP BY
    c.region
)
, with_loss_ratio AS (
  SELECT
    *
    , ROUND(
      CAST(total_claims_paid AS REAL) / NULLIF(total_premiums, 0)
      , 2
    ) AS loss_ratio
  FROM
    regional_summary
)
SELECT
  region
  , total_claims
  , avg_premium
  , avg_claim_amount
  , loss_ratio
  , fraud_rate_pct
  , CASE
    WHEN loss_ratio > (
      SELECT
        AVG(loss_ratio)
      FROM
        with_loss_ratio
    )
    THEN 'HIGH RISK'
    ELSE 'Normal'
  END AS risk_flag
FROM
  with_loss_ratio
ORDER BY
  loss_ratio DESC;