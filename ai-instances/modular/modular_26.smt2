; new_modular_14.smt2
; Encoding: 47*t^3 + 53*t^2 + (- 100)*t + 101 ≡ 0 (mod 36)
; Meaning: 47 and 53 are primes summing to 100, constant 101 is prime.
; 36=4*9. Extending new_modular_27 (without constant) by adding 101.
; Mod 4: 47≡3, 53≡1, 100≡0, 101≡1. So 3t^3+t^2+1 ≡ 0 mod 4.
;   t=1: 3+1+1=5≡1. t=3: 3*27+9+1=82+9+1=92≡0 ✓. So t≡3 mod 4 is one solution.
; Mod 9: 47≡2, 53≡8, 100≡1, 101≡2. So 2t^3+8t^2+(- 1)*t+2 ≡ 0 mod 9.
;   t=1: 2+8-1+2=11≡2. t=2: 16+32-2+2=48≡3. t=4: 128+128-4+2=254≡254-28*9=254-252=2.
;   t=7: 2*343+8*49-7+2=686+392-5=1073≡1073-119*9=1073-1071=2. Non-trivial.
; Coefficients: 47, 53, (- 100), constant 101. Degree 3. Length+degree = 3+3 = 6.

(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t1 () String)
(declare-fun t2 () String)
(declare-fun t3 () String)
(assert (str.in_re t1 (re.++ (re.* (str.to_re "0")) (str.to_re "10"))))
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (str.in_re t3 (re.++ (re.* (str.to_re "0")) (str.to_re "1000"))))
(assert (= (* 36 A)
           (+ (* 47 (str.to_int t3))
              (+ (* 53 (str.to_int t2))
                 (+ (* (- 100) (str.to_int t1))
                    101)))))
(check-sat)
