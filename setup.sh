#!/bin/bash
# ============================================
# JPP Website - Automated Setup Script
# This script will automatically apply all improvements
# ============================================

echo "🎭 JPP Website - Automated Improvement Setup"
echo "============================================"
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if we're in the right directory
if [ ! -f "index.html" ]; then
    echo "${YELLOW}⚠️  Warning: index.html not found in current directory${NC}"
    echo "Please run this script from your project root directory"
    echo "Usage: cd /path/to/your/project && bash setup.sh"
    exit 1
fi

echo "${BLUE}📁 Found project files${NC}"
echo ""

# Create CSS file
echo "${BLUE}📝 Creating jpp-improvements.css...${NC}"
cat > jpp-improvements.css << 'EOFCSS'
/* JPP WEBSITE - COMPREHENSIVE IMPROVEMENTS */

/* Typography */
body {
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  line-height: 1.6;
  font-size: 16px;
}

h1 { font-size: 3rem !important; font-weight: 700 !important; line-height: 1.2 !important; margin-bottom: 24px !important; }
h2 { font-size: 2.5rem !important; font-weight: 700 !important; line-height: 1.3 !important; margin-bottom: 16px !important; }
h3 { font-size: 1.75rem !important; font-weight: 600 !important; line-height: 1.4 !important; }
p { margin-bottom: 1.5rem; font-size: 1.1rem; opacity: 0.9; }

/* Layout */
html { scroll-behavior: smooth; }
section { padding: 80px 20px !important; max-width: 1200px; margin: 0 auto; }
section:nth-child(even) { background: rgba(255, 255, 255, 0.02); }

/* Navigation */
nav {
  position: sticky !important;
  top: 0 !important;
  z-index: 1000 !important;
  background: rgba(0, 0, 0, 0.95) !important;
  backdrop-filter: blur(10px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
  transition: all 0.3s;
  padding: 16px 0;
}

nav.scrolled { padding: 12px 0; background: rgba(0, 0, 0, 0.98) !important; }
nav a { transition: all 0.3s; }
nav a:hover { color: #D946EF !important; }

/* Section Headers */
.section-header { text-align: center; margin-bottom: 60px; }
.section-header h2 {
  background: linear-gradient(135deg, #D946EF, #7C3AED);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}
.section-header p { font-size: 1.1rem; opacity: 0.8; max-width: 600px; margin: 0 auto; }

/* Buttons */
.cta-primary, a[href="#services"] {
  display: inline-block !important;
  padding: 16px 32px !important;
  background: linear-gradient(135deg, #D946EF, #7C3AED) !important;
  color: white !important;
  text-decoration: none !important;
  border-radius: 8px !important;
  font-weight: 600 !important;
  transition: all 0.3s ease !important;
  margin-top: 24px !important;
}

.cta-primary:hover, a[href="#services"]:hover {
  transform: translateY(-2px) !important;
  box-shadow: 0 12px 24px rgba(217, 70, 239, 0.3) !important;
}

/* Service Cards */
.services-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 32px; margin-top: 48px; }
#services > div > div {
  background: rgba(255, 255, 255, 0.05) !important;
  border: 1px solid rgba(255, 255, 255, 0.1) !important;
  border-radius: 16px !important;
  padding: 40px !important;
  transition: all 0.3s ease !important;
}

#services > div > div:hover {
  transform: translateY(-8px) !important;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3) !important;
  border-color: rgba(217, 70, 239, 0.5) !important;
}

/* Gallery */
.gallery-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 16px; margin-top: 48px; }
#gallery img {
  object-fit: cover !important;
  width: 100% !important;
  height: 100% !important;
  transition: transform 0.5s ease !important;
}

#gallery > div > div {
  position: relative;
  overflow: hidden;
  border-radius: 12px;
  aspect-ratio: 4/3;
  cursor: pointer;
}

#gallery > div > div:hover img { transform: scale(1.1) !important; }

/* Merch Cards */
#merch-cards article {
  background: rgba(255, 255, 255, 0.03) !important;
  border: 1px solid rgba(255, 255, 255, 0.1) !important;
  border-radius: 12px !important;
  overflow: hidden !important;
  transition: all 0.3s !important;
}

#merch-cards article:hover {
  transform: translateY(-4px) !important;
  box-shadow: 0 12px 24px rgba(0, 0, 0, 0.3) !important;
  border-color: rgba(217, 70, 239, 0.3) !important;
}

#merch-cards a[href*="stripe"], #merch-cards a[href*="themlc"] {
  background: linear-gradient(135deg, #D946EF, #7C3AED) !important;
  color: white !important;
  padding: 10px 20px !important;
  border-radius: 6px !important;
  font-weight: 600 !important;
  text-decoration: none !important;
}

/* Contact */
#contact {
  background: linear-gradient(135deg, rgba(217, 70, 239, 0.05), rgba(124, 58, 237, 0.05)) !important;
  border-radius: 16px !important;
  padding: 60px 40px !important;
}

#contact a {
  display: inline-flex !important;
  align-items: center !important;
  padding: 12px 20px !important;
  background: rgba(255, 255, 255, 0.05) !important;
  border-radius: 8px !important;
  transition: all 0.3s !important;
}

#contact a:hover {
  background: rgba(217, 70, 239, 0.2) !important;
  transform: translateX(4px) !important;
}

