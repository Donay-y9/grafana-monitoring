# Case 01 - SSH Brute Force / Password Guessing

## Case Information
- Role simulated: SOC L1
- Environment: Ubuntu Server home lab
- Data sources: Grafana/Loki, auth.log, Fail2Ban, UFW
- Status: Contained

## Summary
Multiple failed SSH authentication attempts were observed against the lab server. The activity came mainly from internal lab IPs and included attempts against valid and invalid usernames. The events were visible in Grafana and correlated with Fail2Ban containment.

## Evidence
- Repeated Authentication failure events in Grafana logs
- Source IPs observed: 192.168.1.35 and 192.168.1.34
- Target usernames included donay and invalid users such as aada
- Dashboard KPI showed elevated Failed Authentication Attempts
- Fail2Ban banned IP 192.168.1.35

## Analysis
The observed pattern is consistent with SSH password guessing / brute-force behavior:

1. Multiple authentication failures in a short time window
2. Repeated attempts from the same source IP
3. Attempts against both existing and non-existing accounts
4. No confirmed successful unauthorized login in this case

Although the activity was generated for lab testing, the detection and response flow matches what a SOC L1 analyst would review during triage.

## Containment
Fail2Ban jail sshd automatically banned the source IP after repeated failed authentication attempts.

Validation commands:

sudo fail2ban-client status sshd

sudo fail2ban-client set sshd unbanip 192.168.1.35

UFW is part of the host hardening baseline. In this lab it restricts inbound exposure and limits SSH access on port 2222. While UFW provides the firewall foundation, the automated containment action for this case was performed by Fail2Ban.

## MITRE ATT&CK Mapping
- Technique: Brute Force
- ID: T1110
- Tactic: Credential Access
- Evidence: Multiple failed SSH authentication attempts from the same source IP against valid and invalid accounts

This activity maps to MITRE ATT&CK T1110 - Brute Force because repeated authentication failures were observed from the same origin in a short period, consistent with password guessing behavior.

## Conclusion
Suspicious SSH authentication activity was detected through log monitoring in Grafana/Loki and contained using Fail2Ban. This case demonstrates a basic SOC L1 workflow: detect failed authentication events, identify source IP and targeted accounts, validate automated containment, and document findings with ATT&CK mapping.
