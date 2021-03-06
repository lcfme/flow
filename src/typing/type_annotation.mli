(**
 * Copyright (c) 2013-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)

(** services for producing types from annotations,
    called during AST traversal.
  *)

val convert: Context.t ->
  Type.t SMap.t ->
  (Loc.t, Loc.t) Ast.Type.t ->
  Type.t * (unit, unit) Ast.Type.t'

val convert_qualification: ?lookup_mode:Env.LookupMode.t ->
  Context.t ->
  string ->
  Loc.t Ast.Type.Generic.Identifier.t ->
  Type.t * unit Ast.Type.Generic.Identifier.t

val mk_interface_super: Context.t ->
  Type.t SMap.t ->
  Loc.t * (Loc.t, Loc.t) Ast.Type.Generic.t ->
  Type.t * (unit * (unit, unit) Ast.Type.Generic.t)

val mk_super: Context.t ->
  Type.t SMap.t ->
  Type.t ->
  (Loc.t, Loc.t) Ast.Type.ParameterInstantiation.t option ->
  Type.t * (unit, unit) Ast.Type.ParameterInstantiation.t option

val mk_type_annotation: Context.t ->
  Type.t SMap.t ->
  Reason.t ->
  (Loc.t * (Loc.t, Loc.t) Ast.Type.t) option ->
  Type.t * (unit, unit) Ast.Type.t' option

val mk_nominal_type: ?for_type:bool ->
  Context.t ->
  Reason.t ->
  Type.t SMap.t ->
  (Type.t * (Loc.t, Loc.t) Ast.Type.ParameterInstantiation.t' option) ->
  Type.t * (unit, unit) Ast.Type.ParameterInstantiation.t option

val mk_type_param_declarations: Context.t ->
  ?tparams_map:(Type.t SMap.t) ->
  (Loc.t, Loc.t) Ast.Type.ParameterDeclaration.t option ->
  Type.typeparam list *
  Type.t SMap.t *
  (unit, unit) Ast.Type.ParameterDeclaration.t option

val mk_interface_sig: Context.t ->
  Reason.t ->
  (Loc.t, Loc.t) Ast.Statement.Interface.t ->
  Class_sig.t * Type.t * (unit, unit) Ast.Statement.Interface.t

val mk_declare_class_sig: Context.t ->
  Reason.t ->
  (Loc.t, Loc.t) Ast.Statement.DeclareClass.t ->
  Class_sig.t * Type.t * (unit, unit) Ast.Statement.DeclareClass.t

val extract_type_param_instantiations:
  (Loc.t, Loc.t) Ast.Type.ParameterInstantiation.t option ->
  (Loc.t, Loc.t) Ast.Type.t list option

val polarity: Loc.t Ast.Variance.t option -> Type.polarity

val qualified_name: Loc.t Ast.Type.Generic.Identifier.t -> string
