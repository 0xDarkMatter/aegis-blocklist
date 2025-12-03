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
FAILED_DOMAINS=""

echo "Importing..."
while IFS= read -r domain; do
    [ -z "$domain" ] && continue

    # Skip entries without dots (bare TLDs like 'buzz')
    if ! echo "$domain" | grep -q '\.'; then
        continue
    fi

    COUNT=$((COUNT + 1))

    # Try up to 3 times with backoff
    SUCCESS=0
    for attempt in 1 2 3; do
        RESPONSE=$(curl -s -w "\n%{http_code}" -X POST "$API_URL" \
            -H "X-Api-Key: $API_KEY" \
            -H "Content-Type: application/json" \
            -d "{\"id\":\"$domain\",\"active\":true}")

        HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
        BODY=$(echo "$RESPONSE" | sed '$d')

        if [ "$HTTP_CODE" = "200" ] || [ "$HTTP_CODE" = "201" ]; then
            # Check if body contains duplicate error
            if echo "$BODY" | grep -q '"code":"duplicate"'; then
                SKIPPED=$((SKIPPED + 1))
            else
                ADDED=$((ADDED + 1))
            fi
            SUCCESS=1
            break
        elif [ "$HTTP_CODE" = "429" ]; then
            # Rate limited - wait longer and retry
            sleep $((attempt * 2))
        else
            # Other error - retry once
            sleep 0.5
        fi
    done

    if [ "$SUCCESS" = "0" ]; then
        ERRORS=$((ERRORS + 1))
        FAILED_DOMAINS="${FAILED_DOMAINS}${domain}\n"
    fi

    # Progress every 50 domains
    if [ $((COUNT % 50)) -eq 0 ]; then
        echo "  ${COUNT}/${TOTAL} - Added: ${ADDED}, Skipped: ${SKIPPED}, Errors: ${ERRORS}"
    fi

    # Rate limit protection (250ms between requests)
    sleep 0.25
done <<< "$DOMAINS"

echo ""
echo "========================"
echo "Complete!"
echo "  Added: ${ADDED}"
echo "  Skipped (duplicates): ${SKIPPED}"
echo "  Errors: ${ERRORS}"

if [ "$ERRORS" -gt 0 ] && [ -n "$FAILED_DOMAINS" ]; then
    echo ""
    echo "Failed domains (first 10):"
    echo -e "$FAILED_DOMAINS" | head -10
fi
