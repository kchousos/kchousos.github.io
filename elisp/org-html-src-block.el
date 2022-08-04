(defun my/org-html-src-block (html)
  (replace-regexp-in-string
   "</pre>" "</code></pre>"
   (replace-regexp-in-string
    "<pre class=\"src src-\\(.*\\)\">"
    "<pre><code class=\"language-\\1\">"
    html)))
