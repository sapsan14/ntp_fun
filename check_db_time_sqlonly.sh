#!/usr/bin/env bash
set -euo pipefail

DB_HOST="ptaeemax001"
DB_USER="PKIadmin"
DB_NAME="ejbca"

WARN_SEC=1
CRIT_SEC=5

hr() {
  echo "------------------------------------------------------------"
}

run_sql() {
  mariadb -h "$DB_HOST" -u "$DB_USER" -p "$DB_NAME" --skip-ssl -N -s -e "$1"
}

echo "# Database Time Health Report (SQL-only)"
echo "- DB Host: $DB_HOST"
echo

hr
echo "## 1. OS vs DB Time Drift"

os_epoch=$(date -u +%s)
db_epoch=$(run_sql "SELECT UNIX_TIMESTAMP(UTC_TIMESTAMP());")

drift=$(( os_epoch - db_epoch ))
abs_drift=${drift#-}

echo "- OS UTC epoch: $os_epoch"
echo "- DB UTC epoch: $db_epoch"
echo "- Drift (seconds): $drift"
echo "- Absolute drift: $abs_drift"

if (( abs_drift > CRIT_SEC )); then
  echo "❌ CRITICAL: DB clock differs by > ${CRIT_SEC}s"
elif (( abs_drift > WARN_SEC )); then
  echo "⚠️ WARNING: DB clock differs by > ${WARN_SEC}s"
else
  echo "✅ OK: DB time matches OS within ${WARN_SEC}s"
fi

hr
echo "## 2. Database Time Zone Settings"

run_sql "SELECT @@system_time_zone, @@time_zone;"

hr
echo "## 3. Future Timestamp Check (EJBCA)"

echo "Certificates with timeCreated in the future:"
run_sql "
SELECT COUNT(*)
FROM CertificateData
WHERE timeCreated > UNIX_TIMESTAMP()*1000;
"

echo
echo "Latest certificate issuance time:"
run_sql "
SELECT FROM_UNIXTIME(MAX(timeCreated)/1000)
FROM CertificateData;
"

hr
echo "## 4. Audit Log Sanity"

echo "Latest audit record timestamp:"
run_sql "
SELECT FROM_UNIXTIME(MAX(timeStamp)/1000)
FROM AuditRecordData;
"

hr
echo "## 5. Quick Summary"

echo "If drift is small and no future timestamps exist → DB is handling NTP changes fine."
echo "If drift is large or future rows exist → investigate time jump or DB host clock."
