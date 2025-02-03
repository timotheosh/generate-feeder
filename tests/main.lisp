(defpackage generate-feeder/tests
  (:use :cl
        :generate-feeder
        :fiveam))
(in-package :generate-feeder/tests)

;; NOTE: To run this test file, execute `(asdf:test-system :generate-feeder)' in your Lisp.
;; 

(def-suite all-tests
  :description "The master suite of all run-testing tests.")

(in-suite all-tests)

(test dummy-tests
  "Some fake tests. You should add your own i.e. (is (= (generate-feeder::some-function 2) 5)"
  (is (listp (list 1 2)))
  (is (= 5 (+ 2 3))))
  