/* Scroll to top button */
.scroll-to-top {
  position: fixed;
  bottom: 30px;
  right: 30px;
  width: 50px;
  height: 50px;
  border-radius: 50%;
  background: linear-gradient(135deg, #D946EF, #7C3AED);
  color: white;
  border: none;
  font-size: 24px;
  cursor: pointer;
  opacity: 0;
  transform: scale(0);
  transition: all 0.3s;
  z-index: 1000;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
}

.scroll-to-top.visible { opacity: 1; transform: scale(1); }
.scroll-to-top:hover { transform: scale(1.1) !important; box-shadow: 0 6px 20px rgba(217, 70, 239, 0.4); }

/* Animations */
@keyframes fadeInUp { from { opacity: 0; transform: translateY(30px); } to { opacity: 1; transform: translateY(0); } }
.fade-in-section { opacity: 0; transform: translateY(30px); transition: opacity 0.6s ease-out, transform 0.6s ease-out; }
.fade-in-section.visible { opacity: 1; transform: translateY(0); }

/* Hide project links section */
section:has(h2:contains("Project & Studio Links")) { display: none !important; }

/* Responsive */
@media (max-width: 768px) {
  h1 { font-size: 2rem !important; }
  h2 { font-size: 1.75rem !important; }
  h3 { font-size: 1.5rem !important; }
  section { padding: 60px 16px !important; }
}
EOFCSS

echo "${GREEN}✅ Created jpp-improvements.css${NC}"

# Create JavaScript file
echo "${BLUE}📝 Creating jpp-improvements.js...${NC}"
cat > jpp-improvements.js << 'EOFJS'
// JPP Website - JavaScript Improvements
document.addEventListener('DOMContentLoaded', function() {
  
  // Sticky navigation
  const nav = document.querySelector('nav');
  window.addEventListener('scroll', () => {
    if (window.pageYOffset > 100 && nav) {
      nav.classList.add('scrolled');
    } else if (nav) {
      nav.classList.remove('scrolled');
    }
  });
  
  // Scroll to top button
  const scrollBtn = document.createElement('button');
  scrollBtn.className = 'scroll-to-top';
  scrollBtn.innerHTML = '↑';
  scrollBtn.onclick = () => window.scrollTo({ top: 0, behavior: 'smooth' });
  document.body.appendChild(scrollBtn);
  
  window.addEventListener('scroll', () => {
    if (window.pageYOffset > 300) {
      scrollBtn.classList.add('visible');
    } else {
      scrollBtn.classList.remove('visible');
    }
  });
  
  // Scroll animations
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
      }
    });
  }, { threshold: 0.1, rootMargin: '0px 0px -50px 0px' });
  
  document.querySelectorAll('section').forEach((section, index) => {
    if (index > 0) {
      section.classList.add('fade-in-section');
      observer.observe(section);
    }
  });
  
  // Hide project links section
  const sections = Array.from(document.querySelectorAll('section'));
  const projectLinks = sections.find(s => s.textContent.includes('Project & Studio Links'));
  if (projectLinks) projectLinks.style.display = 'none';
  
  // Gallery overlays
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
  
  // Smooth scroll for anchor links
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      const href = this.getAttribute('href');
      if (href === '#') return;
      e.preventDefault();
      const target = document.querySelector(href);
      if (target) target.scrollIntoView({ behavior: 'smooth', block: 'start' });
    });
  });
  
  console.log('🎭 JPP Improvements Loaded');
});
EOFJS

echo "${GREEN}✅ Created jpp-improvements.js${NC}"

# Add CSS link to HTML if not already present
echo ""
echo "${BLUE}📝 Updating index.html...${NC}"

if ! grep -q "jpp-improvements.css" index.html; then
    # Add CSS link before </head>
    sed -i.bak 's|</head>|  <link rel="stylesheet" href="jpp-improvements.css">\n</head>|' index.html
    echo "${GREEN}✅ Added CSS link to index.html${NC}"
else
    echo "${YELLOW}ℹ️  CSS link already exists in index.html${NC}"
fi

if ! grep -q "jpp-improvements.js" index.html; then
    # Add JS link before </body>
    sed -i.bak 's|</body>|  <script src="jpp-improvements.js"></script>\n</body>|' index.html
    echo "${GREEN}✅ Added JS link to index.html${NC}"
else
    echo "${YELLOW}ℹ️  JS link already exists in index.html${NC}"
fi

# Add Inter font if not present
if ! grep -q "fonts.googleapis.com.*Inter" index.html; then
    sed -i.bak 's|</head>|  <link rel="preconnect" href="https://fonts.googleapis.com">\n  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>\n  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700\&display=swap" rel="stylesheet">\n</head>|' index.html
    echo "${GREEN}✅ Added Inter font to index.html${NC}"
else
    echo "${YELLOW}ℹ️  Inter font already in index.html${NC}"
fi

echo ""
echo "${GREEN}============================================${NC}"
echo "${GREEN}✨ Setup Complete!${NC}"
echo "${GREEN}============================================${NC}"
echo ""
echo "Next steps:"
echo "1. ${BLUE}Refresh your browser${NC} (Cmd/Ctrl + Shift + R)"
echo "2. ${BLUE}Test all improvements${NC}"
echo "3. ${BLUE}Commit changes:${NC}"
echo "   git add ."
echo "   git commit -m 'feat: implement comprehensive site improvements'"
echo "   git push origin main"
echo ""
echo "Created files:"
echo "  ✅ jpp-improvements.css"
echo "  ✅ jpp-improvements.js"
echo "  ✅ index.html.bak (backup)"
echo ""
echo "🎉 Your site is now improved!"
echo ""
