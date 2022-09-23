(defun spook-org--export-yt-link (path desc backend)
  (when (eq backend 'html)
    (let* ((video-id (cadar (url-parse-query-string path)))
           (url (if (string-empty-p video-id) path
                  (format "https://youtube.com/embed/%s" video-id))))
      (format
       "<iframe width=\"1000\" height=\"562.5\" src=\"%s\" title=\"%s\" frameborder=\"0\" allowfullscreen></iframe>"
       url desc))))

(org-link-set-parameters "yt" :follow #'spook-org--follow-yt-link :export #'spook-org--export-yt-link)
