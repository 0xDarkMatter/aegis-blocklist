#!/bin/bash
# Aegis → NextDNS Importer
# Usage: ./nextdns-import.sh [API_KEY] [CONFIG_ID] [grade]
#
# If parameters not provided, script will prompt interactively.
# Get your API key: https://my.nextdns.io/account
# Get your Config ID: my.nextdns.io -> select profile -> Setup tab -> ID field

set -e

echo ""
echo "========================================"
echo "  Aegis → NextDNS Importer"
echo "========================================"
echo ""

# Interactive prompts if not provided
if [ -z "$1" ]; then
    echo "CONFIG ID"
    echo "  Location: NextDNS -> Select profile -> Setup tab -> ID"
    echo "  Format: 6 characters (e.g., abc123)"
    read -p "Enter Config ID: " CONFIG_ID

    echo ""
    echo "API KEY"
    echo "  Location: my.nextdns.io/account -> API section"
    echo "  Format: 40 characters (long string)"
    read -p "Enter API Key: " API_KEY
else
    API_KEY="$1"
    CONFIG_ID="$2"
fi

if [ -z "$3" ] && [ -z "$1" ]; then
    echo ""
    echo "Blocking Grades:"
    echo "  1) core     - Essential safety (self-harm, gore, predators)"
    echo "  2) standard - Recommended (core + VPN bypass, gambling, AI adult)"
    echo "  3) strict   - Enhanced (standard + weapons, crypto scams)"
    echo "  4) maximum  - Everything"
    echo ""
    read -p "Select grade [1-4, default=2]: " choice
    case "$choice" in
        1) GRADE="core" ;;
        3) GRADE="strict" ;;
        4) GRADE="maximum" ;;
        *) GRADE="standard" ;;
    esac
else
    GRADE="${3:-standard}"
fi

echo ""

BLOCKLIST_URL="https://raw.githubusercontent.com/0xDarkMatter/aegis-blocklist/master/grades/${GRADE}.txt"
API_URL="https://api.nextdns.io/profiles/${CONFIG_ID}/denylist"

echo "Config: ${CONFIG_ID}"
echo "Grade: ${GRADE}"
echo ""

# Fetch existing denylist from NextDNS
echo "Fetching existing denylist..."
EXISTING=$(curl -sL "$API_URL" -H "X-Api-Key: $API_KEY" | grep -o '"id":"[^"]*"' | cut -d'"' -f4 | sort)
EXISTING_COUNT=$(printf '%s\n' "$EXISTING" | grep -c .)
echo "Found ${EXISTING_COUNT} existing domains"

# Fetch blocklist
echo "Fetching Aegis blocklist..."
BLOCKLIST=$(curl -sL "$BLOCKLIST_URL" | grep -v '^#' | grep -v '^$' | grep '\.' | sort)
BLOCKLIST_COUNT=$(printf '%s\n' "$BLOCKLIST" | grep -c .)
echo "Found ${BLOCKLIST_COUNT} domains in blocklist"

# Find domains to add (in blocklist but not in existing)
TO_ADD=$(comm -23 <(printf '%s\n' "$BLOCKLIST") <(printf '%s\n' "$EXISTING"))
TO_ADD_COUNT=$(printf '%s' "$TO_ADD" | grep -c . || true)

echo ""
echo "Domains to add: ${TO_ADD_COUNT}"

if [ "${TO_ADD_COUNT}" = "0" ] || [ -z "$TO_ADD" ]; then
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
echo ""
while IFS= read -r domain; do
    [ -z "$domain" ] && continue
    COUNT=$((COUNT + 1))

    # Progress bar (updates in place)
    PCT=$((COUNT * 100 / TO_ADD_COUNT))
    printf "\r  Progress: %3d%% (%d/%d) - Added: %d, Errors: %d" "$PCT" "$COUNT" "$TO_ADD_COUNT" "$ADDED" "$ERRORS"

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

    # Rate limit protection (200ms between requests)
    sleep 0.2
done <<< "$TO_ADD"
echo ""

ALREADY_EXISTED=$((BLOCKLIST_COUNT - TO_ADD_COUNT))

echo ""
echo "========================"
echo "Complete!"
echo "  Already existed: ${ALREADY_EXISTED}"
echo "  Added: ${ADDED}"
echo "  Errors: ${ERRORS}"

if [ "$ERRORS" -gt 0 ] && [ -n "$FAILED_DOMAINS" ]; then
    echo ""
    echo "Failed domains (first 10):"
    echo -e "$FAILED_DOMAINS" | head -10
fi
