# PowerShell script to update all logo references from .svg to .png

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Updating Logo References to PNG" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$files = @(
    "src/index.html",
    "src/app/layout/layouts/vertical/thin/thin.component.html",
    "src/app/layout/layouts/vertical/dense/dense.component.html",
    "src/app/layout/layouts/vertical/compact/compact.component.html",
    "src/app/layout/layouts/vertical/classy/classy.component.html",
    "src/app/layout/layouts/horizontal/modern/modern.component.html",
    "src/app/layout/layouts/horizontal/centered/centered.component.html",
    "src/app/modules/auth/sign-out/sign-out.component.html",
    "src/app/modules/auth/unlock-session/unlock-session.component.html",
    "src/app/modules/auth/reset-password/reset-password.component.html",
    "src/app/modules/auth/confirmation-required/confirmation-required.component.html",
    "src/app/modules/auth/marine-cargo-quotation/marine-cargo-quotation.component.html",
    "src/app/modules/auth/travel-quote/travel-quote.component.html",
    "src/app/modules/auth/dashboard/dashboard.component.html",
    "src/app/modules/admin/layout/sidebar/sidebar.component.html",
    "src/app/modules/auth/sign-in/sign-in.component.html"
)

$totalReplacements = 0

foreach ($file in $files) {
    if (Test-Path $file) {
        Write-Host "Processing: $file" -ForegroundColor Yellow
        
        # Read the file content
        $content = Get-Content $file -Raw
        
        # Count occurrences before replacement
        $beforeCount = ([regex]::Matches($content, 'images/logo/logo\.svg')).Count
        
        # Replace logo.svg with logo.png
        $newContent = $content -replace 'images/logo/logo\.svg', 'images/logo/logo.png'
        
        # Save the file
        Set-Content -Path $file -Value $newContent -NoNewline
        
        $totalReplacements += $beforeCount
        Write-Host "  Replaced $beforeCount occurrences" -ForegroundColor Green
    } else {
        Write-Host "  File not found: $file" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Total replacements: $totalReplacements" -ForegroundColor Green
Write-Host "All logo references now point to PNG!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "NEXT STEPS:" -ForegroundColor Yellow
Write-Host "1. Save the Fidelity logo as 'logo.png'" -ForegroundColor White
Write-Host "2. Place it in: public\images\logo\" -ForegroundColor White
Write-Host "3. Restart server: ng serve" -ForegroundColor White
Write-Host "4. Clear browser cache: Ctrl+Shift+Delete" -ForegroundColor White
