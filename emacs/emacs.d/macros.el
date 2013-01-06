(defmacro after (mode &rest body)
  `(eval-after-load ,mode
     '(progn ,@body)))
