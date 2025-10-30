# PowerShell script to update Document Uploads section styling

$file = "src/app/modules/auth/marine-cargo-quotation/marine-buy-now-modal.component.html"

Write-Host "Updating Document Uploads section..." -ForegroundColor Cyan

# Read the file content
$content = Get-Content $file -Raw

# Replace all document upload labels to white text
$content = $content -replace 'text-gray-700 mb-1">\s*Invoice', 'text-white mb-1">
                  Invoice'
$content = $content -replace 'text-gray-700 mb-1">\s*KRA PIN Certificate', 'text-white mb-1">
                      KRA PIN Certificate'
$content = $content -replace 'text-gray-700 mb-1">\s*National ID', 'text-white mb-1">
                      National ID'

# Replace red asterisks with yellow
$content = $content -replace '<span class="text-red-500">\*</span>', '<span class="text-yellow-300">*</span>'

# Replace border and background classes for upload boxes
$content = $content -replace 'border-gray-300 hover:border-pantone-teal hover:bg-pantone-teal/10', 'border-white'
$content = $content -replace 'border-2 border-dashed rounded-md p-3 text-center cursor-pointer transition-colors', 'border-2 border-dashed border-white rounded-md p-3 text-center cursor-pointer transition-colors bg-white/10 hover:bg-white/20'

# Replace text colors in upload boxes
$content = $content -replace 'text-xs text-gray-500 mt-1', 'text-xs text-white mt-1'
$content = $content -replace 'text-xs text-gray-400 mt-1', 'text-xs text-white/70 mt-1'

# Save the file
Set-Content -Path $file -Value $content -NoNewline

Write-Host "Document Uploads section updated successfully!" -ForegroundColor Green
