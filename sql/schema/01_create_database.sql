-- Insurance Claims Intelligence Platform
-- SQL Schema — SQLite Database
-- Purpose: Demonstrate SQL proficiency for data analyst portfolio


-- Core claims fact table
CREATE TABLE
IF
  NOT EXISTS fact_claims (
    policy_number INTEGER PRIMARY KEY
    , total_claim_amount REAL
    , injury_claim REAL
    , property_claim REAL
    , vehicle_claim REAL
    , incident_date TEXT
    , incident_type TEXT
    , incident_severity TEXT
    , incident_state TEXT
    , incident_city TEXT
    , incident_hour INTEGER
    , number_of_vehicles INTEGER
    , bodily_injuries INTEGER
    , witnesses INTEGER
    , property_damage TEXT
    , police_report TEXT
    , authorities_contacted TEXT
    , fraud_reported INTEGER
    , anomaly_score REAL
    , fraud_probability REAL
    , region TEXT
  );

  -- Policy dimension table
  CREATE TABLE
  IF
    NOT EXISTS dim_policies (
      policy_number INTEGER PRIMARY KEY
      , policy_bind_date TEXT
      , policy_state TEXT
      , policy_csl TEXT
      , policy_deductible INTEGER
      , policy_annual_premium REAL
      , umbrella_limit INTEGER
      , insured_zip INTEGER
      , insured_sex TEXT
      , insured_education TEXT
      , insured_occupation TEXT
      , insured_relationship TEXT
      , months_as_customer INTEGER
      , age INTEGER
      , capital_gains INTEGER
      , capital_loss INTEGER
    );

    -- Vehicle dimension table
    CREATE TABLE
    IF
      NOT EXISTS dim_vehicles (
        policy_number INTEGER PRIMARY KEY
        , auto_make TEXT
        , auto_model TEXT
        , auto_year INTEGER
        , vehicle_age INTEGER
      );