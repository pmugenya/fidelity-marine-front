# Rename Fidelity logo to logo.svg

$oldName = "FIDELITY LOGO - Black (2) (1).svg"
$newName = "logo.svg"
$folder = "public\images\logo"

$oldPath = Join-Path $folder $oldName
$newPath = Join-Path $folder $newName

if (Test-Path $oldPath) {
    Rename-Item -Path $oldPath -NewName $newName -Force
    Write-Host "Successfully renamed to logo.svg" -ForegroundColor Green
    Write-Host ""
    Write-Host "File location:" -ForegroundColor Cyan
    Write-Host "  $newPath" -ForegroundColor White
    Write-Host ""
    Write-Host "NEXT STEPS:" -ForegroundColor Yellow
    Write-Host "1. Clear browser cache: Ctrl+Shift+Delete" -ForegroundColor White
    Write-Host "2. Or hard refresh: Ctrl+F5" -ForegroundColor White
    Write-Host "3. Refresh your browser" -ForegroundColor White
} else {
    Write-Host "File not found: $oldPath" -ForegroundColor Red
}
