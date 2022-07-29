let links = document.querySelectorAll('a');

links.forEach((a) => {
  a.addEventListener('click', () => {
    a.hostname === location.hostname ? a.target = '_self' : a.target = '_blank';
  });
});
