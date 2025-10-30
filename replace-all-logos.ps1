# PowerShell script to replace all Geminia logos with Fidelity Insurance logo

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Logo Replacement Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Instructions for logo file
Write-Host "STEP 1: Prepare Fidelity Logo" -ForegroundColor Yellow
Write-Host "Please save the Fidelity Insurance logo as:" -ForegroundColor White
Write-Host "  fidelity-logo.svg or fidelity-logo.png" -ForegroundColor Green
Write-Host "  in the project root directory" -ForegroundColor Green
Write-Host ""

# Check if logo file exists
$logoFiles = @("fidelity-logo.svg", "fidelity-logo.png")
$logoFile = $null

foreach ($file in $logoFiles) {
    if (Test-Path $file) {
        $logoFile = $file
        Write-Host "✓ Found logo file: $file" -ForegroundColor Green
        break
    }
}

if (-not $logoFile) {
    Write-Host "✗ Logo file not found!" -ForegroundColor Red
    Write-Host "Please save the Fidelity logo as 'fidelity-logo.svg' or 'fidelity-logo.png'" -ForegroundColor Yellow
    Write-Host "in the project root, then run this script again." -ForegroundColor Yellow
    exit
}

Write-Host ""
Write-Host "STEP 2: Backup Current Logos" -ForegroundColor Yellow

# Backup current logos
$backupDir = "logo-backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
New-Item -ItemType Directory -Path $backupDir -Force | Out-Null

if (Test-Path "public/images/logo/logo.svg") {
    Copy-Item "public/images/logo/logo.svg" "$backupDir/logo.svg"
    Write-Host "✓ Backed up logo.svg" -ForegroundColor Green
}

Write-Host ""
Write-Host "STEP 3: Copy Fidelity Logo" -ForegroundColor Yellow

# Determine file extension
$extension = [System.IO.Path]::GetExtension($logoFile)

# Copy to public/images/logo/
Copy-Item $logoFile "public/images/logo/logo$extension" -Force
Write-Host "✓ Copied to public/images/logo/logo$extension" -ForegroundColor Green

# If it's PNG, also create an SVG version message
if ($extension -eq ".png") {
    Write-Host "Note: You may want to convert PNG to SVG for better quality" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "STEP 4: Update HTML Files" -ForegroundColor Yellow

# Files to update with inline logo URLs
$inlineLogoFiles = @(
    "src/app/modules/auth/marine-cargo-quotation/marine-cargo-quotation.component.html",
    "src/app/modules/auth/travel-quote/travel-quote.component.html",
    "src/app/modules/auth/dashboard/dashboard.component.html",
    "src/app/modules/admin/layout/sidebar/sidebar.component.html"
)

$geminiaTealUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROTKn0j9cVpA67LPdjPeYBR3KnWiwP1gsM3cS27rca-7m8BgvgUylY4uhBnOnVnXFx8Is&usqp=CAU"
$fidelityLogoUrl = "images/logo/logo$extension"

$filesUpdated = 0

foreach ($file in $inlineLogoFiles) {
    if (Test-Path $file) {
        $content = Get-Content $file -Raw
        
        # Replace Geminia logo URL with Fidelity logo
        $newContent = $content -replace [regex]::Escape($geminiaTealUrl), $fidelityLogoUrl
        
        # Replace alt text
        $newContent = $newContent -replace 'alt="Geminia Logo"', 'alt="Fidelity Insurance Logo"'
        
        # Replace titles
        $newContent = $newContent -replace 'Geminia Marine', 'Fidelity Marine'
        $newContent = $newContent -replace 'Geminia Travel', 'Fidelity Travel'
        $newContent = $newContent -replace 'Geminia Admin', 'Fidelity Admin'
        
        # Replace tagline
        $newContent = $newContent -replace 'Think Insurance \.\.\. Think Geminia', 'Your Trusted Insurance Partner'
        
        if ($content -ne $newContent) {
            Set-Content -Path $file -Value $newContent -NoNewline
            $filesUpdated++
            Write-Host "✓ Updated: $file" -ForegroundColor Green
        }
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Summary:" -ForegroundColor Cyan
Write-Host "  Files updated: $filesUpdated" -ForegroundColor Green
Write-Host "  Logo file: $logoFile" -ForegroundColor Green
Write-Host "  Backup location: $backupDir" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "NEXT STEPS:" -ForegroundColor Yellow
Write-Host "1. Rebuild the application: ng build --output-hashing=all" -ForegroundColor White
Write-Host "2. Test all pages to verify logo appears correctly" -ForegroundColor White
Write-Host "3. Check responsive behavior on mobile devices" -ForegroundColor White
Write-Host ""
Write-Host "Logo replacement complete! ✓" -ForegroundColor Green
