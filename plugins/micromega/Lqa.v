(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2016     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)
(*                                                                      *)
(* Micromega: A reflexive tactic using the Positivstellensatz           *)
(*                                                                      *)
(*  Frédéric Besson (Irisa/Inria)      2016                             *)
(*                                                                      *)
(************************************************************************)

Require Import QMicromega.
Require Import QArith.
Require Import RingMicromega.
Require Import VarMap.
Require Coq.micromega.Tauto.
Declare ML Module "micromega_plugin".

(** Here, lra stands for linear rational arithmetic *)
Ltac lra := lra_Q ; 
    (abstract(intros __wit __varmap __ff ;
               change (Tauto.eval_f (Qeval_formula (@find Q 0%Q __varmap)) __ff) ;
               apply (QTautoChecker_sound __ff __wit); vm_cast_no_check (eq_refl true))).

(** Here, nra stands for non-linear rational arithmetic *)
Ltac nra :=
  xnqa ;
  (abstract(intros __wit __varmap __ff ;
             change (Tauto.eval_f (Qeval_formula (@find Q 0%Q __varmap)) __ff) ;
             apply (QTautoChecker_sound __ff __wit); vm_cast_no_check (eq_refl true))).

Ltac xpsatz dom d :=
  let tac := lazymatch dom with
  | Q =>
    (sos_Q || psatz_Q d) ;
      (* If csdp is not installed, the previous step might not produce any
    progress: the rest of the tactical will then fail. Hence the 'try'. *)
      try  (abstract(intros __wit __varmap __ff ;
                      change (Tauto.eval_f (Qeval_formula (@find Q 0%Q __varmap)) __ff) ;
                      apply (QTautoChecker_sound __ff __wit); vm_cast_no_check (eq_refl true)))
  | _ => fail "Unsupported domain"
  end in tac.

Tactic Notation "psatz" constr(dom) int_or_var(n) := xpsatz dom n.
Tactic Notation "psatz" constr(dom) := xpsatz dom ltac:(-1).




(* Local Variables: *)
(* coding: utf-8 *)
(* End: *)