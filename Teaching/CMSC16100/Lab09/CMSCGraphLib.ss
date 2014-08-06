;; Andy Terrel
;; CMSC 16100
;; November 12, 2007
;; Scheme Language: Pretty Big

(require (lib "image.ss" "htdp"))
;;;;;;;; Helper Functions ;;;;;;;;;;;
(define (member? element list)
  (cond [(null? list) #f]
        [(equal? (car list) element) #t]
        [else (member? element (cdr list))]))

(define (union list1 list2)
  (cond [(null? list1) list2]
        [(null? list2) list1]
        [else (if (member? (car list2) list1) (union list1 (cdr list2))
                  (union (cons (car list2) list1) (cdr list2)))]))           

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;           Node Operations                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Contract: name, list of names -> node
;; Purpose: makes node for graph
(define (make-node name neighbors)
  (list 'node name neighbors))

;; Contract: name, list of names -> node
;; Purpose: Given an edgelist, make a node from it
(define (make-node-from-edgelist name edgelist)
  (let ((neighbors (foldr (lambda (a b) (append (cond [(equal? name (car a)) (list (cadr a))]
                                                      [(equal? name (cadr a)) (list (car a))]
                                                      [else '()]) 
                                                b)) '() edgelist)))
    (make-node name neighbors)))

;; Contract: node -> name
;; Purpose: gives the name of a node
(define (node-name node)
  (if (node? node) (cadr node) 
      (error "node-name: expects node got " node)))

;; Contract: node -> list of names
;; Purpose: give a list of neighbors for a node
(define (node-neighbors node)
  (if (node? node) (caddr node)
      (error "node-neighbors: expects node got " node)))

;; Contract: obj -> boolean
;; Purpose: tells whether an object is a node 
(define (node? node)
  (and (list? node) (eq? (car node) 'node)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;          Graph Operations                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Contract: list of names, list of name pairs -> graph
;; Purpose: make a graph from a vertex list and an edgelist
(define (make-graph nodelist edgelist)
  (cons 'graph (foldr (lambda (a b) (cons (make-node-from-edgelist a edgelist) b)) '() nodelist)))

;; Contract: name, graph -> node
;; Purpsoe: returns node with given name in a graph
(define (graph-node name graph)
  (cond [(not (graph? graph)) (error "graph-node: expects graph got " graph)]
        [(<= (length graph) 1) (error "graph-node: node not in graph, given " name)]
        [(equal? name (node-name (cadr graph))) (cadr graph)]
        [else (graph-node name (cons 'graph (cddr graph)))]))

;; Contract: obj -> boolean
;; Purpose: tells whether an object is a graph
(define (graph? graph)
  (and (list? graph) (eq? (car graph) 'graph)))

;; Contract: graph -> list of nodes
;; Purpose: returns all the nodes in graph
(define (graph-nodelist graph)
  (if (graph? graph) (cdr graph)
      (error "graph-nodelist: expects graph got " graph)))

;; Contract: graph -> list of name pairs
;; Purpose: returns all edges from a graph
(define (graph-edgelist graph)
  ;; A table structure to keep track of edges we have already processed
  ;; this allows us not to repeat entries in our edgelist
  (define (build-table graph fill)
    (foldr (lambda (a b) (cons (cons (node-name a) fill) b)) '() (graph-nodelist graph)))
  ;; A accessor for the table
  (define (table-ref nname table)
    (let ((ref (filter (lambda (a) (equal? (car a) nname)) table)))
      (if (null? ref) (error "table-ref: name not in table arguments --" nname table)
          (car ref))))
  (let ((visited-edges (build-table graph '())))
    (for-each 
     (lambda (n) 
       (set-cdr! (table-ref (node-name n) visited-edges)
                 (filter (lambda (nn) 
                           (not (member? (node-name n) (table-ref nn visited-edges))))
                         (node-neighbors n))))
     (graph-nodelist graph))
    (foldr (lambda (vn el) 
             (append (foldr (lambda (n nl) (cons (cons (car vn) n) nl)) '() (cdr vn)) el))
           '() visited-edges)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;           Graph->Image                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Contract: list of edges, image, node position function -> image
;; Purpose: Draws the edges of a graph on the image
(define (edgelist->image el imag node_pos)
  (foldr (lambda (e im) (add-line im
                                  (posn-x (node_pos (car e)))
                                  (posn-y (node_pos (car e)))
                                  (posn-x (node_pos (cdr e)))
                                  (posn-y (node_pos (cdr e)))
                                  'black))
         imag
         el))

;; Contract: list of nodes, image, node position function -> image
;; Purpose: Draws the nodes of a graph on the image
(define (nodelist->image nl imag node_pos)
  (foldr (lambda (n im) (overlay/xy im
                                    (posn-x (node_pos (node-name n)))
                                    (posn-y (node_pos (node-name n)))
                                    (circle 10 'solid 'black)
                                    ))
         imag
         nl))
                                   
;; Contract: graph function (name->pair of ints)  -> image
;; Purpose: Draws an image of a graph given a way to place the nodes
(define (graph->image graph node_pos)
  (let ((edges_img (edgelist->image (graph-edgelist graph) 
                                    (rectangle 1 1 'solid 'white)
                                    node_pos)))
    (nodelist->image (graph-nodelist graph) edges_img node_pos)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;          Dijkstra's Algorithm                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Contract: graph node -> list
;; Purpose: given a graph and a node it returns the minimum spanning tree of 
;;          the graph with the node as the source in the form of node , parent pairs
(define (Dijkstra graph begin)
  ;; A table structure for setting up previous and distance tables
  (define (build-table graph fill)
    (foldr (lambda (a b) (cons (cons (node-name a) fill) b)) '() (graph-nodelist graph)))
  ;; A accessor for the table
  (define (table-ref nname table)
    (let ((ref (filter (lambda (a) (equal? (car a) nname)) table)))
      (if (null? ref) (error "table-ref: name not in table arguments --" nname table)
          (car ref))))
  ;; Set up tables previous fill with 'null and distance with infinity (or effectively infinity)
  (let* ((previous-table (build-table graph 'null))
         (distance-table (build-table graph 1000000)))
    ;;The iteration is based on a queue, when the queue is empty the work is done
    (define (iter done queue)
      (if (null? queue) previous-table
          ;;Find the next item in the queue to process (that is the one with the 
          ;; smallest distance)
          (let ((sorted-q (sort queue (lambda (a b) (< (cdr (table-ref a distance-table)) 
                                                       (cdr (table-ref b distance-table)))))))
            (process (car sorted-q) done (cdr sorted-q)))))
    ;;To process a node we are going to check to update its neighbors, then if necessary add them to 
    ;; the queue, and finally add the node to the done list
    (define (process nname done queue)
      (let* ((min-dist (+ (cdr (table-ref nname distance-table)) 1))
             (neighbors (node-neighbors (graph-node nname graph)))
             (update-list (filter (lambda (a) (> (cdr (table-ref a distance-table)) min-dist)) 
                                  neighbors))                                
             (add-to-queue (filter (lambda (a) (not (member? a done))) neighbors)))
        (for-each (lambda (a) (set-cdr! (table-ref a distance-table) min-dist)) update-list)
        (for-each (lambda (a) (set-cdr! (table-ref a previous-table) nname)) update-list)
        (iter (cons nname done) (union add-to-queue queue))))
    ;; Set the source node's distance to zero
    (set-cdr! (table-ref begin distance-table) 0)
    ;; Start the iteration with the source node in the queue
    (iter '() (list begin))))

;; Contract: graph, name, name, function -> image
;; Purpose: Given a graph, names of the start and stop vertices, and a position function
;;          returns an image with the minimum travel distance painted red
(define (travel-edges graph start end node_pos) 
  (define mst (Dijkstra graph start))
  (define image (graph->image graph node_pos))
  (define (color-edges curr_node img)    
    (let ((edge (filter (lambda (a) (equal? (car a) curr_node)) mst)))      
      (if (eq? 'null (cdar edge)) img
          (color-edges (cdar edge) (add-line img 
                                           (posn-x (node_pos (caar edge)))
                                           (posn-y (node_pos (caar edge)))
                                           (posn-x (node_pos (cdar edge)))
                                           (posn-y (node_pos (cdar edge)))
                                           'red)))))
  (overlay/xy 
   (overlay/xy
    (color-edges end image) 
    (posn-x (node_pos start)) 
    (posn-y (node_pos start))
    (rectangle 6 6 'solid 'green))
   (+ 1 (posn-x (node_pos end)))
   (+ 1 (posn-y (node_pos end)))
   (star 5 1 4 'solid 'red)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;          Test Cases                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(display "\n-------------------Testing Node Operations------------------------------\n")
;(display "make-node 1 (2 3): ")
;(define test (make-node 1 '(2 3)))
;(display "\nnode?: ")
;(node? test)
;(display "make-node-from-edgelist 1 '((1 2) (3 4) (3 1))): ")
;(define test (make-node-from-edgelist 1 '((1 2) (3 4) (3 1))))
;(display test)
;(display "\nnode-name: node:")
;(node-name test)
;(display "node-neighbors: ")
;(node-neighbors test)
;
;(display "\n-------------------Testing Graph Operations------------------------------\n")
;(define test-graph (make-graph '(1 2 3 4 5 6) '((6 4) (4 3) (4 5) (5 2) (5 1) (1 2) (2 3)))) 
;(display "\n-------------Test-Graph--------------------------\n")
;(display test-graph)
;(display "\n-------------Test-Graph properties---------------\n")
;(display "graph?: ")
;(graph? test-graph)
;(display "graph-node '1: ")
;(graph-node '1 test-graph)
;(display "graph-nodelist: ")
;(graph-nodelist test-graph)
;(display "graph-edgelist: ")
;(graph-edgelist test-graph)
;
;(display "\n-------------------Testing Graph Image Operations------------------------\n")
;(define (test-node-posn node_name)
;  (cond ((equal? node_name 1) (make-posn 65 30))
;        ((equal? node_name 2) (make-posn 50 55))
;        ((equal? node_name 3) (make-posn 25 65))
;        ((equal? node_name 4) (make-posn 15 20))
;        ((equal? node_name 5) (make-posn 40 15))
;        ((equal? node_name 6) (make-posn 0 0))))
;  
;(edgelist->image (graph-edgelist test-graph) (rectangle 1 1 'solid 'white) test-node-posn)
;(nodelist->image (graph-nodelist test-graph) (rectangle 1 1 'solid 'white) test-node-posn)
;(graph->image test-graph test-node-posn)
;
;
;(display "\n-------------------Making SWAT Graph Image Operations------------------------\n")
;(define TexasCities '(Amarillo ElPaso Austin Dallas FortWorth Houston SanAntonio Lubbock Midland Harlingen CorpusChristi))
;(define SWA-Texas '((Harlingen Houston) (Harlingen Austin) (Harlingen SanAntonio) (Amarillo Dallas) (Lubbock Dallas)
;                                        (Lubbock Austin) (Lubbock ElPaso) (Midland Dallas) (Midland Houston) (Midland ElPaso) (Midland Austin)
;                                        (ElPaso Dallas) (ElPaso Houston) (ElPaso SanAntonio) (ElPaso Austin) (SanAntonio Houston) (SanAntonio Dallas)
;                                        (Austin Houston) (Austin Dallas) (Houston Dallas) (Houston CorpusChristi)))
;(define (TCposn city_name)
;  (cond ((equal? city_name 'Amarillo) (make-posn 50 0))
;        ((equal? city_name 'ElPaso) (make-posn 0 50))
;        ((equal? city_name 'Austin) (make-posn 110 90))
;        ((equal? city_name 'Dallas) (make-posn 150 50))
;        ((equal? city_name 'FortWorth) (make-posn 145 35))
;        ((equal? city_name 'Houston) (make-posn 150 150))
;        ((equal? city_name 'SanAntonio) (make-posn 75 125))
;        ((equal? city_name 'Lubbock) (make-posn 50 20))
;        ((equal? city_name 'Midland) (make-posn 20 30))
;        ((equal? city_name 'Harlingen) (make-posn 25 150))
;        ((equal? city_name 'CorpusChristi) (make-posn 75 175))))
;
;(graph->image (make-graph TexasCities SWA-Texas) TCposn)
;
;(display "\n----------------Testing Dijkstra's Algorithm-----------------------------\n")
;(Dijkstra test-graph '1)
;(travel-edges test-graph 1 6 test-node-posn)
;(travel-edges (make-graph TexasCities SWA-Texas) 'Harlingen 'Amarillo TCposn)
;(travel-edges (make-graph TexasCities SWA-Texas) 'FortWorth 'Amarillo TCposn)
;
