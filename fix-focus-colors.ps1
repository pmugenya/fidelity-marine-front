# PowerShell script to replace focus:ring-pantone-teal with focus:ring-pantone-lime

$targetFile = "src/app/modules/auth/marine-cargo-quotation/marine-buy-now-modal.component.html"

Write-Host "Fixing focus colors in $targetFile..." -ForegroundColor Cyan

# Read the file content
$content = Get-Content $targetFile -Raw

# Replace focus:ring-pantone-teal with focus:ring-pantone-lime
$newContent = $content -replace 'focus:ring-pantone-teal', 'focus:ring-pantone-lime'

# Save the file
Set-Content -Path $targetFile -Value $newContent -NoNewline

Write-Host "Focus colors fixed successfully!" -ForegroundColor Green
Write-Host "All focus rings are now lime green (Pantone 366C)" -ForegroundColor Green
