(module cs105_io mzscheme
  
  (provide read-from-file write-to-file)
  
  ; read-from-file : file -> (listof TST)
  ; reads the contents of the given file as a list of values
  (define (read-from-file file)
    (with-input-from-file file
      (lambda ()
        (let loop ()
          (let ((l (read)))
            (cond
              [(eof-object? l) '()]
              [else (cons l (loop))]))))))
  
  ; write-to-file : (listof TST) string -> string
  ; writes the given list of values to the named file, where 'newline
  ; indicates a new line should be printed
  (define (write-to-file val-list file)
    
    (define (convert v)
      (cond
        [(string? v) v]
        [(and (symbol? v) (eq? v 'newline)) "\n"]
        [else (format "~s" v)]))
    
    (with-handlers ([exn:i/o? (lambda (e) (error 'write-in-file (exn-message e)))]) 
      (let ((op (open-output-file file)))
        (display (apply string-append (map convert val-list)) op)
        (close-output-port op))
      (format "SUCCESS: ~a succeeded" `(write-to-file ,val-list ,file)))))