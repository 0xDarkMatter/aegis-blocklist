#!/bin/bash
# Aegis → NextDNS Importer
# Usage: ./nextdns-import.sh YOUR_API_KEY YOUR_CONFIG_ID [grade]
#
# Get your API key: https://my.nextdns.io/account
# Get your Config ID: It's in your NextDNS URL (my.nextdns.io/abc123/setup)

set -e

API_KEY="${1:?Usage: $0 API_KEY CONFIG_ID [grade]}"
CONFIG_ID="${2:?Usage: $0 API_KEY CONFIG_ID [grade]}"
GRADE="${3:-standard}"

BLOCKLIST_URL="https://raw.githubusercontent.com/0xDarkMatter/aegis-blocklist/master/grades/${GRADE}.txt"
API_URL="https://api.nextdns.io/profiles/${CONFIG_ID}/denylist"

echo "Aegis → NextDNS Importer"
echo "========================"
echo "Config: ${CONFIG_ID}"
echo "Grade: ${GRADE}"
echo ""

# Fetch blocklist
echo "Fetching blocklist..."
DOMAINS=$(curl -sL "$BLOCKLIST_URL" | grep -v '^#' | grep -v '^$')
TOTAL=$(echo "$DOMAINS" | wc -l | tr -d ' ')
echo "Found ${TOTAL} domains"
echo ""

ADDED=0
SKIPPED=0
ERRORS=0
COUNT=0

echo "Importing..."
while IFS= read -r domain; do
    [ -z "$domain" ] && continue
    COUNT=$((COUNT + 1))

    RESPONSE=$(curl -s -w "\n%{http_code}" -X POST "$API_URL" \
        -H "X-Api-Key: $API_KEY" \
        -H "Content-Type: application/json" \
        -d "{\"id\":\"$domain\",\"active\":true}")

    HTTP_CODE=$(echo "$RESPONSE" | tail -n1)

    if [ "$HTTP_CODE" = "200" ] || [ "$HTTP_CODE" = "201" ]; then
        ADDED=$((ADDED + 1))
    elif [ "$HTTP_CODE" = "409" ]; then
        SKIPPED=$((SKIPPED + 1))
    else
        ERRORS=$((ERRORS + 1))
    fi

    # Progress every 50 domains
    if [ $((COUNT % 50)) -eq 0 ]; then
        echo "  ${COUNT}/${TOTAL} - Added: ${ADDED}, Skipped: ${SKIPPED}, Errors: ${ERRORS}"
    fi

    # Rate limit protection
    sleep 0.15
done <<< "$DOMAINS"

echo ""
echo "========================"
echo "Complete!"
echo "  Added: ${ADDED}"
echo "  Skipped (duplicates): ${SKIPPED}"
echo "  Errors: ${ERRORS}"
