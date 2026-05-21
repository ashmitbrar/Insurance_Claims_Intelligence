-- Policy Vintage Risk Analysis
-- Business Question: Do newer policies have higher fraud rates?
-- Common pattern: fraud rings take out policies specifically to claim
-- Uses window functions to rank policy age cohorts

WITH policy_age_cohorts AS (
  SELECT
    c.policy_number
    , c.fraud_reported
    , c.total_claim_amount
    , p.policy_annual_premium
    , -- Bucket policies into age cohorts
      CASE
      WHEN CAST(p.months_as_customer AS INTEGER) < 12 THEN '0-1 year'
      WHEN CAST(p.months_as_customer AS INTEGER) < 36 THEN '1-3 years'
      WHEN CAST(p.months_as_customer AS INTEGER) < 60 THEN '3-5 years'
      WHEN CAST(p.months_as_customer AS INTEGER) < 120 THEN '5-10 years'
      ELSE '10+ years'
    END AS customer_tenure
  FROM
    fact_claims c
    JOIN dim_policies p
  ON c.policy_number = p.policy_number
)
, cohort_summary AS (
  SELECT
    customer_tenure
    , COUNT(*) AS policies
    , ROUND(AVG(fraud_reported) * 100, 1) AS fraud_rate_pct
    , ROUND(AVG(total_claim_amount), 0) AS avg_claim
    , ROUND(AVG(policy_annual_premium), 0) AS avg_premium
  FROM
    policy_age_cohorts
  GROUP BY
    customer_tenure
)
SELECT
  customer_tenure
  , policies
  , fraud_rate_pct
  , avg_claim
  , avg_premium
  , RANK() OVER (
    ORDER BY
      fraud_rate_pct DESC
  ) AS fraud_risk_rank
FROM
  cohort_summary
ORDER BY
  fraud_risk_rank;