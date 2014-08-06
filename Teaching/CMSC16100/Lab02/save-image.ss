(module save-image mzscheme
  (require (lib "class.ss")
           (lib "mred.ss" "mred"))
  
  (provide save-image)
  
  (define (fix b) (inexact->exact (ceiling (unbox b))))

  ; save-image : tst[snip%] string symbol -> bool
  ; saves img to filename with format type
  (define (save-image img filename type)
    (define acceptable-types '(png xbm xpm))
    (define (oops str idx) (raise-type-error 'save-image str idx img filename type))
    
    (when (not (is-a? img snip%))
      (oops "image" 0))
    (when (not (string? filename))
      (oops "string" 1))
    (when (not (memq type acceptable-types))
      (oops (format "symbol in ~a" acceptable-types) 2))

    (let* ((bits-dc (new bitmap-dc% (bitmap (make-object bitmap% 1 1))))
           (w (box 0))
           (h (box 0))
           (_ (send img get-extent bits-dc 0 0 w h #f #f #f #f))
           (bitmap (make-object bitmap% (fix w) (fix h))))
      (begin
        (send bits-dc set-bitmap bitmap)
        (send img draw bits-dc 0 0 0 0 (fix w) (fix h) 0 0 'no-caret)
        (send bitmap save-file filename type)))))
       