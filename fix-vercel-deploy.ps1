# Fix Vercel deployment to serve assets folder
Write-Host "Fixing Vercel configuration..." -ForegroundColor Cyan

# Navigate to project
cd C:\Users\jaydh\Projects\web-sites\jasonplusproductions

# Backup current vercel.json
Copy-Item vercel.json vercel.json.backup -Force
Write-Host "Backed up vercel.json" -ForegroundColor Green

# Create new vercel.json with proper config
$vercelConfig = @"
{
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        {
          "key": "Content-Security-Policy",
          "value": "default-src 'self'; frame-src https://www.youtube.com https://www.youtube-nocookie.com; style-src 'self' 'unsafe-inline'; script-src 'self' 'unsafe-inline'; img-src 'self' data: https:; font-src 'self' data:"
        }
      ]
    }
  ],
  "buildCommand": null,
  "outputDirectory": "."
}
"@

# Write new config
$vercelConfig | Out-File -FilePath vercel.json -Encoding UTF8 -Force
Write-Host "Updated vercel.json with outputDirectory config" -ForegroundColor Green

# Git add, commit, push
git add vercel.json
git commit -m "Fix Vercel config to serve assets folder"
git push

Write-Host "`nDone! Vercel is now deploying..." -ForegroundColor Green
Write-Host "Wait 30-60 seconds then check: https://jasonplusproductions.com" -ForegroundColor Yellow
