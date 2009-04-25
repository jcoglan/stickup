; Booleans
#t  ; true
#f  ; false

; Integers
0 12 976

; Expressions, arithmetic, comparison
(+ 3 4)         ; => 7
(- 9 1)         ; => 8
(* 4 5)         ; => 20
(= (/ 6 3) 2)   ; => #t
(= 7 5)         ; => #f

; Variables
(define x 8)
(+ 3 x)         ; => 11

; Conditionals
(if (= 0 x) (+ 3 7) (- 4 2))

; Functions
(define sq (lambda (x)
             (define z (* x x))
             z))

; Recursion
(define factorial (lambda (x)
                    (if (= 0 x)
                        1
                        (* (factorial (- x 1))
                           x))))

; Closures
(define add (lambda (x)
              (lambda (y)
                (+ x y))))

(define add3 (add 3))
(add3 6)    ; => 9

