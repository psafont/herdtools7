(****************************************************************************)
(*                           the diy toolsuite                              *)
(*                                                                          *)
(* Jade Alglave, University College London, UK.                             *)
(* Luc Maranget, INRIA Paris-Rocquencourt, France.                          *)
(*                                                                          *)
(* Copyright 2026-present Institut National de Recherche en Informatique et *)
(* en Automatique and the authors. All rights reserved.                     *)
(*                                                                          *)
(* This software is governed by the CeCILL-B license under French law and   *)
(* abiding by the rules of distribution of free software. You can use,      *)
(* modify and/ or redistribute the software under the terms of the CeCILL-B *)
(* license as circulated by CEA, CNRS and INRIA at the following URL        *)
(* "http://www.cecill.info". We also give a copy in LICENSE.txt.            *)
(****************************************************************************)

val insert_lib_file : (string -> unit) -> string -> unit

module type InsertConfig = sig
  val sysarch : Archs.System.t
end

module Insert : (O : InsertConfig) -> sig
  val insert : (string -> unit) -> string -> unit
  val exists : string -> bool
  val insert_when_exists : (string -> unit) -> string -> unit
  val copy : string -> (string -> string) -> unit
end

module type Config = sig
  val targetos : TargetOS.t
  val driver : Driver.t
  val affinity : Affinity.t
  val arch : Archs.t
  val sysarch : Archs.System.t
  val mode : Mode.t
  val alloc : Alloc.t
  val stdio : bool
  val platform : string
  val asmcommentaslabel : bool
  val cached : bool
  val variant : Variant_litmus.t -> bool
end

module Make : (_ : Config) (_ : Tar.S) -> sig
  val libdir : string

  val mk_libdir : unit

  val do_cpy :
    ?sub:string ->
    ?prf:string ->
    string list ->
    string ->
    string ->
    string ->
    string list

  val dump : Flags.t -> string list
end
