(module CMSC161_io mzscheme
  
  (provide string-split file->string_list)
  
  (define (string-split str . rest)
    ; maxsplit is a positive number
    (define (split-by-whitespace str maxsplit)
      (define (skip-ws i yet-to-split-count)
        (cond
          ((>= i (string-length str)) '())
          ((char-whitespace? (string-ref str i))
           (skip-ws (+ 1 i) yet-to-split-count))
          (else (scan-beg-word (+ 1 i) i yet-to-split-count))))
      (define (scan-beg-word i from yet-to-split-count)
        (cond
          ((zero? yet-to-split-count)
           (cons (substring str from (string-length str)) '()))
          (else (scan-word i from yet-to-split-count))))
      (define (scan-word i from yet-to-split-count)
        (cond
          ((>= i (string-length str))
           (cons (substring str from i) '()))
          ((char-whitespace? (string-ref str i))
           (cons (substring str from i) 
                 (skip-ws (+ 1 i) (- yet-to-split-count 1))))
          (else (scan-word (+ 1 i) from yet-to-split-count))))
      (skip-ws 0 (- maxsplit 1)))
    
    ; maxsplit is a positive number
    ; str is not empty
    (define (split-by-charset str delimeters maxsplit)
      (define (scan-beg-word from yet-to-split-count)
      (cond
        ((>= from (string-length str)) '(""))
        ((zero? yet-to-split-count)
         (cons (substring str from (string-length str)) '()))
        (else (scan-word from from yet-to-split-count))))
      (define (scan-word i from yet-to-split-count)
        (cond
          ((>= i (string-length str))
           (cons (substring str from i) '()))
          ((memq (string-ref str i) delimeters)
           (cons (substring str from i) 
                 (scan-beg-word (+ 1 i) (- yet-to-split-count 1))))
          (else (scan-word (+ 1 i) from yet-to-split-count))))
      (scan-beg-word 0 (- maxsplit 1)))
    
    ; resolver of overloading...
    ; if omitted, maxsplit defaults to
    ; (inc (string-length str))
    (if (equal? str "") '()
        (if (null? rest) 
            (split-by-whitespace str (+ 1 (string-length str)))
            (let ((charset (car rest))
                  (maxsplit
                   (if (pair? (cdr rest)) (cadr rest) (+ 1 (string-length str)))))
              (cond
                ((not (positive? maxsplit)) '())
                ((null? charset) (split-by-whitespace str maxsplit))
                (else (split-by-charset str charset maxsplit))))))
    )

  (define (foldr op init alist)
    (if (null? alist) init
        (op (car alist) (foldr op init (cdr alist)))))
    
  (define (file->string_list file)
    (define list_of_string_lists
           (with-input-from-file file
             (lambda ()
               (let loop ()
                 (let ((l (read-line)))
                   (cond
                     [(eof-object? l) '()]
                     [else (cons (string-split l) (loop))]))))))
    (foldr (lambda (sl bl) (append sl bl)) '() list_of_string_lists)))


