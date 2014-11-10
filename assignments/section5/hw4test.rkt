#lang racket

;; Programming Languages Homework4 Simple Test
;; Save this file to the same directory as your homework file
;; These are basic tests. Passing these tests does not guarantee that your code will pass 
;; the actual homework grader

;; Be sure to put your homework file in the same folder as this test file.
;; Uncomment the line below and change HOMEWORK_FILE to the name of your homework file.
(require "hw4.rkt") 
(require rackunit)

;; Helper functions
(define ones (lambda () (cons 1 ones)))
(define a 2)

(define (natural-numbers)
  (define (th x)
    (cons x (lambda ( ) (th (+ x 1)))))
  (th 1))

(define vec '((1 . "a") (2 . "b") (3 . "c") (4 . "d") (5 . "e")))

(define ctf (cached-assoc '((1 . 2) (3 . 4) (5 . 6) (7 . 8) (9 . 10)) 3 ))


;; Tests
(define tests
  (test-suite
   "Sample tests for Assignment 4"
   
   ; sequence test
   (check-equal? (sequence 0 5 1) (list 0 1 2 3 4 5) "Sequence test")
   
   (check-equal? (sequence 3 11 2) '(3 5 7 9 11) "sequence test #1")
   (check-equal? (sequence 3 8 3)  '(3 6)        "sequence test #2")
   (check-equal? (sequence 3 2 1)  '( )          "sequence test #3")
   
   ; string-append-map test
   (check-equal? (string-append-map 
                  (list "dan" "dog" "curry" "dog2") 
                  ".jpg") '("dan.jpg" "dog.jpg" "curry.jpg" "dog2.jpg") "string-append-map test")
   (check-equal? (string-append-map '("abc") "") 
                 '("abc") "string-append-map test #1")
   (check-equal? (string-append-map '() ".jpg") 
                 '() "string-append-map test #2")
   (check-equal? (string-append-map '("dog") ".jpg")
                 '("dog.jpg") "string-append-map #3")
   
   ; list-nth-mod test
   (check-equal? (list-nth-mod (list 0 1 2 3 4) 2) 2 "list-nth-mod test")
   
   (check-equal? (list-nth-mod '("a" "b" "c") 0) "a" "list-nth-mod test #1")
   (check-equal? (list-nth-mod '("a" "b" "c") 2) "c" "list-nth-mod test #2")
   (check-equal? (list-nth-mod '("a" "b" "c") 4) "b" "list-nth-mod test #3")
   (check-exn (regexp "list-nth-mod: negative number")
              (lambda () (list-nth-mod '("a" "b" "c") -1))
              "error 'list-nth-mod: negative number' not thrown #4")
   (check-exn (regexp "list-nth-mod: empty list")
              (lambda () (list-nth-mod '() 0))
              "error 'list-nth-mod: empty list' not thrown #5")
   
   
   ; stream-for-n-steps test
   (check-equal? (stream-for-n-steps (lambda () (cons 1 ones)) 1) (list 1) "stream-for-n-steps test")
   
   (check-equal? (stream-for-n-steps natural-numbers 5)
                 '(1 2 3 4 5) "stream-for-n-steps test #1")
   (check-equal? (stream-for-n-steps natural-numbers 10)
                 '(1 2 3 4 5 6 7 8 9 10) "stream-for-n-steps test #2")
   
   
   ; funny-number-stream test
   (check-equal? (stream-for-n-steps funny-number-stream 16)
                 (list 1 2 3 4 -5 6 7 8 9 -10 11 12 13 14 -15 16) "funny-number-stream test")
   
   (check-equal? (stream-for-n-steps funny-number-stream 0)
                 '() "funny-number-stream test #1")
   (check-equal? (stream-for-n-steps funny-number-stream 1)
                 '(1) "funny-number-stream test #2")
   
   ; dan-then-dog test
   (check-equal? (stream-for-n-steps dan-then-dog 1) (list "dan.jpg") "dan-then-dog test")
   
   (check-equal? (stream-for-n-steps dan-then-dog 4)
                 '("dan.jpg" "dog.jpg" "dan.jpg" "dog.jpg")
                 "dan-then-dog test #1")
   (check-equal? (stream-for-n-steps dan-then-dog 1)
                 '("dan.jpg") "dan-then-dog test #2")
   (check-equal? (stream-for-n-steps dan-then-dog 2)
                 '("dan.jpg" "dog.jpg") "dan-then-dog test #3")
   
   ; stream-add-zero test
   (check-equal? (stream-for-n-steps (stream-add-zero ones) 1) (list (cons 0 1)) "stream-add-zero test")
   
   (check-equal? (stream-for-n-steps (stream-add-zero dan-then-dog) 2)
                 '((0 . "dan.jpg") (0 . "dog.jpg"))
                 "stream-add-zero test #1")
   (check-equal? (stream-for-n-steps (stream-add-zero dan-then-dog) 4)
                 '((0 . "dan.jpg") (0 . "dog.jpg") (0 . "dan.jpg") (0 . "dog.jpg"))
                 "stream-add-zero test #2")
   (check-equal? (stream-for-n-steps (stream-add-zero dan-then-dog) 0)
                 '( ) "stream-add-zero test #3")
   
   
   ; cycle-lists test
   (check-equal? (stream-for-n-steps (cycle-lists (list 1 2 3) (list "a" "b")) 3) (list (cons 1 "a") (cons 2 "b") (cons 3 "a")) 
                 "cycle-lists test")
   
   (check-equal? (stream-for-n-steps (cycle-lists '(1 2 3) '("a" "b")) 4)
                 '((1 . "a") (2 . "b") (3 . "a") (1 . "b"))
                 "cycle-lists test #1")
   (check-equal? (stream-for-n-steps (cycle-lists '(1 2 3 4) '(5 6 7)) 6)
                 '((1 . 5) (2 . 6) (3 . 7) (4 . 5) (1 . 6) (2 . 7))
                 "cycle-lists test #2")
   
   ; vector-assoc test
   (check-equal? (vector-assoc 4 (vector (cons 2 1) (cons 3 1) (cons 4 1) (cons 5 1))) (cons 4 1) "vector-assoc test")
   
   (check-equal? (vector-assoc 5 (list->vector vec))
                 (cons 5 "e") "vector-assoc test #1")
   (check-equal? (vector-assoc 3 (list->vector vec))
                 (cons 3 "c") "vector-assoc test #2")
   (check-equal? (vector-assoc 6 (list->vector vec))
                 #f "vector-assoc test #3")
   (check-equal? (vector-assoc 5 (list->vector '(1 2 3 4 5)))
                 #f "vector-assoc test #4")
   (check-equal? (vector-assoc 7 (list->vector '(1 2 3 4 5 (7 . 8))))
                 (cons 7 8) "vector-assoc test #5")
   (check-equal? (vector-assoc 3 (list->vector '(1 2 (3 . 7) 4 5 (7 . 8))))
                 (cons 3 7) "vector-assoc test #6")
   
   ; cached-assoc tests
   (check-equal? ((cached-assoc (list (cons 1 2) (cons 3 4)) 3) 3) (cons 3 4) "cached-assoc test")
   
   (check-equal? (ctf 3) (cons 3 4) "cached-assoc test #1")
   (check-equal? (ctf 5) (cons 5 6) "cached-assoc test #2")
   (check-equal? (ctf 9) (cons 9 10) "cached-assoc test #3")
   (check-equal? (ctf 11) #f "cached-assoc test #4")
   
   ; while-less test
   (check-equal? (while-less 7 do (begin (set! a (+ a 1)) a)) #t "while-less test")
   
   ))

(require rackunit/text-ui)
;; runs the test
(run-tests tests 'verbose)