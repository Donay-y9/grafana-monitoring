# Hardening Notes

## Overview
This file documents the basic hardening and security controls implemented in the Ubuntu SOC home lab.

## SSH Hardening
- SSH service enabled and monitored
- SSH moved to port 2222
- Authentication events collected from auth.log
- Repeated failed logins handled by Fail2Ban

Reason:
Changing the default SSH port and monitoring authentication reduces exposure and improves detection of password guessing activity.

## UFW Firewall
Status: active

Default policy:
- Incoming: deny
- Outgoing: allow

Observed rules:
- 2222/tcp LIMIT IN  # SSH with rate limit
- 80/tcp ALLOW IN    # HTTP
- 443/tcp ALLOW IN   # HTTPS

Useful command:
sudo ufw status verbose

Purpose:
UFW provides the host firewall baseline and restricts inbound network exposure.

## Fail2Ban
Status: active

Jail:
- sshd

Purpose:
Automatically ban source IPs after repeated SSH authentication failures.

Useful commands:
sudo fail2ban-client status
sudo fail2ban-client status sshd
sudo fail2ban-client set sshd unbanip <IP>

Lab observation:
IP 192.168.1.35 was banned after multiple failed SSH attempts and later unbanned for continued testing.

## Monitoring Stack
- Promtail: log shipping
- Loki: log storage
- Grafana: visualization and alerting

Monitored events include:
- Failed authentication attempts
- Successful SSH logins
- Privilege escalation activity such as su/sudo
- Source IP activity

## Security Design Summary
1. Reduce exposure with UFW
2. Detect repeated SSH failures with logs and Grafana
3. Contain abusive IPs with Fail2Ban
4. Document findings for SOC-style analysis
