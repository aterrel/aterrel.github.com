;; Author: Andy R Terrel
;; Date: October 29, 2007
;; Class: CMSC 16100
;; Scheme language: Pretty Big

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load Modules
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require (lib "url.ss" "net") (lib "html.ss" "html") (lib "xml.ss" "xml"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Function Definitions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Contract: string -> list of html elements
;; Purpose: given a string, get-web-page-exp will return a list of html elements
(define (get-web-page-exp url-string)
  (display "Processing: ")
  (display url-string)
  (newline)
   (map xml->xexpr
        (read-html-as-xml (get-pure-port (string->url url-string)))))

;; Contract: xml-list list-of-hrefs --> list-of-hrefs
;; Purpose: given the xml-list produce a list of hrefs
(define (find-hrefs xml-list curr_list)
  "edit me"
  )

;; Contract: url-string --> pair-hrefs-and-emails
;; Purpose: given the url-string of a webpage, return a pair of links and email address from
;;          that webpage.
(define (process webpage)
  "edit me"
)
         

;; Contract: href_list url_string --> list-of-absolutely-addressed-url-strings
;; Purpose: given a list of href_lists and a url-string of a webpage, return a list of
;;          absolutely addressed url-strings
(define (hrefs->absolute href_list url-string)
  "edit me"
)
             
;; Contract: href_list --> href_list
;; Purpose: given a list of hrefs gives back the sublist of email addresses
(define (hrefs->mailtos href_list)
  "edit me"
 )
 
;; Contract: url-string int -> list-of-emails
;; Purpose: Given a url-string and a number of webpages to process, returns a list of email addresses.
(define (spider url-string count)
  "edit me"
)
                        
       
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Test Cases
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(define my_home (get-web-page-exp "http://people.cs.uchicago.edu/~aterrel/"))
;(define my_hrefs (find-hrefs my_home '()))
;(process "http://people.cs.uchicago.edu/~aterrel/")
;(spider "http://chicago.craigslist.org/acc/" 100)
(spider "http://www.slashdot.com/" 100)
;(spider "http://groups.google.com/group/comp.lang.scheme/topics/" 100)
;(spider "http://www.cs.uchicago.edu/" 25)
;(spider "http://www.cnn.com/" 250)

