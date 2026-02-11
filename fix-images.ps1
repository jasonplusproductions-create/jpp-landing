# Image Fix Automation Script for Windows PowerShell

Write-Host "Fixing image sizes..." -ForegroundColor Cyan
Write-Host ""

# Check if CSS file exists
if (-not (Test-Path "jpp-improvements.css")) {
    Write-Host "ERROR: jpp-improvements.css not found!" -ForegroundColor Red
    exit 1
}

Write-Host "Found jpp-improvements.css" -ForegroundColor Green

# Read current CSS
$css = Get-Content "jpp-improvements.css" -Raw

# Check if fixes already applied
if ($css -match "MERCH IMAGE FIX") {
    Write-Host "Image fixes already applied!" -ForegroundColor Yellow
    exit 0
}

# Add image fixes to the end
$imageFixes = @'


/* COMPREHENSIVE IMAGE FIXES */

/* Global image constraint */
img {
  max-width: 100%;
  height: auto;
}

/* About section image - constrain and center */
#about img {
  max-width: 400px !important;
  width: 100% !important;
  height: auto !important;
  object-fit: cover !important;
  border-radius: 8px !important;
  display: block !important;
  margin: 0 auto !important;
}

/* Gallery images - set specific height */
#gallery img {
  width: 100% !important;
  height: 300px !important;
  object-fit: cover !important;
}

#gallery > div > div {
  position: relative;
  overflow: hidden;
  border-radius: 12px;
  height: 300px !important;
}

/* MERCH IMAGE FIX */
#merch-cards article img {
  width: 100% !important;
  height: 200px !important;
  object-fit: cover !important;
  object-position: center !important;
  display: block !important;
}

#merch-cards article {
  overflow: hidden !important;
}

#merch-cards .merch-info {
  padding: 20px !important;
}

/* Performance/Video sections */
#performance img,
iframe {
  max-width: 100% !important;
  height: auto !important;
}
'@

# Append fixes
$css += $imageFixes
$css | Out-File -FilePath "jpp-improvements.css" -Encoding UTF8

Write-Host "Added image fixes to CSS" -ForegroundColor Green
Write-Host ""
Write-Host "Deploying to production..." -ForegroundColor Blue

# Git commands
git add jpp-improvements.css
if ($LASTEXITCODE -eq 0) {
    Write-Host "Staged changes" -ForegroundColor Green
    
    git commit -m "fix: constrain all image sizes properly"
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Committed changes" -ForegroundColor Green
        
        git push origin main
        if ($LASTEXITCODE -eq 0) {
            Write-Host ""
            Write-Host "=============================" -ForegroundColor Green
            Write-Host "SUCCESS! Images Fixed!" -ForegroundColor Green
            Write-Host "=============================" -ForegroundColor Green
            Write-Host ""
            Write-Host "Changes will be live in 2-3 minutes at:" -ForegroundColor Cyan
            Write-Host "https://jasonplusproductions.com" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "Fixed images:" -ForegroundColor Green
            Write-Host "  - About: 400px max" -ForegroundColor White
            Write-Host "  - Gallery: 300px height" -ForegroundColor White
            Write-Host "  - Merch: 200px height" -ForegroundColor White
        } else {
            Write-Host "Push failed!" -ForegroundColor Red
        }
    } else {
        Write-Host "Commit failed!" -ForegroundColor Red
    }
} else {
    Write-Host "Git add failed!" -ForegroundColor Red
}
