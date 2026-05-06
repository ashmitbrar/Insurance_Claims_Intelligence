# Ontario Insurance Claims Intelligence Platform

## The Business Problem

Ontario's P&C insurance market loses an estimated **$1.3 billion annually** to fraudulent claims.
Two problems keep claims directors awake at night:

1. **They don't know which claims to investigate.** Rules-based systems only catch obvious fraud.
   Sophisticated schemes like staged accidents, phantom passengers, provider collusion rings all slip through.

2. **They don't know where they're losing money geographically.** Loss ratios vary dramatically
   by region. An insurer can be profitable overall while bleeding money in specific postal zones.

## What This Project Builds

| Deliverable               | Business Question Answered                                     |
| ------------------------- | -------------------------------------------------------------- |
| Geographic Loss Ratio Map | Which regions are we losing money in?                          |
| Anomaly Detection Engine  | Which claims warrant investigation before payout?              |
| Fraud Ring Network Graph  | Which providers appear together across flagged claims?         |
| Power BI Dashboard        | Executive dashboard: Loss Ratio · Claims Queue · Provider Risk |

## Tech Stack

| Layer            | Tools                           |
| ---------------- | ------------------------------- |
| Database         | PostgreSQL · SQL                |
| Analysis         | Python · pandas · numpy         |
| Statistics       | scipy                           |
| Machine Learning | scikit-learn — Isolation Forest |
| Network Analysis | NetworkX                        |
| Geography        | folium                          |
| Visualization    | seaborn · matplotlib · plotly   |
| BI Dashboard     | Power BI · DAX                  |
| Version Control  | Git · GitHub                    |

## Dataset

**Source:** Auto Insurance Claims Fraud Detection (Kaggle)
**Records:** 1,000 claims · 40 columns
**Key fields:** premium, claim amounts, incident type, fraud label, ZIP code

Raw data is not committed to this repo. Place the CSV at data/raw/insurance_claims.csv to reproduce.

## Key Findings

## Business Recommendations
