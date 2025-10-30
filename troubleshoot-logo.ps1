# Troubleshoot Logo Rendering

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Logo Troubleshooting Report" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check 1: File exists
Write-Host "1. Checking if logo file exists..." -ForegroundColor Yellow
$logoPath = "public\images\logo\logo.svg"
if (Test-Path $logoPath) {
    $file = Get-Item $logoPath
    Write-Host "   [OK] File exists" -ForegroundColor Green
    Write-Host "   - Name: $($file.Name)" -ForegroundColor White
    Write-Host "   - Size: $($file.Length) bytes" -ForegroundColor White
    Write-Host "   - Modified: $($file.LastWriteTime)" -ForegroundColor White
} else {
    Write-Host "   [ERROR] File not found!" -ForegroundColor Red
    exit
}

Write-Host ""

# Check 2: File content
Write-Host "2. Checking file content..." -ForegroundColor Yellow
$content = Get-Content $logoPath -Raw
if ($content -match '<svg') {
    Write-Host "   [OK] Valid SVG file" -ForegroundColor Green
} else {
    Write-Host "   [ERROR] Not a valid SVG file!" -ForegroundColor Red
}

Write-Host ""

# Check 3: References in code
Write-Host "3. Checking code references..." -ForegroundColor Yellow
$htmlFiles = Get-ChildItem -Path "src" -Filter "*.html" -Recurse
$svgReferences = 0
$pngReferences = 0

foreach ($file in $htmlFiles) {
    $fileContent = Get-Content $file.FullName -Raw
    if ($fileContent -match 'images/logo/logo\.svg') {
        $svgReferences++
    }
    if ($fileContent -match 'images/logo/logo\.png') {
        $pngReferences++
    }
}

Write-Host "   - SVG references: $svgReferences" -ForegroundColor $(if ($svgReferences -gt 0) { "Green" } else { "Red" })
Write-Host "   - PNG references: $pngReferences" -ForegroundColor $(if ($pngReferences -eq 0) { "Green" } else { "Yellow" })

Write-Host ""

# Check 4: Server status
Write-Host "4. Checking server status..." -ForegroundColor Yellow
$port4200 = Get-NetTCPConnection -LocalPort 4200 -ErrorAction SilentlyContinue
if ($port4200) {
    Write-Host "   [OK] Server is running on port 4200" -ForegroundColor Green
} else {
    Write-Host "   [WARNING] Server may not be running" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "SOLUTIONS TO TRY:" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. CLEAR BROWSER CACHE (Most Important!)" -ForegroundColor Yellow
Write-Host "   - Press Ctrl+Shift+Delete" -ForegroundColor White
Write-Host "   - Select 'All time'" -ForegroundColor White
Write-Host "   - Check 'Cached images and files'" -ForegroundColor White
Write-Host "   - Click 'Clear data'" -ForegroundColor White
Write-Host ""
Write-Host "2. HARD REFRESH" -ForegroundColor Yellow
Write-Host "   - Press Ctrl+F5 (Windows)" -ForegroundColor White
Write-Host "   - Or Ctrl+Shift+R" -ForegroundColor White
Write-Host ""
Write-Host "3. TRY INCOGNITO MODE" -ForegroundColor Yellow
Write-Host "   - Press Ctrl+Shift+N (Chrome)" -ForegroundColor White
Write-Host "   - Navigate to http://localhost:4200" -ForegroundColor White
Write-Host ""
Write-Host "4. CHECK BROWSER CONSOLE" -ForegroundColor Yellow
Write-Host "   - Press F12" -ForegroundColor White
Write-Host "   - Look for errors related to logo.svg" -ForegroundColor White
Write-Host ""
Write-Host "5. TRY DIFFERENT BROWSER" -ForegroundColor Yellow
Write-Host "   - Test in Chrome, Firefox, or Edge" -ForegroundColor White
Write-Host ""
