-- Fraud Pattern Analysis
-- Business Question: What incident patterns correlate with fraud?
-- Uses window functions to compare each type to portfolio average


WITH incident_fraud_rates AS (
  SELECT
    incident_type
    , incident_severity
    , COUNT(*) AS claim_count
    , SUM(fraud_reported) AS fraud_count
    , ROUND(AVG(fraud_reported) * 100, 1) AS fraud_rate_pct
    , ROUND(AVG(total_claim_amount), 0) AS avg_claim
    , ROUND(AVG(bodily_injuries), 2) AS avg_injuries
    , ROUND(AVG(witnesses), 2) AS avg_witnesses
  FROM
    fact_claims
  GROUP BY
    incident_type
    , incident_severity
)
, with_portfolio_avg AS (
  SELECT
    *
    , ROUND(AVG(fraud_rate_pct) OVER (), 1) AS portfolio_avg_fraud_rate
    , ROUND(AVG(avg_claim) OVER (), 0) AS portfolio_avg_claim
    , fraud_rate_pct - AVG(fraud_rate_pct) OVER () AS fraud_rate_vs_avg
  FROM
    incident_fraud_rates
)
SELECT
  incident_type
  , incident_severity
  , claim_count
  , fraud_rate_pct
  , portfolio_avg_fraud_rate
  , ROUND(fraud_rate_vs_avg, 1) AS pct_pts_above_avg
  , avg_claim
  , avg_injuries
  , avg_witnesses
FROM
  with_portfolio_avg
ORDER BY
  fraud_rate_vs_avg DESC;