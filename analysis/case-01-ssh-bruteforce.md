# Case 01 - SSH Brute Force / Password Guessing

## Case Information
- Role simulated: SOC L1
- Environment: Ubuntu Server home lab
- Data sources: Grafana/Loki, `/var/log/auth.log`, Fail2Ban
- Status: Contained

## Summary
Multiple failed SSH authentication attempts were observed against the lab server. The activity came mainly from internal lab IPs and included attempts against valid and invalid usernames. Fail2Ban later banned one of the source IPs.

## Evidence
- Repeated `Authentication failure` events in Grafana logs
- Source IPs observed:
  - `192.168.1.35`
  - `192.168.1.34`
- Target usernames included:
  - `donay`
  - invalid/illegal users such as `aada`
- Dashboard KPI showed elevated Failed Authentication Attempts
- Fail2Ban status showed:
  - Total failed attempts
  - Banned IP: `192.168.1.35`

## Analysis
The pattern is consistent with SSH password guessing / brute-force behavior:

1. Multiple authentication failures in a short period
2. Same source IP repeating attempts
3. Attempts against both existing and non-existing accounts
4. No confirmed successful unauthorized login in this case

Although the activity was generated for lab testing, the detection and response flow matches what a SOC L1 would review in a real alert.

## Containment
Fail2Ban jail `sshd` banned the source IP after repeated failures.

Validation commands:
```bash
sudo fail2ban-client status sshd
sudo fail2ban-client set sshd unbanip 192.168.1.35
