# Fix Content Security Policy for YouTube Embeds
# Run this from your project root directory

Write-Host "=== Fixing Content Security Policy ===" -ForegroundColor Cyan

# Ask which hosting platform
Write-Host "`nWhich hosting platform are you using?" -ForegroundColor Yellow
Write-Host "1. Vercel"
Write-Host "2. Netlify"
Write-Host "3. Other/Not sure"
$choice = Read-Host "Enter 1, 2, or 3"

switch ($choice) {
    "1" {
        # Vercel configuration
        Write-Host "`nCreating vercel.json..." -ForegroundColor Yellow
        
        $vercelConfig = @'
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
  ]
}
'@
        
        $vercelConfig | Out-File -FilePath "vercel.json" -Encoding UTF8
        Write-Host "✓ Created vercel.json" -ForegroundColor Green
        
        Write-Host "`nNEXT STEPS:" -ForegroundColor Cyan
        Write-Host "1. Run: git add vercel.json"
        Write-Host "2. Run: git commit -m 'Fix CSP to allow YouTube embeds'"
        Write-Host "3. Run: git push"
        Write-Host "4. Vercel will auto-deploy with the fix"
    }
    
    "2" {
        # Netlify configuration
        Write-Host "`nCreating _headers file..." -ForegroundColor Yellow
        
        $netlifyHeaders = @'
/*
  Content-Security-Policy: default-src 'self'; frame-src https://www.youtube.com https://www.youtube-nocookie.com; style-src 'self' 'unsafe-inline'; script-src 'self' 'unsafe-inline'; img-src 'self' data: https:; font-src 'self' data:
'@
        
        $netlifyHeaders | Out-File -FilePath "_headers" -Encoding UTF8 -NoNewline
        Write-Host "✓ Created _headers" -ForegroundColor Green
        
        Write-Host "`nNEXT STEPS:" -ForegroundColor Cyan
        Write-Host "1. Run: git add _headers"
        Write-Host "2. Run: git commit -m 'Fix CSP to allow YouTube embeds'"
        Write-Host "3. Run: git push"
        Write-Host "4. Netlify will auto-deploy with the fix"
    }
    
    "3" {
        Write-Host "`nYou'll need to update your CSP configuration manually." -ForegroundColor Yellow
        Write-Host "Look for Content-Security-Policy in:" -ForegroundColor Yellow
        Write-Host "  - <meta> tags in your HTML files"
        Write-Host "  - Server configuration files"
        Write-Host "  - .htaccess (if using Apache)"
        Write-Host "`nAdd this to allow YouTube embeds:" -ForegroundColor Cyan
        Write-Host "frame-src https://www.youtube.com https://www.youtube-nocookie.com" -ForegroundColor White
    }
}

# Check for CSP in HTML files
Write-Host "`n=== Checking HTML files for CSP meta tags ===" -ForegroundColor Cyan
$htmlFiles = Get-ChildItem -Recurse -Filter "*.html" -File -ErrorAction SilentlyContinue |
             Where-Object { $_.DirectoryName -notmatch "node_modules|\.git" }

$foundCSP = $false
foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw
    if ($content -match 'Content-Security-Policy') {
        Write-Host "⚠ Found CSP in: $($file.Name)" -ForegroundColor Yellow
        Write-Host "   Location: $($file.FullName)" -ForegroundColor Gray
        $foundCSP = $true
    }
}

if ($foundCSP) {
    Write-Host "`n⚠ WARNING: Found CSP in HTML files!" -ForegroundColor Red
    Write-Host "You should remove CSP from <meta> tags and use server headers instead." -ForegroundColor Yellow
    Write-Host "Server headers (vercel.json or _headers) override meta tags and are more secure." -ForegroundColor Yellow
}

Write-Host "`n" -ForegroundColor White
