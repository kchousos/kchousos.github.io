$(function() {
   $("a[href^='http']:not([href*='kchousos.github.io'])").each(function() {
       $(this).click(function(event) {
             event.preventDefault();
             event.stopPropagation();
             window.open(this.href, '_blank');
        }).addClass('externalLink');
   });
});
