#!/usr/bin/env bash
set -euo pipefail

USER="aso"

# Hosts to check
TARGETS=(
  "ptaeecat001.estonia.confidens"
  "ptaeecat002.estonia.confidens"
)

# Thresholds (microseconds)
WARN_OFFSET_US=5000     # 5 ms
CRIT_OFFSET_US=20000    # 20 ms

color_ok="OK"
color_warn="WARNING"
color_crit="CRITICAL"

run_ssh() {
  local target="$1"
  local cmd="$2"

  ssh -o BatchMode=yes \
      -o StrictHostKeyChecking=accept-new \
      "${USER}@${target}" "$cmd"
}

check_host() {
  local TARGET="$1"

  echo "============================================================"
  echo "# NTP Synchronization Report — ${TARGET%%.*}"
  echo "============================================================"
  echo

  # -------------------------------
  # Collect chrony data
  # -------------------------------
  sources=$(run_ssh "$TARGET" "chronyc sources -n -v" 2>/dev/null || true)
  tracking=$(run_ssh "$TARGET" "chronyc tracking" 2>/dev/null || true)
  stats=$(run_ssh "$TARGET" "chronyc sourcestats" 2>/dev/null || true)

  # -------------------------------
  # Extract primary source offset
  # -------------------------------
  primary_line=$(echo "$sources" | awk '/^\^\*/ {print; exit}')

  primary_offset_us=$(echo "$primary_line" | awk '
  {
    for(i=1;i<=NF;i++){
      if($i ~ /us/){
        gsub(/[^0-9\.-]/,"",$i)
        print $i
        exit
      }
    }
  }')

  primary_offset_us=${primary_offset_us:-0}

  # абсолютное значение
  abs_offset_us=$(awk -v x="$primary_offset_us" 'BEGIN {
    if(x<0) x=-x
    print x
  }')

  # -------------------------------
  # Health evaluation
  # -------------------------------
  if awk -v a="$abs_offset_us" -v b="$CRIT_OFFSET_US" 'BEGIN{exit !(a>b)}'; then
    primary_health=$color_crit
  elif awk -v a="$abs_offset_us" -v b="$WARN_OFFSET_US" 'BEGIN{exit !(a>b)}'; then
    primary_health=$color_warn
  else
    primary_health=$color_ok
  fi

  # -------------------------------
  # Markdown Output
  # -------------------------------
  echo "## 1. Summary"
  echo "- Server: \`${TARGET}\`"
  echo "- Primary source marked with \`^*\`"
  echo

  echo "---"
  echo "## 2. Source Status (chronyc sources)"
  if [[ -n "$sources" ]]; then
    echo '```'
    echo "$sources"
    echo '```'
  else
    echo "_No source data collected_"
  fi
  echo

  echo "---"
  echo "## 3. Tracking Status (chronyc tracking)"
  if [[ -n "$tracking" ]]; then
    echo '```'
    echo "$tracking"
    echo '```'
  else
    echo "_No tracking data collected_"
  fi
  echo

  echo "---"
  echo "## 4. Source Statistics (chronyc sourcestats)"
  if [[ -n "$stats" ]]; then
    echo '```'
    echo "$stats"
    echo '```'
  else
