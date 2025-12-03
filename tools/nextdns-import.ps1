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
$domains = $response.Content -split "`n" | Where-Object { $_ -and -not $_.StartsWith("#") } | ForEach-Object { $_.Trim() }
$total = $domains.Count
Write-Host "Found $total domains"
Write-Host ""

$added = 0
$skipped = 0
$errors = 0
$count = 0

$headers = @{
    "X-Api-Key" = $ApiKey
    "Content-Type" = "application/json"
}

Write-Host "Importing..."
foreach ($domain in $domains) {
    if ([string]::IsNullOrWhiteSpace($domain)) { continue }
    $count++

    $body = @{ id = $domain; active = $true } | ConvertTo-Json

    try {
        $null = Invoke-RestMethod -Uri $ApiUrl -Method Post -Headers $headers -Body $body
        $added++
    }
    catch {
        if ($_.Exception.Response.StatusCode -eq 409) {
            $skipped++
        }
        else {
            $errors++
        }
    }

    # Progress every 50 domains
    if ($count % 50 -eq 0) {
        Write-Host "  $count/$total - Added: $added, Skipped: $skipped, Errors: $errors"
    }

    # Rate limit protection
    Start-Sleep -Milliseconds 150
}

Write-Host ""
Write-Host "========================" -ForegroundColor Cyan
Write-Host "Complete!" -ForegroundColor Green
Write-Host "  Added: $added"
Write-Host "  Skipped (duplicates): $skipped"
Write-Host "  Errors: $errors"
