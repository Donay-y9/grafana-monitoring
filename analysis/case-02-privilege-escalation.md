# Case 02 - Privilege Escalation Activity (su/sudo)

## Case Information
- Role simulated: SOC L1
- Environment: Ubuntu Server home lab
- Data sources: Grafana/Loki, auth.log
- Status: Reviewed / Expected lab activity

## Summary
Privilege-related authentication events were observed involving su and session activity. These events appeared in the Grafana dashboard under Privilege Escalation metrics and in the authentication logs.

## Evidence
- Logs containing su activity
- Failed SU events
- session opened events
- Dashboard KPI for Privilege Escalation showed activity
- Events associated with local terminal activity such as tty1

## Analysis
This activity represents attempts to switch user context or open privileged sessions.

In a SOC review, privilege events are important because:

1. Privilege escalation can indicate abuse of access
2. Failed su attempts may show unauthorized privilege seeking
3. Successful privileged sessions should be validated against expected admin activity

In this lab, the activity was generated intentionally for testing and monitoring validation. No unexpected external attacker behavior was confirmed for this case.

## Why it matters for SOC L1
SOC analysts commonly review privilege events to answer:

- Who tried to become root or admin
- Was the attempt successful
- Was it expected administrative activity
- Did it happen after suspicious login activity

## MITRE ATT&CK Mapping
- Related technique context: Valid Accounts
- ID: T1078
- Evidence: Local privilege switching and authentication activity through su/sudo related events

This case supports monitoring of privileged account usage and local elevation attempts as part of host authentication review.

## Conclusion
Privilege escalation related events were successfully monitored and visualized in the lab. This case shows that the monitoring stack is not limited to failed SSH detection, but also tracks local privilege activity relevant to SOC L1 host security analysis.
