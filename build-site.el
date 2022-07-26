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
(setq org-html-htmlize-output-type 'css)

;; Load the publishing system
(require 'ox-publish)

;; Customize the HTML output
(setq org-html-validation-link nil            ;; Don't show validation link
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-head
      "<link rel=\"stylesheet\" href=\"https://gongzhitaao.org/orgcss/org.css\" />"
      org-html-postamble
      "<p>Written %C.</p>
       <p>Made with <a href=\"https://www.gnu.org/software/emacs/\">Emacs</a>,
                    <a href=\"https://orgmode.org/\">Org Mode</a> and
                    <a href=\"https://github.com/gongzhitaao/orgcss\">Orgcss</a>.</p>")

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "blog:main"
             :recursive t
             :base-directory "./content"
             :publishing-function 'org-html-publish-to-html
             :publishing-directory "./public"
             ;; :with-author nil           ;; Don't include author name
             ;; :with-creator nil          ;; Include Emacs and Org versions in footer
             :with-toc nil              ;; Include a table of contents
             :section-numbers nil       ;; Don't include section numbers
             ;; :time-stamp-file nil       ;; Don't include time stamp in file
             )))

;; Generate the site output
(org-publish-all t)

(message "Build complete!")
