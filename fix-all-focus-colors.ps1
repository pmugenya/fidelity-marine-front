# PowerShell script to replace all focus:ring-pantone-teal with focus:ring-pantone-lime

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Fixing All Focus Colors to Lime Green" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$files = @(
    "src/app/modules/auth/marine-cargo-quotation/marine-cargo-quotation.component.html",
    "src/app/modules/auth/marine-cargo-quotation/marine-buy-now-modal.component.html"
)

$totalReplacements = 0

foreach ($file in $files) {
    if (Test-Path $file) {
        Write-Host "Processing: $file" -ForegroundColor Yellow
        
        # Read the file content
        $content = Get-Content $file -Raw
        
        # Count occurrences before replacement
        $beforeCount = ([regex]::Matches($content, 'focus:ring-pantone-teal')).Count
        
        # Replace focus:ring-pantone-teal with focus:ring-pantone-lime
        $newContent = $content -replace 'focus:ring-pantone-teal', 'focus:ring-pantone-lime'
        
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
Write-Host "All focus colors are now Lime Green!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
