-- Suspicious Claims Queue
-- Business Question: Which claims should investigators review first?
-- Ranked by fraud_probability from the ML model


SELECT
  c.policy_number
  , c.total_claim_amount
  , p.policy_annual_premium
  , ROUND(
    CAST(c.total_claim_amount AS REAL) / p.policy_annual_premium
    , 1
  ) AS claim_to_premium_ratio
  , c.incident_type
  , c.incident_severity
  , c.bodily_injuries
  , c.witnesses
  , c.police_report
  , c.number_of_vehicles
  , c.region
  , ROUND(c.fraud_probability * 100, 1) AS fraud_probability_pct
  , ROUND(c.anomaly_score, 3) AS anomaly_score
  , c.fraud_reported AS known_fraud_label
  , -- Priority tier for investigation routing
    CASE
    WHEN c.fraud_probability >= 0.75 THEN 'P1 — Investigate immediately'
    WHEN c.fraud_probability >= 0.55 THEN 'P2 — Review within 48hrs'
    WHEN c.fraud_probability >= 0.40 THEN 'P3 — Monitor'
    ELSE 'P4 — Clear'
  END AS investigation_priority
FROM
  fact_claims c
  JOIN dim_policies p
ON c.policy_number = p.policy_number
WHERE
  c.fraud_probability >= 0.40
ORDER BY
  c.fraud_probability DESC;