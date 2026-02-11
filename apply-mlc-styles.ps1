# Apply MLC Styling to JPP Site - Automated

Write-Host "Applying MLC styling to JPP site..." -ForegroundColor Cyan
Write-Host ""

# Step 1: Add fonts to HTML
Write-Host "Step 1: Updating fonts in index.html..." -ForegroundColor Blue
$html = Get-Content "index.html" -Raw

if ($html -notmatch "Bebas.Neue") {
    $fontLink = '<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Montserrat:wght@300;400;600;700&display=swap" rel="stylesheet">'
    $html = $html -replace '(<link[^>]*Inter[^>]*>)', ($fontLink + "`r`n" + '$1')
    $html | Out-File -FilePath "index.html" -Encoding UTF8 -NoNewline
    Write-Host "  Added Bebas Neue + Montserrat fonts" -ForegroundColor Green
} else {
    Write-Host "  Fonts already added" -ForegroundColor Yellow
}

# Step 2: Replace CSS with MLC styling
Write-Host "Step 2: Applying MLC styles to CSS..." -ForegroundColor Blue

$mlcCSS = @'
/* MLC-INSPIRED STYLING */
:root { --mlc-dark: #0a0a0a; --mlc-navy: #1a2332; --mlc-gold: #d4af37; --mlc-text: #ffffff; --mlc-text-muted: #a0a0a0; }
body { background-color: var(--mlc-dark) !important; color: var(--mlc-text) !important; font-family: 'Montserrat', sans-serif !important; font-weight: 400; }
h1, h2, h3, h4, h5, h6 { font-family: 'Bebas Neue', sans-serif !important; font-weight: 400 !important; letter-spacing: 2px !important; text-transform: uppercase !important; }
h1 { font-size: 5rem !important; line-height: 1 !important; letter-spacing: 4px !important; }
h2 { font-size: 3.5rem !important; letter-spacing: 3px !important; color: #b0b0b0 !important; }
h3 { font-size: 2rem !important; letter-spacing: 2px !important; }
p { font-family: 'Montserrat', sans-serif !important; font-size: 1.1rem !important; line-height: 1.8 !important; color: var(--mlc-text-muted) !important; font-weight: 300 !important; }
nav { background: rgba(10, 10, 10, 0.95) !important; backdrop-filter: blur(10px) !important; border-bottom: 1px solid rgba(255, 255, 255, 0.1) !important; }
nav a { font-family: 'Montserrat', sans-serif !important; font-size: 0.9rem !important; font-weight: 600 !important; letter-spacing: 2px !important; text-transform: uppercase !important; color: #ffffff !important; transition: color 0.3s !important; }
nav a:hover { color: var(--mlc-gold) !important; }
section { padding: 100px 40px !important; background-color: var(--mlc-dark) !important; }
section:nth-child(even) { background-color: var(--mlc-navy) !important; }
h2::after { content: '' !important; display: block !important; width: 80px !important; height: 3px !important; background: var(--mlc-gold) !important; margin: 20px auto 0 !important; }
section h2 { text-align: center !important; margin-bottom: 60px !important; }
#about { display: grid !important; grid-template-columns: 1fr 1.2fr !important; gap: 60px !important; align-items: center !important; max-width: 1400px !important; margin: 0 auto !important; }
#about img { width: 100% !important; max-width: 600px !important; height: auto !important; object-fit: cover !important; border: 3px solid rgba(255, 255, 255, 0.1) !important; box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5) !important; }
#gallery { max-width: 1400px !important; margin: 0 auto !important; }
#gallery > div { display: grid !important; grid-template-columns: repeat(auto-fit, minmax(320px, 1fr)) !important; gap: 20px !important; }
#gallery > div > div { height: 320px !important; overflow: hidden !important; border: 2px solid rgba(255, 255, 255, 0.1) !important; transition: transform 0.3s, border-color 0.3s !important; }
#gallery > div > div:hover { transform: translateY(-5px) !important; border-color: var(--mlc-gold) !important; }
#gallery img { width: 100% !important; height: 100% !important; object-fit: cover !important; filter: grayscale(20%) !important; transition: filter 0.3s, transform 0.3s !important; }
#gallery img:hover { filter: grayscale(0%) !important; transform: scale(1.05) !important; }
.cta-primary, a[href="#services"], button { background: var(--mlc-gold) !important; color: #000000 !important; font-family: 'Montserrat', sans-serif !important; font-weight: 700 !important; letter-spacing: 2px !important; text-transform: uppercase !important; padding: 18px 40px !important; border: none !important; font-size: 0.9rem !important; transition: all 0.3s !important; box-shadow: 0 4px 15px rgba(212, 175, 55, 0.3) !important; }
.cta-primary:hover, a[href="#services"]:hover, button:hover { background: #fff !important; color: #000 !important; box-shadow: 0 6px 25px rgba(255, 255, 255, 0.4) !important; transform: translateY(-2px) !important; }
#services > div > div { background: rgba(26, 35, 50, 0.5) !important; border: 1px solid rgba(255, 255, 255, 0.1) !important; backdrop-filter: blur(10px) !important; padding: 50px 40px !important; transition: all 0.4s !important; }
#services > div > div:hover { background: rgba(26, 35, 50, 0.8) !important; border-color: var(--mlc-gold) !important; transform: translateY(-10px) !important; box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4) !important; }
#contact { background: linear-gradient(135deg, var(--mlc-navy), var(--mlc-dark)) !important; border-top: 1px solid rgba(212, 175, 55, 0.3) !important; }
#merch-cards article { background: rgba(26, 35, 50, 0.6) !important; border: 1px solid rgba(255, 255, 255, 0.1) !important; transition: all 0.3s !important; }
#merch-cards article:hover { border-color: var(--mlc-gold) !important; transform: translateY(-5px) !important; }
#merch-cards article img { height: 280px !important; filter: grayscale(10%) !important; }
.scroll-to-top { background: var(--mlc-gold) !important; color: #000 !important; font-weight: bold !important; }
.scroll-to-top:hover { background: #fff !important; box-shadow: 0 6px 20px rgba(212, 175, 55, 0.5) !important; }
@media (max-width: 768px) { h1 { font-size: 3rem !important; } h2 { font-size: 2.5rem !important; } #about { grid-template-columns: 1fr !important; } section { padding: 60px 20px !important; } }
'@

$mlcCSS | Out-File -FilePath "jpp-improvements.css" -Encoding UTF8 -NoNewline
Write-Host "  Applied MLC styling" -ForegroundColor Green

Write-Host ""
Write-Host "Step 3: Deploying..." -ForegroundColor Blue
git add index.html jpp-improvements.css
git commit -m "feat: apply MLC-inspired styling (Bebas Neue, Montserrat, gold accents)"
git push origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "SUCCESS! MLC Styling Applied!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Applied changes:" -ForegroundColor Cyan
    Write-Host "  - Fonts: Bebas Neue (headings) + Montserrat (body)" -ForegroundColor White
    Write-Host "  - Colors: Dark navy + gold accents" -ForegroundColor White
    Write-Host "  - Layout: MLC-style two-column about section" -ForegroundColor White
    Write-Host "  - Images: Bordered gallery with grayscale" -ForegroundColor White
    Write-Host "  - Buttons: Gold with uppercase styling" -ForegroundColor White
    Write-Host ""
    Write-Host "Live in 2-3 minutes at:" -ForegroundColor Cyan
    Write-Host "https://jasonplusproductions.com" -ForegroundColor Yellow
} else {
    Write-Host "Deployment failed!" -ForegroundColor Red
}
