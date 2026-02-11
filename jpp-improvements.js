document.addEventListener('DOMContentLoaded', function() {
  const nav = document.querySelector('nav');
  window.addEventListener('scroll', () => {
    if (window.pageYOffset > 100 && nav) nav.classList.add('scrolled');
    else if (nav) nav.classList.remove('scrolled');
  });
  const scrollBtn = document.createElement('button');
  scrollBtn.className = 'scroll-to-top';
  scrollBtn.innerHTML = 'â†‘';
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
