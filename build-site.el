;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path.
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)
(setq org-html-htmlize-output-type 'nil)

(require 'ox-publish)
(require 'ox-html)

;; ; Makes code blocks compatible with highlight.js
(defun my/org-html-src-block (html)
  "Modify the output of org-html-src-block for highlight.js."
  (replace-regexp-in-string
   "</pre>" "</code></pre>"
   (replace-regexp-in-string
    "<pre class=\"src src-\\(.*\\)\">"
    "<pre><code class=\"\\1\">"
    html)))
(advice-add 'org-html-src-block :filter-return #'my/org-html-src-block)

;; Customize the HTML output
(setq org-html-validation-link nil            ;; Don't show validation link
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-metadata-timestamp-format "%A, %d %b %Y"
      org-html-head
      "<link rel=\"stylesheet\" href=\"/css/normalize.css\" type=\"text/css\">
       <link rel=\"stylesheet\" href=\"/css/sakura.css\" media=\"screen\" />
       <link rel=\"stylesheet\" href=\"/css/sakura-dark.css\" media=\"screen and (prefers-color-scheme: dark)\" />
       <link rel=\"stylesheet\" href=\"/css/mine.css\" type=\"text/css\">

       <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css\">

       <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.6.0/styles/base16/papercolor-light.min.css\" media=\"screen\" />
       <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.6.0/styles/base16/papercolor-dark.min.css\" media=\"screen and (prefers-color-scheme: dark)\" />

       <link rel=\"shortcut icon\" type=\"image/x-icon\" href=\"/icons/icon-light.png\" id=\"faviconTag\"/>

       <script type=\"text/javascript\">
            document.title += \" | Konstantinos Chousos\";
       </script>"
      
      org-html-preamble
      "<b>Konstantinos Chousos</b>
       <nav>
       		<a href=\"/\"> <i class=\"fa fa-home\"></i> Home </a> |
       		<a href=\"/articles.html\"> <i class=\"fa fa-book\"></i> Articles </a> |
       		<a href=\"/about.html\"> <i class=\"fa fa-user\"></i> About </a> |
       		<a href=\"https://github.com/kchousos\"> <i class=\"fa fa-github\"></i> Github </a>
       <nav>"

      org-html-postamble
      ;; <script src=\"https://cdn.jsdelivr.net/npm/highlightjs-line-numbers.js/dist/highlightjs-line-numbers.min.js\"></script>
      ;; <script>hljs.initLineNumbersOnLoad();</script>

      "<hr>
       <center>
           <p>Made with <a href=\"https://www.gnu.org/software/emacs/\">Emacs</a>,
                        <a href=\"https://orgmode.org/\">Org Mode</a> and
                        <a href=\"https://github.com/oxalorg/sakura\">Sakura</a>
                        <br>Last edited: %C
           </p>
       </center>

       <script src=\"https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.6.0/highlight.min.js\"></script>
       <script src=\"https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.6.0/languages/lisp.min.js\"></script>
       <script src=\"/js/my_highlight.js\"></script>

       <script src=\"/js/favicon.js\"></script>
       <script src=\"/js/external_links.js\"></script>")

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "site:main"
             :recursive t
             :base-directory "./content"
             :publishing-function 'org-html-publish-to-html
             :publishing-directory "./public"
             ;; :htmlized-source nil
             ;; :with-author nil           ;; Don't include author name
             ;; :with-creator nil          ;; Include Emacs and Org versions in footer
             :with-toc nil              ;; Include a table of contents
             :section-numbers nil       ;; Don't include section numbers
             ;; :time-stamp-file nil       ;; Don't include time stamp in file
             )))

;; Generate the site output
(org-publish-all t)

(message "Build complete!")
