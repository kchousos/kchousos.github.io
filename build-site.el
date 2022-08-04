(setq org-html-htmlize-output-type nil)

(require 'ox-publish)
(require 'ox-html)

(add-to-list 'load-path "./elisp/")
(require 'load-directory)
(load-directory "./elisp")
(advice-add 'org-html-src-block :filter-return #'my/org-html-src-block)

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "site"
             :recursive t
             :base-directory "./content"
             :publishing-function 'org-html-publish-to-html
             :publishing-directory "./public"
             :html-format-headline-function 'my-org-html-format-headline-function
             :with-toc nil
             :section-numbers nil
	         :html-head-include-default-style nil
		     :html-head-include-scripts nil
             :html-validation-link nil
             :html-metadata-timestamp-format "%A, %d %b %Y"
             :html-head (file-to-string "html/head.html")
             :html-preamble (file-to-string "html/preamble.html")
             :html-postamble (file-to-string "html/postamble.html")
             )))
 
;; Generate the site output
(org-publish-all t)

(message "Build complete!")
