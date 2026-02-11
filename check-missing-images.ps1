# Check for Missing Images in Jason Plus Productions Project
# Run this from your project root directory

Write-Host "=== Checking for Missing Images ===" -ForegroundColor Cyan

# Define the images that are returning 404
$missingImages = @(
    "jason-plus-mlc-2021.png",
    "stage-duo.png",
    "band-camp-north-end.png",
    "choir-performance.png",
    "group-selfie.png",
    "piano-performance.png",
    "merch-hoodie.png",
    "merch-mug.png",
    "merch-tote.png",
    "merch-sticker.png"
)

# Common image directories to check
$imageDirs = @(
    "images",
    "public/images",
    "public/assets",
    "assets/images",
    "src/images",
    "static/images"
)

Write-Host "`nSearching for image directories..." -ForegroundColor Yellow

# Find which directory exists
$foundDir = $null
foreach ($dir in $imageDirs) {
    if (Test-Path $dir) {
        Write-Host "✓ Found: $dir" -ForegroundColor Green
        $foundDir = $dir
        break
    }
}

if ($foundDir) {
    Write-Host "`nChecking for missing images in: $foundDir" -ForegroundColor Yellow
    Write-Host ("=" * 50)
    
    $found = @()
    $missing = @()
    
    foreach ($img in $missingImages) {
        $path = Join-Path $foundDir $img
        if (Test-Path $path) {
            Write-Host "✓ FOUND: $img" -ForegroundColor Green
            $found += $img
        } else {
            Write-Host "✗ MISSING: $img" -ForegroundColor Red
            $missing += $img
        }
    }
    
    Write-Host "`n=== SUMMARY ===" -ForegroundColor Cyan
    Write-Host "Found: $($found.Count) / $($missingImages.Count)" -ForegroundColor Green
    Write-Host "Missing: $($missing.Count) / $($missingImages.Count)" -ForegroundColor Red
    
    if ($missing.Count -gt 0) {
        Write-Host "`nMissing files:" -ForegroundColor Yellow
        $missing | ForEach-Object { Write-Host "  - $_" -ForegroundColor Red }
        
        Write-Host "`nNEXT STEPS:" -ForegroundColor Cyan
        Write-Host "1. Locate these image files on your computer"
        Write-Host "2. Copy them to: $foundDir"
        Write-Host "3. Run: git add $foundDir/*.png"
        Write-Host "4. Run: git commit -m 'Add missing images'"
        Write-Host "5. Run: git push"
    }
} else {
    Write-Host "`nNo standard image directory found!" -ForegroundColor Red
    Write-Host "Searching entire project for .png files..." -ForegroundColor Yellow
    
    $pngFiles = Get-ChildItem -Recurse -Filter "*.png" -File -ErrorAction SilentlyContinue | 
                Select-Object -First 5
    
    if ($pngFiles) {
        Write-Host "`nFound some PNG files in:" -ForegroundColor Yellow
        $pngFiles | ForEach-Object { Write-Host "  $($_.DirectoryName)" -ForegroundColor Gray }
        Write-Host "`nYou may need to create an images directory."
    }
}

Write-Host "`n" -ForegroundColor White
