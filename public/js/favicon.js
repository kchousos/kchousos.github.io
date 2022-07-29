const faviconTag = document.getElementById("faviconTag");
const isDark = window.matchMedia("(prefers-color-scheme: dark)");

const changeFavicon = () => {
  if (isDark.matches) faviconTag.href = "icons/icon-dark.png";
  else faviconTag.href = "icons/icon-light.png";
};

changeFavicon();

setInterval(changeFavicon, 1000);
