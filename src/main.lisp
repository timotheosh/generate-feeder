(defpackage generate-feeder
  (:use :cl)
  (:export :-main))
(in-package :generate-feeder)

(opts:define-opts
  (:name :help
   :description "print this help text"
   :short #\h
   :long "help"))

(defun unknown-option (condition)
  (format t "warning: ~s option is unknown!~%" (opts:option condition))
  (invoke-restart 'opts:skip-option))

(defun -main (&rest args)
  (declare (ignorable args))
  (multiple-value-bind (options args)
      (handler-case
          (handler-bind ((opts:unknown-option #'unknown-option))
            (opts:get-opts)))
    (cond ((getf options :help) 
           (progn (opts:describe
                   :prefix (format nil "generate-feeder Generates a metafile from a navbar.org file to feed into ChatGPT as uploaded project files.")
                   :usage-of "generate-feeder INPUT")
                  (opts:exit 1)))
          ((not (= (length args) 2))
           (progn (format t "Can only process two arguments! ")
                  (opts:describe
                   :prefix (format nil "generate-feeder Generates a metafile from a navbar.org file to feed into ChatGPT as uploaded project files.")
                   :usage-of "generate-feeder INPUTFILE OUTPUTFILE")
                  (opts:exit 1)))
          (t 
           (format t "Generating feeder file...")
           (convert-org-file (pathname (first args)) (pathname (second args)))))))
