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

# Fetch existing denylist from NextDNS
echo "Fetching existing denylist..."
EXISTING=$(curl -sL "$API_URL" -H "X-Api-Key: $API_KEY" | grep -o '"id":"[^"]*"' | cut -d'"' -f4 | sort)
EXISTING_COUNT=$(echo "$EXISTING" | grep -c . || echo 0)
echo "Found ${EXISTING_COUNT} existing domains"

# Fetch blocklist
echo "Fetching Aegis blocklist..."
BLOCKLIST=$(curl -sL "$BLOCKLIST_URL" | grep -v '^#' | grep -v '^$' | grep '\.' | sort)
BLOCKLIST_COUNT=$(echo "$BLOCKLIST" | grep -c . || echo 0)
echo "Found ${BLOCKLIST_COUNT} domains in blocklist"

# Find domains to add (in blocklist but not in existing)
TO_ADD=$(comm -23 <(echo "$BLOCKLIST") <(echo "$EXISTING"))
TO_ADD_COUNT=$(echo "$TO_ADD" | grep -c . || echo 0)

echo ""
echo "Domains to add: ${TO_ADD_COUNT}"

if [ "$TO_ADD_COUNT" -eq 0 ]; then
    echo ""
    echo "========================"
    echo "Already up to date! No new domains to add."
    exit 0
fi

echo ""
ADDED=0
ERRORS=0
COUNT=0
FAILED_DOMAINS=""

echo "Importing ${TO_ADD_COUNT} new domains..."
while IFS= read -r domain; do
    [ -z "$domain" ] && continue
    COUNT=$((COUNT + 1))

    # Try up to 3 times with backoff
    SUCCESS=0
    for attempt in 1 2 3; do
        RESPONSE=$(curl -s -w "\n%{http_code}" -X POST "$API_URL" \
            -H "X-Api-Key: $API_KEY" \
            -H "Content-Type: application/json" \
            -d "{\"id\":\"$domain\",\"active\":true}")

        HTTP_CODE=$(echo "$RESPONSE" | tail -n1)

        if [ "$HTTP_CODE" = "200" ] || [ "$HTTP_CODE" = "201" ]; then
            ADDED=$((ADDED + 1))
            SUCCESS=1
            break
        elif [ "$HTTP_CODE" = "429" ]; then
            sleep $((attempt * 2))
        else
            sleep 0.5
        fi
    done

    if [ "$SUCCESS" = "0" ]; then
        ERRORS=$((ERRORS + 1))
        FAILED_DOMAINS="${FAILED_DOMAINS}${domain}\n"
    fi

    # Progress every 25 domains
    if [ $((COUNT % 25)) -eq 0 ]; then
        echo "  ${COUNT}/${TO_ADD_COUNT} - Added: ${ADDED}, Errors: ${ERRORS}"
    fi

    # Rate limit protection (200ms between requests)
    sleep 0.2
done <<< "$TO_ADD"

echo ""
echo "========================"
echo "Complete!"
echo "  Already existed: $((BLOCKLIST_COUNT - TO_ADD_COUNT))"
echo "  Added: ${ADDED}"
echo "  Errors: ${ERRORS}"

if [ "$ERRORS" -gt 0 ] && [ -n "$FAILED_DOMAINS" ]; then
    echo ""
    echo "Failed domains (first 10):"
    echo -e "$FAILED_DOMAINS" | head -10
fi
