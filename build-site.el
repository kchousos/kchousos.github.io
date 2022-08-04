;; ;; Set the package installation directory so that packages aren't stored in the
;; ;; ~/.emacs.d/elpa path.
;; (require 'package)
;; (setq package-user-dir (expand-file-name "./.packages"))
;; (setq package-archives '(("melpa" . "https://melpa.org/packages/")
;;                          ("elpa" . "https://elpa.gnu.org/packages/")))

;; ;; Initialize the package system
;; (package-initialize)
;; (unless package-archive-contents
;;   (package-refresh-contents))

;; ;; Install dependencies
;; (package-install 'htmlize)
(setq org-html-htmlize-output-type nil)

(require 'ox-publish)
(require 'ox-html)

(add-to-list 'load-path "./elisp/")
(require 'load-directory)
(load-directory "./elisp")
(advice-add 'org-html-src-block :filter-return #'my/org-html-src-block)

;; Customize the HTML output
(setq org-html-validation-link nil            ;; Don't show validation link
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-metadata-timestamp-format "%A, %d %b %Y"
      org-html-head (file-to-string "html/head.html")
      org-html-preamble (file-to-string "html/preamble.html")
      org-html-postamble (file-to-string "html/postamble.html")
)

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "site"
             :recursive t
             :base-directory "./content"
             :publishing-function 'org-html-publish-to-html
             :publishing-directory "./public"
             :html-format-headline-function 'my-org-html-format-headline-function
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
