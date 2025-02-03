(in-package :generate-feeder)

(ql:quickload :cl-ppcre)

(defun convert-org-file (input-file output-file)
  (with-open-file (in input-file :direction :input)
    (with-open-file (out output-file :direction :output :if-exists :supersede)
      (format out "#+title: Master Feeder File~%#+options: toc:nil~%~%* Master Feeder File~%")
      (loop for line = (read-line in nil nil)
            while line
            do (cond
                 ;; Convert section headers
                 ((cl-ppcre:register-groups-bind (section)
                      ("^#\\+HTML: <button class=\"dropdown-btn\" id=\"([^\"]+)\">" line)
                    (format out "~%** ~A~%~%" section)))

                 ;; Convert file links to #+include statements
                 ((cl-ppcre:register-groups-bind (file-path)
                      ("- \\[\\[file:([^]]+?)\\]\\[[^]]+\\]\\]" line)
                    (format out "#+include: \"../org/~A\"~%" file-path)))

                 ;; Ignore other lines (e.g., HTML divs, properties)
                 (t nil))))))
