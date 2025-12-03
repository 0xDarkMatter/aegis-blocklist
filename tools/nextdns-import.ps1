# Aegis -> NextDNS Importer
# Usage: .\nextdns-import.ps1 [-ApiKey KEY] [-ConfigId ID] [-Grade standard]
#
# If parameters not provided, script will prompt interactively.
# Get your API key: https://my.nextdns.io/account
# Get your Config ID: my.nextdns.io -> select profile -> Setup tab -> ID field

param(
    [string]$ApiKey,
    [string]$ConfigId,
    [ValidateSet("core", "standard", "strict", "maximum")]
    [string]$Grade
)

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Aegis -> NextDNS Importer" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Interactive prompts if not provided
if (-not $ConfigId) {
    Write-Host "CONFIG ID" -ForegroundColor Yellow
    Write-Host "  Location: NextDNS -> Select profile -> Setup tab -> ID" -ForegroundColor Gray
    Write-Host "  Format: 6 characters (e.g., abc123)" -ForegroundColor Gray
    $ConfigId = Read-Host "Enter Config ID"
}

if (-not $ApiKey) {
    Write-Host ""
    Write-Host "API KEY" -ForegroundColor Yellow
    Write-Host "  Location: my.nextdns.io/account -> API section" -ForegroundColor Gray
    Write-Host "  Format: 40 characters (long string)" -ForegroundColor Gray
    $ApiKey = Read-Host "Enter API Key"
}

if (-not $Grade) {
    Write-Host ""
    Write-Host "Blocking Grades:" -ForegroundColor Gray
    Write-Host "  1) core     - Essential safety (self-harm, gore, predators)" -ForegroundColor Gray
    Write-Host "  2) standard - Recommended (core + VPN bypass, gambling, AI adult)" -ForegroundColor Gray
    Write-Host "  3) strict   - Enhanced (standard + weapons, crypto scams)" -ForegroundColor Gray
    Write-Host "  4) maximum  - Everything" -ForegroundColor Gray
    Write-Host ""
    $choice = Read-Host "Select grade [1-4, default=2]"
    $Grade = switch ($choice) {
        "1" { "core" }
        "3" { "strict" }
        "4" { "maximum" }
        default { "standard" }
    }
}

Write-Host ""

$ErrorActionPreference = "Stop"

$BlocklistUrl = "https://raw.githubusercontent.com/0xDarkMatter/aegis-blocklist/master/grades/$Grade.txt"
$ApiUrl = "https://api.nextdns.io/profiles/$ConfigId/denylist"

Write-Host "Config: $ConfigId"
Write-Host "Grade: $Grade"
Write-Host ""

$headers = @{
    "X-Api-Key" = $ApiKey
    "Content-Type" = "application/json"
}

# Fetch existing denylist from NextDNS
Write-Host "Fetching existing denylist..."
$existingResponse = Invoke-RestMethod -Uri $ApiUrl -Headers $headers -Method Get
$existing = @{}
foreach ($item in $existingResponse.data) {
    $existing[$item.id] = $true
}
Write-Host "Found $($existing.Count) existing domains"

# Fetch blocklist
Write-Host "Fetching Aegis blocklist..."
$response = Invoke-WebRequest -Uri $BlocklistUrl -UseBasicParsing
$blocklist = $response.Content -split "`n" | Where-Object {
    $_ -and -not $_.StartsWith("#") -and $_.Contains(".")
} | ForEach-Object { $_.Trim() }
Write-Host "Found $($blocklist.Count) domains in blocklist"

# Find domains to add (in blocklist but not in existing)
$toAdd = $blocklist | Where-Object { -not $existing.ContainsKey($_) }
$toAddCount = @($toAdd).Count
$alreadyExisted = $blocklist.Count - $toAddCount

Write-Host ""
Write-Host "Domains to add: $toAddCount"

if ($toAddCount -eq 0) {
    Write-Host ""
    Write-Host "========================" -ForegroundColor Cyan
    Write-Host "Already up to date! No new domains to add." -ForegroundColor Green
    exit 0
}

Write-Host ""
$added = 0
$errors = 0
$count = 0
$failedDomains = @()

foreach ($domain in $toAdd) {
    if ([string]::IsNullOrWhiteSpace($domain)) { continue }
    $count++

    # Progress bar
    $pct = [math]::Round(($count / $toAddCount) * 100)
    Write-Progress -Activity "Importing domains to NextDNS" -Status "$count of $toAddCount ($pct%)" -PercentComplete $pct

    $body = @{ id = $domain; active = $true } | ConvertTo-Json
    $success = $false

    # Try up to 3 times with backoff
    for ($attempt = 1; $attempt -le 3; $attempt++) {
        try {
            $null = Invoke-RestMethod -Uri $ApiUrl -Method Post -Headers $headers -Body $body -ErrorAction Stop
            $added++
            $success = $true
            break
        }
        catch {
            $statusCode = $_.Exception.Response.StatusCode.value__
            if ($statusCode -eq 429) {
                Start-Sleep -Milliseconds ($attempt * 2000)
            }
            else {
                Start-Sleep -Milliseconds 500
            }
        }
    }

    if (-not $success) {
        $errors++
        $failedDomains += $domain
    }

    # Rate limit protection (200ms between requests)
    Start-Sleep -Milliseconds 200
}

Write-Progress -Activity "Importing domains to NextDNS" -Completed

Write-Host ""
Write-Host "========================" -ForegroundColor Cyan
Write-Host "Complete!" -ForegroundColor Green
Write-Host "  Already existed: $alreadyExisted"
Write-Host "  Added: $added"
Write-Host "  Errors: $errors"

if ($errors -gt 0 -and $failedDomains.Count -gt 0) {
    Write-Host ""
    Write-Host "Failed domains (first 10):" -ForegroundColor Yellow
    $failedDomains | Select-Object -First 10 | ForEach-Object { Write-Host "  $_" }
}
