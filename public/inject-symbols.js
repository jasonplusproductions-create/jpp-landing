(() => {
  fetch('/symbols.svg')
    .then(r => r.text())
    .then(svg => {
      const wrap = document.createElement('div');
      wrap.style.display = 'none';
      wrap.innerHTML = svg;
      document.body.prepend(wrap);
    })
    .catch(console.error);
})();
