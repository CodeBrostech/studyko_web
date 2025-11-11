# Firebase Service Account to Base64 Converter
# This script converts your Firebase service account JSON file to base64
# Use this for secure deployment to Vercel

Write-Host "=== Firebase Service Account to Base64 Converter ===" -ForegroundColor Cyan
Write-Host ""

$jsonFile = "studypomodoro-f9da1-firebase-adminsdk-fbsvc-81a82502d0.json"

if (-Not (Test-Path $jsonFile)) {
    Write-Host "Error: $jsonFile not found!" -ForegroundColor Red
    Write-Host "Please ensure your service account JSON file is in the same directory." -ForegroundColor Yellow
    exit 1
}

try {
    $content = Get-Content $jsonFile -Raw
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($content)
    $base64 = [System.Convert]::ToBase64String($bytes)
    
    # Copy to clipboard
    $base64 | Set-Clipboard
    
    Write-Host "✓ Successfully converted to base64!" -ForegroundColor Green
    Write-Host "✓ Base64 string has been copied to your clipboard!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "1. Go to Vercel Dashboard → Your Project → Settings → Environment Variables" -ForegroundColor White
    Write-Host "2. Add a new variable:" -ForegroundColor White
    Write-Host "   Name: FIREBASE_SERVICE_ACCOUNT_KEY" -ForegroundColor Cyan
    Write-Host "   Value: [Paste from clipboard - Ctrl+V]" -ForegroundColor Cyan
    Write-Host "3. Select all environments (Production, Preview, Development)" -ForegroundColor White
    Write-Host "4. Save and redeploy your application" -ForegroundColor White
    Write-Host ""
    Write-Host "Base64 length: $($base64.Length) characters" -ForegroundColor Gray
    
} catch {
    Write-Host "Error: Failed to convert file" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}
