# SOC-Home-Lab

SOC Level 1 home lab focused on host hardening and authentication monitoring.

This project simulates part of the daily workflow of a junior SOC analyst:
detection of suspicious authentication activity, basic triage, correlation with host defenses, and documentation of findings.

## Objective

Build a practical lab to:

- Harden an Ubuntu Server
- Detect SSH brute-force and authentication anomalies
- Visualize security events with Grafana + Loki
- Correlate detections with Fail2Ban containment
- Document analysis in an incident-style format

## Tech Stack

- Ubuntu Server
- UFW
- Fail2Ban
- Grafana
- Loki
- Promtail

## Architecture

```text
Windows Host
    |
    | SSH failed/successful attempts
    v
Ubuntu Server
    |-- UFW (firewall)
    |-- Fail2Ban (auto-ban)
    |-- auth.log
    |-- Promtail  -->  Loki  -->  Grafana Dashboard
