(defsystem "generate-feeder"
  :version "0.1.0"
  :author "Tim Hawes <trhawes@gmail.com>"
  :license "MIT"
  :depends-on ("cl-ppcre"
               "unix-opts")
  :components ((:module "src"
                :components
                ((:file "main")
                 (:file "generate-feeder"))))
  :description "Generates a metafile from a navbar.org file to feed into ChatGPT as uploaded project files."
  :build-operation "asdf:program-op"
  :build-pathname "target/generate-feeder"
  :entry-point "generate-feeder:-main"
  :in-order-to ((test-op (test-op "generate-feeder/tests"))))

(defsystem "generate-feeder/tests"
  :author "Tim Hawes <trhawes@gmail.com>"
  :license "MIT"
  :depends-on ("generate-feeder"
               "fiveam")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for generate-feeder"
  :perform (test-op (op c) (symbol-call :fiveam :run! (find-symbol* :all-tests :generate-feeder/tests))))
