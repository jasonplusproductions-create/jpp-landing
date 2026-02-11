# JPP Website - Automated Setup Script for Windows PowerShell
# Run from your project directory

Write-Host "JPP Website - Automated Setup" -ForegroundColor Cyan
Write-Host "==============================" -ForegroundColor Cyan
Write-Host ""

# Check if index.html exists
if (-not (Test-Path "index.html")) {
    Write-Host "ERROR: index.html not found!" -ForegroundColor Red
    Write-Host "Current directory: $(Get-Location)"
    exit 1
}

Write-Host "Found index.html" -ForegroundColor Green
Write-Host ""

# Create CSS file
Write-Host "Creating jpp-improvements.css..." -ForegroundColor Blue

@'
/* JPP WEBSITE - COMPREHENSIVE IMPROVEMENTS */
body { font-family: 'Inter', -apple-system, sans-serif; line-height: 1.6; font-size: 16px; }
h1 { font-size: 3rem !important; font-weight: 700 !important; margin-bottom: 24px !important; }
h2 { font-size: 2.5rem !important; font-weight: 700 !important; margin-bottom: 16px !important; }
h3 { font-size: 1.75rem !important; font-weight: 600 !important; }
p { margin-bottom: 1.5rem; font-size: 1.1rem; opacity: 0.9; }
html { scroll-behavior: smooth; }
section { padding: 80px 20px !important; max-width: 1200px; margin: 0 auto; }
section:nth-child(even) { background: rgba(255, 255, 255, 0.02); }
nav { position: sticky !important; top: 0 !important; z-index: 1000 !important; background: rgba(0, 0, 0, 0.95) !important; backdrop-filter: blur(10px); box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3); transition: all 0.3s; padding: 16px 0; }
nav.scrolled { padding: 12px 0; background: rgba(0, 0, 0, 0.98) !important; }
nav a { transition: all 0.3s; }
nav a:hover { color: #D946EF !important; }
.section-header { text-align: center; margin-bottom: 60px; }
.section-header h2 { background: linear-gradient(135deg, #D946EF, #7C3AED); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
.cta-primary, a[href="#services"] { display: inline-block !important; padding: 16px 32px !important; background: linear-gradient(135deg, #D946EF, #7C3AED) !important; color: white !important; text-decoration: none !important; border-radius: 8px !important; font-weight: 600 !important; transition: all 0.3s !important; margin-top: 24px !important; }
.cta-primary:hover, a[href="#services"]:hover { transform: translateY(-2px) !important; box-shadow: 0 12px 24px rgba(217, 70, 239, 0.3) !important; }
#services > div > div { background: rgba(255, 255, 255, 0.05) !important; border: 1px solid rgba(255, 255, 255, 0.1) !important; border-radius: 16px !important; padding: 40px !important; transition: all 0.3s !important; }
#services > div > div:hover { transform: translateY(-8px) !important; box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3) !important; border-color: rgba(217, 70, 239, 0.5) !important; }
#gallery img { object-fit: cover !important; width: 100% !important; height: 100% !important; transition: transform 0.5s !important; }
#gallery > div > div { position: relative; overflow: hidden; border-radius: 12px; aspect-ratio: 4/3; cursor: pointer; }
#gallery > div > div:hover img { transform: scale(1.1) !important; }
#merch-cards article { background: rgba(255, 255, 255, 0.03) !important; border: 1px solid rgba(255, 255, 255, 0.1) !important; border-radius: 12px !important; transition: all 0.3s !important; }
#merch-cards article:hover { transform: translateY(-4px) !important; box-shadow: 0 12px 24px rgba(0, 0, 0, 0.3) !important; }
#merch-cards a[href*="stripe"], #merch-cards a[href*="themlc"] { background: linear-gradient(135deg, #D946EF, #7C3AED) !important; color: white !important; padding: 10px 20px !important; border-radius: 6px !important; font-weight: 600 !important; }
#contact { background: linear-gradient(135deg, rgba(217, 70, 239, 0.05), rgba(124, 58, 237, 0.05)) !important; border-radius: 16px !important; padding: 60px 40px !important; }
#contact a { display: inline-flex !important; padding: 12px 20px !important; background: rgba(255, 255, 255, 0.05) !important; border-radius: 8px !important; transition: all 0.3s !important; }
#contact a:hover { background: rgba(217, 70, 239, 0.2) !important; transform: translateX(4px) !important; }
.scroll-to-top { position: fixed; bottom: 30px; right: 30px; width: 50px; height: 50px; border-radius: 50%; background: linear-gradient(135deg, #D946EF, #7C3AED); color: white; border: none; font-size: 24px; cursor: pointer; opacity: 0; transform: scale(0); transition: all 0.3s; z-index: 1000; }
.scroll-to-top.visible { opacity: 1; transform: scale(1); }
.fade-in-section { opacity: 0; transform: translateY(30px); transition: opacity 0.6s, transform 0.6s; }
.fade-in-section.visible { opacity: 1; transform: translateY(0); }
@media (max-width: 768px) { h1 { font-size: 2rem !important; } h2 { font-size: 1.75rem !important; } section { padding: 60px 16px !important; } }
'@ | Out-File -FilePath "jpp-improvements.css" -Encoding UTF8

Write-Host "Created jpp-improvements.css" -ForegroundColor Green

# Create JS file
Write-Host "Creating jpp-improvements.js..." -ForegroundColor Blue

@'
document.addEventListener('DOMContentLoaded', function() {
  const nav = document.querySelector('nav');
  window.addEventListener('scroll', () => {
    if (window.pageYOffset > 100 && nav) nav.classList.add('scrolled');
    else if (nav) nav.classList.remove('scrolled');
  });
  const scrollBtn = document.createElement('button');
  scrollBtn.className = 'scroll-to-top';
  scrollBtn.innerHTML = '↑';
  scrollBtn.onclick = () => window.scrollTo({ top: 0, behavior: 'smooth' });
  document.body.appendChild(scrollBtn);
  window.addEventListener('scroll', () => {
    if (window.pageYOffset > 300) scrollBtn.classList.add('visible');
    else scrollBtn.classList.remove('visible');
  });
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => { if (entry.isIntersecting) entry.target.classList.add('visible'); });
  }, { threshold: 0.1, rootMargin: '0px 0px -50px 0px' });
  document.querySelectorAll('section').forEach((section, index) => {
    if (index > 0) { section.classList.add('fade-in-section'); observer.observe(section); }
  });
  const sections = Array.from(document.querySelectorAll('section'));
  const projectLinks = sections.find(s => s.textContent.includes('Project & Studio Links'));
  if (projectLinks) projectLinks.style.display = 'none';
  document.querySelectorAll('#gallery > div > div').forEach(item => {
    if (item.querySelector('img') && !item.querySelector('.gallery-overlay')) {
      const overlay = document.createElement('div');
      overlay.className = 'gallery-overlay';
      overlay.style.cssText = 'position:absolute;inset:0;background:linear-gradient(to top,rgba(0,0,0,0.8),transparent);opacity:0;transition:opacity 0.3s;pointer-events:none;';
      item.appendChild(overlay);
      item.addEventListener('mouseenter', () => overlay.style.opacity = '1');
      item.addEventListener('mouseleave', () => overlay.style.opacity = '0');
    }
  });
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      const href = this.getAttribute('href');
      if (href === '#') return;
      e.preventDefault();
      const target = document.querySelector(href);
      if (target) target.scrollIntoView({ behavior: 'smooth' });
    });
  });
  console.log('JPP Improvements Loaded');
});
'@ | Out-File -FilePath "jpp-improvements.js" -Encoding UTF8

