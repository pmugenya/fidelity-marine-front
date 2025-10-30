# ============================================================================
# Blue to Pantone Color Replacement Script
# ============================================================================
# This script replaces all blue color references with Pantone 328U and 366C
# ============================================================================

Write-Host "Starting color replacement..." -ForegroundColor Cyan
Write-Host ""

# Define replacement mappings
$replacements = @{
    # Tailwind Sky Blue Classes
    'bg-sky-500' = 'bg-pantone-teal'
    'bg-sky-600' = 'bg-pantone-teal-dark'
    'bg-sky-400' = 'bg-pantone-teal-light'
    'text-sky-500' = 'text-pantone-teal'
    'text-sky-600' = 'text-pantone-teal-dark'
    'text-sky-400' = 'text-pantone-teal-light'
    'border-sky-500' = 'border-pantone-teal'
    'border-sky-600' = 'border-pantone-teal-dark'
    'focus:border-sky-500' = 'focus:border-pantone-teal'
    'focus:ring-sky-500' = 'focus:ring-pantone-teal'
    'focus:ring-sky-500/20' = 'focus:ring-pantone-teal/20'
    'hover:bg-sky-600' = 'hover:bg-pantone-teal-dark'
    'hover:text-sky-600' = 'hover:text-pantone-teal-dark'
    'hover:text-sky-500' = 'hover:text-pantone-teal'
    
    # Tailwind Blue Classes
    'bg-blue-500' = 'bg-pantone-teal'
    'bg-blue-600' = 'bg-pantone-teal-dark'
    'text-blue-500' = 'text-pantone-teal'
    'text-blue-600' = 'text-pantone-teal-dark'
    'border-blue-500' = 'border-pantone-teal'
    'focus:border-blue-500' = 'focus:border-pantone-teal'
    'focus:ring-blue-500' = 'focus:ring-pantone-teal'
    'hover:bg-blue-600' = 'hover:bg-pantone-teal-dark'
    
    # Custom Pantone Classes (old)
    'bg-pantone-light-blue' = 'bg-pantone-teal'
    'text-pantone-light-blue' = 'text-pantone-teal'
    'border-pantone-light-blue' = 'border-pantone-teal'
    
    # Hex Color Codes
    '#04b2e1' = '#00787C'
}

# Count statistics
$totalFiles = 0
$totalReplacements = 0
$filesModified = 0

# Get all HTML, SCSS, CSS, and TS files
$files = Get-ChildItem -Path "src" -Include *.html,*.scss,*.css,*.ts -Recurse -ErrorAction SilentlyContinue

Write-Host "Found $($files.Count) files to process" -ForegroundColor Yellow
Write-Host ""

foreach ($file in $files) {
    $totalFiles++
    $content = Get-Content $file.FullName -Raw
    $originalContent = $content
    $fileReplacements = 0
    
    # Apply all replacements
    foreach ($old in $replacements.Keys) {
        $new = $replacements[$old]
        $matches = ([regex]::Matches($content, [regex]::Escape($old))).Count
        if ($matches -gt 0) {
            $content = $content -replace [regex]::Escape($old), $new
            $fileReplacements += $matches
        }
    }
    
    # If content changed, save the file
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -NoNewline
        $filesModified++
        $totalReplacements += $fileReplacements
        Write-Host "Modified: $($file.Name) - $fileReplacements replacements" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "============================================================================" -ForegroundColor Cyan
Write-Host "Color Replacement Complete!" -ForegroundColor Green
Write-Host "============================================================================" -ForegroundColor Cyan
Write-Host "Files processed: $totalFiles" -ForegroundColor White
Write-Host "Files modified: $filesModified" -ForegroundColor Yellow
Write-Host "Total replacements: $totalReplacements" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Review the changes in your IDE" -ForegroundColor White
Write-Host "2. Test the application locally" -ForegroundColor White
Write-Host "3. Run: ng build --output-hashing=all" -ForegroundColor White
Write-Host "============================================================================" -ForegroundColor Cyan
