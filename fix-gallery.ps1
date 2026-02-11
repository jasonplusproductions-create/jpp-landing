# Automated Gallery Fix Script

Write-Host "Fixing Gallery Images..." -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path "jpp-improvements.css")) {
    Write-Host "ERROR: jpp-improvements.css not found!" -ForegroundColor Red
    exit 1
}

Write-Host "Reading CSS file..." -ForegroundColor Blue

# Read the CSS file
$css = Get-Content "jpp-improvements.css" -Raw

# Remove old gallery CSS if it exists
$css = $css -replace '\/\* Gallery images - set specific height \*\/[\s\S]*?#gallery > div > div \{[\s\S]*?\}', ''

# Add new aggressive gallery fix at the end
$galleryFix = @'


/* AGGRESSIVE GALLERY FIX */
#gallery {
  padding: 60px 20px !important;
}

#gallery > div {
  display: grid !important;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)) !important;
  gap: 16px !important;
  max-width: 1200px !important;
  margin: 0 auto !important;
}

#gallery > div > div,
#gallery div[class*="grid"] > div {
  position: relative !important;
  width: 100% !important;
  height: 280px !important;
  overflow: hidden !important;
  border-radius: 12px !important;
}

#gallery img {
  width: 100% !important;
  height: 100% !important;
  object-fit: cover !important;
  object-position: center !important;
  display: block !important;
}

#gallery > div > div:hover img,
#gallery div[class*="grid"] > div:hover img {
  transform: scale(1.05) !important;
}
'@

# Append the fix
$css += $galleryFix

# Write back to file
$css | Out-File -FilePath "jpp-improvements.css" -Encoding UTF8 -NoNewline

Write-Host "Updated jpp-improvements.css" -ForegroundColor Green
Write-Host ""
Write-Host "Deploying..." -ForegroundColor Blue

# Deploy
git add jpp-improvements.css
git commit -m "fix: aggressive gallery image size constraints"
git push origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "=============================" -ForegroundColor Green
    Write-Host "SUCCESS!" -ForegroundColor Green
    Write-Host "=============================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Gallery images fixed:" -ForegroundColor Cyan
    Write-Host "  - All images: 280px tall" -ForegroundColor White
    Write-Host "  - Uniform grid layout" -ForegroundColor White
    Write-Host "  - Proper cropping" -ForegroundColor White
    Write-Host ""
    Write-Host "Live in 2-3 minutes at:" -ForegroundColor Cyan
    Write-Host "https://jasonplusproductions.com" -ForegroundColor Yellow
} else {
    Write-Host "Deployment failed!" -ForegroundColor Red
}
