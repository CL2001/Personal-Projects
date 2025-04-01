#lang scheme

(define (prime? n)
  (define (divisible? a b) (= (remainder a b) 0))
  (define (check-divisors d)
    (cond ((> (* d d) n) #t)
          ((divisible? n d) #f)
          (else (check-divisors (+ d 2)))))
  (cond ((< n 2) #f)
        ((= n 2) #t)
        ((even? n) #f)
        (else (check-divisors 3))))

(define (next-prime n)
  (if (prime? n) n (next-prime (+ n 1))))

(define (first-n-primes n)
  (define (helper count num)
    (if (= count n)
        '()
        (let ((p (next-prime num)))
          (display (decimal-to-binary p))
          (newline)
          (cons p (helper (+ count 1) (+ p 1))))))
  (helper 0 2))

(define (decimal-to-binary n)
  (if (= n 0)
      "0"
      (let loop ((num n) (result ""))
        (if (= num 0)
            result
            (loop (quotient num 2)
                  (string-append (if (= (remainder num 2) 0) "0" "1") result))))))

(define (primes-in-binary n)
  (first-n-primes n))

;; Example usage
(primes-in-binary 1000)