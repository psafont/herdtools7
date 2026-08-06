(****************************************************************************)
(*                           the diy toolsuite                              *)
(*                                                                          *)
(* Jade Alglave, University College London, UK.                             *)
(* Luc Maranget, INRIA Paris-Rocquencourt, France.                          *)
(*                                                                          *)
(* Copyright 2026-present Institut National de Recherche en Informatique et *)
(* en Automatique, ARM Ltd and the authors. All rights reserved.            *)
(*                                                                          *)
(* This software is governed by the CeCILL-B license under French law and   *)
(* abiding by the rules of distribution of free software. You can use,      *)
(* modify and/ or redistribute the software under the terms of the CeCILL-B *)
(* license as circulated by CEA, CNRS and INRIA at the following URL        *)
(* "http://www.cecill.info". We also give a copy in LICENSE.txt.            *)
(****************************************************************************)

(** Configuration shared between all dump modes *)
module type Config = sig
  val alloc : Alloc.t
  val affinity : Affinity.t
  val c11 : bool
  val delay : int
  val driver : Driver.t
  val exit_cond : bool
  val force_affinity : bool
  val hexa : bool
  val kind : bool
  val logicalprocs : int list option
  val smt : int
  val nsockets : int
  val numeric_labels : bool
  val precision : Fault.Handling.t
  val preload : Preload.t
  val smtmode : Smt.t
  val stdio : bool
  val sysarch : Archs.System.t
  val tagcheck : Precision.t
  val variant : Variant_litmus.t -> bool
  val verbose : int
  val word : Word.t
  include DumpParams.Config
end
