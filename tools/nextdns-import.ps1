# Aegis -> NextDNS Importer
# Usage: .\nextdns-import.ps1 -ApiKey YOUR_API_KEY -ConfigId YOUR_CONFIG_ID [-Grade standard]
#
# Get your API key: https://my.nextdns.io/account
# Get your Config ID: It's in your NextDNS URL (my.nextdns.io/abc123/setup)

param(
    [Parameter(Mandatory=$true)]
    [string]$ApiKey,

    [Parameter(Mandatory=$true)]
    [string]$ConfigId,

    [ValidateSet("core", "standard", "strict", "maximum")]
    [string]$Grade = "standard"
)

$ErrorActionPreference = "Stop"

$BlocklistUrl = "https://raw.githubusercontent.com/0xDarkMatter/aegis-blocklist/master/grades/$Grade.txt"
$ApiUrl = "https://api.nextdns.io/profiles/$ConfigId/denylist"

Write-Host "Aegis -> NextDNS Importer" -ForegroundColor Cyan
Write-Host "========================" -ForegroundColor Cyan
Write-Host "Config: $ConfigId"
Write-Host "Grade: $Grade"
Write-Host ""

# Fetch blocklist
Write-Host "Fetching blocklist..."
$response = Invoke-WebRequest -Uri $BlocklistUrl -UseBasicParsing
$domains = $response.Content -split "`n" | Where-Object {
    $_ -and -not $_.StartsWith("#") -and $_.Contains(".")
} | ForEach-Object { $_.Trim() }
$total = $domains.Count
Write-Host "Found $total domains"
Write-Host ""

$added = 0
$skipped = 0
$errors = 0
$count = 0
$failedDomains = @()

$headers = @{
    "X-Api-Key" = $ApiKey
    "Content-Type" = "application/json"
}

Write-Host "Importing..."
foreach ($domain in $domains) {
    if ([string]::IsNullOrWhiteSpace($domain)) { continue }
    $count++

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
            if ($statusCode -eq 409) {
                $skipped++
                $success = $true
                break
            }
            elseif ($statusCode -eq 429) {
                # Rate limited - wait longer
                Start-Sleep -Milliseconds ($attempt * 2000)
            }
            else {
                # Other error - brief retry
                Start-Sleep -Milliseconds 500
            }
        }
    }

    if (-not $success) {
        $errors++
        $failedDomains += $domain
    }

    # Progress every 50 domains
    if ($count % 50 -eq 0) {
        Write-Host "  $count/$total - Added: $added, Skipped: $skipped, Errors: $errors"
    }

    # Rate limit protection (250ms between requests)
    Start-Sleep -Milliseconds 250
}

Write-Host ""
Write-Host "========================" -ForegroundColor Cyan
Write-Host "Complete!" -ForegroundColor Green
Write-Host "  Added: $added"
Write-Host "  Skipped (duplicates): $skipped"
Write-Host "  Errors: $errors"

if ($errors -gt 0 -and $failedDomains.Count -gt 0) {
    Write-Host ""
    Write-Host "Failed domains (first 10):" -ForegroundColor Yellow
    $failedDomains | Select-Object -First 10 | ForEach-Object { Write-Host "  $_" }
}