Write-Host "Created jpp-improvements.js" -ForegroundColor Green
Write-Host ""

# Backup and update HTML
Write-Host "Updating index.html..." -ForegroundColor Blue
Copy-Item "index.html" "index.html.bak"
Write-Host "Created backup: index.html.bak" -ForegroundColor Green

$html = Get-Content "index.html" -Raw

# Add CSS if not present
if ($html -notmatch "jpp-improvements.css") {
    $cssLink = '  <link rel="stylesheet" href="jpp-improvements.css">' + "`r`n"
    $html = $html -replace '(?i)</head>', ($cssLink + '</head>')
    Write-Host "Added CSS link" -ForegroundColor Green
}

# Add JS if not present  
if ($html -notmatch "jpp-improvements.js") {
    $jsLink = '  <script src="jpp-improvements.js"></script>' + "`r`n"
    $html = $html -replace '(?i)</body>', ($jsLink + '</body>')
    Write-Host "Added JS link" -ForegroundColor Green
}

# Add font if not present
if ($html -notmatch "fonts.googleapis.com") {
    $fontLinks = '  <link rel="preconnect" href="https://fonts.googleapis.com">' + "`r`n"
    $fontLinks += '  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>' + "`r`n"
    $fontLinks += '  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">' + "`r`n"
    $html = $html -replace '(?i)</head>', ($fontLinks + '</head>')
    Write-Host "Added Inter font" -ForegroundColor Green
}

$html | Out-File -FilePath "index.html" -Encoding UTF8

Write-Host ""
Write-Host "=============================" -ForegroundColor Green
Write-Host "Setup Complete!" -ForegroundColor Green  
Write-Host "=============================" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:"
Write-Host "1. Refresh browser (Ctrl+Shift+R)" -ForegroundColor Cyan
Write-Host "2. Check localhost:8000" -ForegroundColor Cyan
Write-Host "3. Commit and push:" -ForegroundColor Cyan
Write-Host "   git add ."
Write-Host "   git commit -m 'feat: site improvements'"
Write-Host "   git push origin main"
Write-Host ""
Write-Host "Done!" -ForegroundColor Magenta
