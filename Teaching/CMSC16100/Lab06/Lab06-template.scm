;; Author:
;; Date: October 29, 2007
;; Class: CMSC 16100
;; PLT-Scheme language: Pretty Big

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load Modules
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require "CMSC161_io.ss")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Insertion Sort
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; insert
;; Contract: list_item sorted_list comare_func -> list (including list_item)
;; Purpose:  Take an element that belongs in the sorted list and put it in the
;;           correct position.
;; Example: (insert 2 '(1 4) (lambda (x y) (if (< x y) 1 -1))) -> '(1 2 4)


;; insertion_sort
;; Contract:list compare_func -> sorted_list
;; Purpose: Sort a list using the insertion sort algorithm.  
;;          The compare_func is a function that takes two inputs and returns 
;;          either -1, 0, or 1. The algorithm sorts such that 1 means greater 
;;          than, 0 equal to, and -1 less than
;; Example: (insertion_sort '(1 4 3) (lambda (x y) (if (< x y) -1 1))) -> '(1 3 4)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Quick Sort
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; quick_sort
;; Contract: list compare_func -> sorted_list
;; Purpose: Sort a list using the quicksort algorithm.  
;;          The compare_func is a function that takes two inputs and returns 
;;          either -1, 0, or 1. The algorithm sorts such that 1 means greater 
;;          than, 0 equal to, and -1 less than
;; Example: (quick_sort '(1 4 3) (lambda (x y) (if (< x y) -1 1))) -> '(1 3 4)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Merge Sort
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; merge
;; Contract: sorted_list sorted_list compare_func -> sorted_list
;; Purpose:  Takes two sorted list and a compare function (which was used to 
;;           sort the list), merges the two lists based on the compare function
;;           and returns a sorted_list consisting of the two inputted list
;; Example: (merge '(1 3) '(2) (lambda (x y) (if (< x y) -1 1))) -> '(1 2 3)

;; list-head
;; Contract: list int -> list
;; Purpose:  Returns a list for the first n members of the inputed list, 
;;           Will cause an error if the list does not have n elements.
;; Example: (list-head '(1 2 3 4) 2) -> '(1 2)

;; merge_sort
;; Contract: list compare_func -> sorted_list
;; Purpose: Sort a list using the merge sort algorithm.  
;;          The compare_func is a function that takes two inputs and returns 
;;          either -1, 0, or 1. The algorithm sorts such that 1 means greater 
;;          than, 0 equal to, and -1 less than
;; Example: (merge_sort '(1 4 3) (lambda (x y) (if (< x y) -1 1))) -> '(1 3 4)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Binary Search Tree
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; bstree structure
;; Consists of: entry, left, right 
;; where: entry is an entry structure of the node
;;        left is the left branch of node (which is a bstree)
;;        right is the right branch of node (which is a bstree)
(define-struct bstree (ent left right))

;; entry structure
;; Consists of: value cnt
;; where: value is some value of any type
;;        cnt is the count of the number of identical elements.
(define-struct entry (value cnt))

;; add_value
;; Contract: bstree value compare_function -> bstree
;; Purpose:  Add a value to the bstree in an appropriate place based
;;           upon the compare_function

;; list->bstree
;; Contract: list compare_function -> bstree
;; Purpose:  To build a bstree from a list based upon the compare function
;; Example: (list->bstree '(1 2 3) cmp) -> bstree
            
;; bstree->list
;; Contract: bstree -> list
;; Purpose:  Take a bstree, traverse it from left to right putting the output in
;;           a list.
;; Example: (bstree->list (list->bstree '(2 1 3) cmp)) -> '(1 2 3)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              Test Cases                                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Some Test Define's
(define (cmp x y) 
  (cond ((< x y) 1)
        ((> x y) -1)
        (else 0)))

(define the_list '(1 3 2 7 6 4 6 5 3 4 6))

(define str_list (list "grape" "kiwi" "peach" "pear" "banana" "grapefruit" 
                       "pear" "apple" "orange" "grape" "pear" "apple"  "kiwi"
                       "peach" "pear" "banana" "grapefruit" "banana" 
                       "grapefruit" "banana" "grapefruit" "banana" "grapefruit"))

(define (cnt_cmp x y)
  (cmp (entry-cnt x) (entry-cnt y)))

(define (str_cmp x y) 
  (cond ((string<? x y) 1)
        ((string>? x y) -1)
        (else 0)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Testing Functions
(insert 2 '(1 4) cmp)
;(insertion_sort the_list cmp)
;(quick_sort the_list cmp)
;(merge '(1 3 5) '(2 4 6) cmp)
;(list-head '(1 2 3 4 5) 2)
;(merge_sort the_list cmp)
;(add_value (add_value (add_value null 3 cmp) 1 cmp) 3 cmp)
;(list->bstree the_list cmp)
;(bstree->list (list->bstree the_list cmp))
;(map (lambda (a) (cons (entry-value a) (entry-cnt a))) 
;     (bstree->list (list->bstree the_list cmp)))

;(insertion_sort str_list str_cmp)
;(quick_sort str_list str_cmp)
;(merge_sort str_list str_cmp)
;(map (lambda (a) (entry-value a)) (bstree->list (list->bstree str_list str_cmp)))
;(map (lambda (a) (entry-value a)) (quick_sort (bstree->list (list->bstree str_list str_cmp)) cnt_cmp))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Counting hamlet

;; Note: Omitting insertion sort because it takes too long. (Do you know why?)
;;(time (length (insertion_sort (file->string_list "shakespeare/tragedies/hamlet") str_cmp)))
;(time (length (quick_sort (file->string_list "shakespeare/tragedies/hamlet") str_cmp)))
;(time (length (merge_sort (file->string_list "shakespeare/tragedies/hamlet") str_cmp)))
;(time (length (bstree->list (list->bstree (file->string_list "shakespeare/tragedies/hamlet") str_cmp))))

;(list-head (list-tail 
;            (map (lambda (a) (cons (entry-value a) (entry-cnt a))) 
;                 (merge_sort (bstree->list 
;                              (list->bstree 
;                               (file->string_list "hamlet") 
;                               str_cmp)) 
;                             cnt_cmp))
;            7800) 10)