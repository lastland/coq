(************************************************************************)
(*         *   The Coq Proof Assistant / The Coq Development Team       *)
(*  v      *   INRIA, CNRS and contributors - Copyright 1999-2018       *)
(* <O___,, *       (see CREDITS file for the list of authors)           *)
(*   \VV/  **************************************************************)
(*    //   *    This file is distributed under the terms of the         *)
(*         *     GNU Lesser General Public License Version 2.1          *)
(*         *     (see LICENSE file for the text of the license)         *)
(************************************************************************)

open Genarg
open Tacexpr
open Constrexpr
open Misctypes

(** Generic arguments based on Ltac. *)

val wit_tactic : (raw_tactic_expr, glob_tactic_expr, Geninterp.Val.t) genarg_type

(** [wit_ltac] is subtly different from [wit_tactic]: they only change for their
    toplevel interpretation. The one of [wit_ltac] forces the tactic and
    discards the result. *)
val wit_ltac : (raw_tactic_expr, glob_tactic_expr, unit) genarg_type

val wit_destruction_arg :
  (constr_expr with_bindings Tactics.destruction_arg,
   glob_constr_and_expr with_bindings Tactics.destruction_arg,
   delayed_open_constr_with_bindings Tactics.destruction_arg) genarg_type

