
#!/bin/bash

AUTH_LOG="/var/log/auth.log"

echo "===================================="
echo " AUTH LOG SECURITY SUMMARY"
echo "===================================="

echo
echo "[*] Failed password attempts:"
grep -c "Failed password" "$AUTH_LOG" 2>/dev/null || echo 0

echo
echo "[*] Authentication failures:"
grep -c "authentication failure" "$AUTH_LOG" 2>/dev/null || echo 0

echo
echo "[*] Invalid user attempts:"
grep -c "Invalid user\|illegal user" "$AUTH_LOG" 2>/dev/null || echo 0

echo
echo "[*] Top source IPs:"
grep -E "Failed password|Authentication failure" "$AUTH_LOG" \
  | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' \
  | sort | uniq -c | sort -nr | head -10

echo
echo "[*] Recent suspicious lines:"
grep -E "Failed password|Authentication failure|illegal user|Invalid user" "$AUTH_LOG" \
  | tail -n 10

echo
echo "===================================="
