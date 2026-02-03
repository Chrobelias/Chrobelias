  $ export CHRO_DEBUG=1
  $ cat strings3.smt2
  (set-logic QF_S)
  (declare-const x String)
  (declare-const y String)
  (assert (= (str.++ "999" x) (str.++ y x)))
  (check-sat)
  (get-model)

  $ Chro strings3.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= (str.++ "999" x) (str.++ y x)))
  iter(2)= (= (str.++ "999" x) (str.++ y x))
  fixed-point
  
  Alphapbet with extra char: # 9
  Vars for underapporx (rigth): x
  Strings for x:
    # ## ### ##9 ##99 #9 #9# #9#9 #99 #999 9 9# 9## 9#9 9#99 99 99# 99#9 999 9999
  
  Vars for underapporx (left): y
  Strings for y:
    # ## ### ##9 ##99 #9 #9# #9#9 #99 #999 9 9# 9## 9#9 9#99 99 99# 99#9 999 9999
  
  sat (under I)
  ((define-fun x () (_ String) "") (define-fun y () (_ String) "999"))
  $ unset CHRO_DEBUG
  $ timeout 8 Chro -flat 0 -amin 0 -amax 1 --dsimpl strings3.smt2
  sat (under I)
  ((define-fun x () (_ String) "") (define-fun y () (_ String) "999"))
