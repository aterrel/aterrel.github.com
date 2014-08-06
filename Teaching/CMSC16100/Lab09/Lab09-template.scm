;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Author: Andy Terrel              ;;
;; Class: CMSC 16100                ;;
;; Scheme Language: PLT Pretty Big  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load "CMSCGraphLib.ss")
(require (lib "world.ss" "htdp"))   

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;          Maze Class                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Contract: int list_of_edges -> list_of_ints
;; Purpose: make a graph to represent the maze
(define (make-maze num_points list-cons)
  null
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;          The World                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Contract: graph [node_name -> posn] node_name node_name [graph node_name node_name->node_name]-> world
;; Purpose: Make a world class
(define (make-world maze maze_posn min_pos pla_pos strategy)
  
  ;;Contract: (no arguments) -> (no output)
  ;;Purpose: Update the world class.
  (define (react)
    
  )
   
  ;; Contract: (no arguments) -> image
  ;; Purpose: Draw the current state of the world
  (define (draw)
    
  ) 

  (define (dispatch m)
    (cond ((eq? m 'react) (react))
          ((eq? m 'draw) (draw))
          (else (error "no dispatch available"))))
  dispatch)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;          Strategy Functions                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Contract: graph node_name node_name -> node_name
;; Purpose: Strategy that gives the minotaur the next move
(define (minotaur-next graph position target)
  (let ((min-tree (Dijkstra graph position)))
    (define (iter prev)
      (let ((next (cdar (filter (lambda (a) (equal? (car a) prev)) min-tree))))
        (if (equal? next position) prev
            (iter next))))
    (iter target)))

;; Contract: graph node_name node_name -> node_name
;; Purpose: Strategy that gives choses a random move
(define (random-neighbor graph nname min_name)
  (let ((nodes (node-neighbors (graph-node nname graph))))
    (list-ref nodes (random (length nodes)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;          Test Cases                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define maze2 (make-maze 20 
                    '((0 1) (1 6) (1 2) (2 3) (3 4) (4 9) (5 6) (5 10) (6 7) (7 12) (7 8) (8 9) (9 14) 
                            (10 11) (11 12) (12 13) (13 18) (14 19) (15 16) (16 17) (17 18) (18 19))))
(define (maze2_posn nname)
  (make-posn (* 50 (quotient nname 5)) (* 50 (remainder nname 5))))

(define maze3 (make-maze 54
                    '((0 1) (0 9) (1 2) (2 11) (3 12) (3 4) (4 5) (5 6) (6 15) (7 16) (7 8) (8 17)
                            (10 19) (11 20) (12 13) (13 14) (14 23) (15 24) (16 25) (17 26) (18 19)
                            (19 28) (20 21) (21 30) (22 23) (23 32) (23 24) (24 25) (26 35) (27 36)
                            (27 28) (29 38) (29 30) (30 39) (30 31) (31 32) (33 42) (33 34) (34 35)
                            (36 45) (37 46) (37 38) (38 47) (39 40) (41 42) (43 52) (43 44) (44 53)
                            (45 46) (47 48) (48 49) (49 50) (50 51) (51 52) (9 18) (42 43))))
(define (maze3_posn nname)
  (make-posn (* 50 (quotient nname 9)) (* 40 (remainder nname 9))))

  
(define INIT-W 285)
(define INIT-H 350)
(define TICKS/SEC 3)

(define INIT-WORLD1 (make-world maze2 maze3_posn 0 8 random-neighbor))
(define INIT-WORLD2 (make-world maze3 maze3_posn 0 8 random-neighbor))

(display "\n-------------------Testing react and draw--------------------\n")
(INIT-WORLD1 'draw)
(INIT-WORLD1 'react)
(INIT-WORLD1 'draw)
(INIT-WORLD1 'react)
(INIT-WORLD1 'draw)

(display "\n-------------------Testing simulation--------------------\n")
;(big-bang INIT-W INIT-H (/ 1 TICKS/SEC) INIT-WORLD2)
(big-bang INIT-W INIT-H (/ 1 TICKS/SEC) INIT-WORLD2)

(on-redraw (lambda (w) (place-image (w 'draw) 15 15 (empty-scene INIT-W INIT-H))))
(on-tick-event (lambda (w) (and (w 'react) w)))
