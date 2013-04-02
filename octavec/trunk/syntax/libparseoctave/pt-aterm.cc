#if defined (__GNUG__) && defined (USE_PRAGMA_INTERFACE_IMPLEMENTATION)
#pragma implementation
#endif

/* The size of `long', as computed by sizeof. */
#define SIZEOF_LONG 4

/* The size of `void *', as computed by sizeof. */
#define SIZEOF_VOID_P 4


#include <octave/config.h> 

//#include <cctype>

#include <iostream>

#include <comment-list.h>
#include <error.h>
#include <ov-usr-fcn.h>
#include <ov-cell.h>
#include <pr-output.h>
#include <pt-all.h> 
#include <octave/oct.h>
#include <octave/parse.h>
#include <octave/oct-map.h>
#include <octave/ov.h>
#include <octave/octave.h>
#include "pt-aterm.h"

extern void install_builtins (void);

void
pt_aterm::visit_anon_fcn_handle (tree_anon_fcn_handle& afh)
{
	  ATerm trm1, trm2;
	  tree_parameter_list *param_list = afh.parameter_list ();

	  if (param_list) {
	    param_list->accept (*this);
	    trm1 = popATerm();
	  }

	  tree_statement_list *body = afh.body ();

	  if (body) {
	    body->accept (*this);
	    trm2 = popATerm();
	  }
	  pushATerm(ATmake("AnonFcnHandle(<term>,<str>,<term>)",trm1,"@",trm2));
}

void
pt_aterm::visit_argument_list (tree_argument_list& lst)
{
  ATermList trmlst = ATempty;
  if(&lst) 
  {
    ATerm trm;
  
    tree_argument_list::iterator p = lst.begin ();

    while (p != lst.end ())
    {
      tree_expression *elt = *p++;
  
      if (elt)
      {
        elt->accept (*this);
        trm = popATerm();
        trmlst = ATinsert(trmlst,trm);
      }
    }
  }
  pushATerm(ATmake("<term>",ATreverse(trmlst)));
}

void
pt_aterm::visit_binary_expression (tree_binary_expression& expr)
{
  expr.lhs () -> accept(*this) ;
  ATerm term1 = popATerm();

  expr.rhs () -> accept(*this) ;
  ATerm term2 = popATerm();

  pushATerm(ATmake("BinOp(<term>,<str>,<term>)",term1,expr.oper().c_str(),term2));
}


void
pt_aterm::visit_break_command (tree_break_command&)
{
    pushATerm(ATmake("Break"));
}

void
pt_aterm::visit_colon_expression (tree_colon_expression& expr)
{
  expr.base () -> accept(*this) ;
  ATerm term1 = popATerm() ;

  tree_expression *exp = expr.increment () ;
  ATerm term2;
  if(exp) {
    exp -> accept(*this) ; 
    term2 = popATerm();
  }
  else {
    term2 = ATmake("Number(1)");
  }

  expr.limit () -> accept(*this) ;
  ATerm term3 = popATerm();

  pushATerm(ATmake("Range(<term>,<term>,<term>)", term1, term2, term3));
}

void
pt_aterm::visit_continue_command (tree_continue_command&)
{
    pushATerm(ATmake("Continue"));
}

void
pt_aterm::visit_decl_command (tree_decl_command& cmd)
{
  cmd.initializer_list () -> accept(*this) ;
  ATerm term1 = popATerm() ;

  pushATerm(ATmake("Decl(<str>,<term>)",cmd.name().c_str(),term1));
}

void
pt_aterm::visit_decl_elt (tree_decl_elt& cmd)
{
  cmd.ident () -> accept(*this) ;
  ATerm term1 = popATerm() ;

  tree_expression *exp = cmd.expression ();
  if(exp) {
    exp -> accept(*this) ;
    ATerm term2 = popATerm();
    pushATerm(ATmake("Init(<term>,<term>)",term1,term2));
  } 
  else {
    pushATerm(ATmake("<term>",term1));
  }

}

void
pt_aterm::visit_decl_init_list (tree_decl_init_list& lst)
{
  ATermList trmlst = ATempty;
  if(&lst) 
  {
    ATerm trm;
  
    tree_decl_init_list::iterator p = lst.begin ();

    while (p != lst.end ())
    {
      tree_decl_elt *elt = *p++;
  
      if (elt)
      {
        elt->accept (*this);
        trm = popATerm();
        trmlst = ATinsert(trmlst,trm);
      }
    }
  }
  pushATerm(ATmake("<term>",ATreverse(trmlst)));
}

void
pt_aterm::visit_simple_for_command (tree_simple_for_command& cmd)
{
  cmd.left_hand_side () -> accept(*this) ;
  ATerm term1 = popATerm() ;

  cmd.control_expr () -> accept(*this) ;
  ATerm term2 = popATerm();

  cmd.body () -> accept(*this) ;
  ATerm term3 = popATerm();

  pushATerm(ATmake("For(<term>,<term>,<term>)",term1,term2,term3));
}

void
pt_aterm::visit_complex_for_command (tree_complex_for_command& cmd)
{
  cmd.left_hand_side () -> accept(*this) ;
  ATerm term1 = popATerm() ;

  cmd.control_expr () -> accept(*this) ;
  ATerm term2 = popATerm();

  cmd.body () -> accept(*this) ;
  ATerm term3 = popATerm();

  pushATerm(ATmake("ComplexFor(<term>,<term>,<term>)",term1,term2,term3));
}

void
pt_aterm::visit_octave_user_function (octave_user_function& fcn)
{
  fcn.return_list () -> accept(*this) ;
  ATerm term1 = popATerm() ;

  fcn.parameter_list () -> accept(*this) ;
  ATerm term2 = popATerm();

  fcn.body () -> accept(*this) ;
  ATerm term3 = popATerm();

  pushATerm(
    ATmake(
      "Function(<term>,<str>,<term>,<term>)"
    , term1, fcn.name().c_str(), term2, term3 
    )
  );
  
  
  if (fcn.is_nested_function() ){
	  printf("IT IS A NESTED FUNCTION \n");
  }
  if (fcn.is_inline_function() ){
	  printf("IT IS A INLINE FUNCTION \n");
  } 
}

void
pt_aterm::visit_identifier (tree_identifier& id)
{ 
	/*  int retval = 0;
	  symbol_record *s = lookup_by_name(id.name(),true);

	  if(s && s->is_builtin_function()) {
	      pushATerm(ATmake("BuiltinFunction(<str>)",id.name().c_str()));		  
	  }
	  else if (s && s->is_user_function()) {
	      pushATerm(ATmake("FVar(<str>)",id.name().c_str()));
	   }
	  else if (s && s->is_mapper_function()) {
	      pushATerm(ATmake("MapperFunction(<str>)",id.name().c_str()));
	   }
	   else{ */
	      pushATerm(ATmake("Var(<str>)",id.name().c_str()));
	   //}
}

void
pt_aterm::visit_if_clause (tree_if_clause& cmd)
{
  tree_expression *exp = cmd.condition ();
  if(exp) {
    exp-> accept(*this) ;
    ATerm term1 = popATerm();

    cmd.commands () -> accept(*this) ;
    ATerm term2 = popATerm();

    pushATerm(ATmake("If(<term>,<term>)", term1, term2));
  }
  else {
    cmd.commands () -> accept(*this) ;
    ATerm term1 = popATerm();

    pushATerm(ATmake("Else(<term>)", term1));
    }
}

void
pt_aterm::visit_if_command (tree_if_command& cmd)
{
  cmd.cmd_list() -> accept(*this);
}

void
pt_aterm::visit_if_command_list (tree_if_command_list& lst)
{
  ATermList trmlst = ATempty;
  ATerm trm;
  if(&lst) 
  {
    tree_if_command_list::iterator p = lst.begin ();

    while (p != lst.end ())
    {
      tree_if_clause *elt = *p++;
      if (elt)
      {
        elt->accept(*this);
        ATerm term1 = popATerm();
 
        trmlst = ATinsert(trmlst, term1);
      }
    }
  }
  pushATerm(ATmake("Ifs(<term>)",ATreverse(trmlst)));
}

void
pt_aterm::visit_index_expression (tree_index_expression& expr)
{
  expr.expression() -> accept(*this);
  ATerm term_lhs = popATerm(); 
  ATerm atmp ;

  std::list<tree_argument_list*> arg_lists = expr.arg_lists ();
  std::string type_tags = expr.type_tags ();
  std::list<string_vector> arg_names = expr.arg_names ();

  int n = type_tags.length ();

  std::list<tree_argument_list*>::iterator p_arg_lists = arg_lists.begin ();
  std::list<string_vector>::iterator p_arg_names = arg_names.begin ();

  for (int i = 0; i < n; i++)
  {
    switch (type_tags[i])
    {
      case '(':
      {
        tree_argument_list *l = *p_arg_lists;
        l->accept (*this);

 	atmp = popATerm();

	term_lhs = ATmake("Subscript(<term>,<term>)",term_lhs, atmp) ;
        break;
      }	    
      case '{':
      {
        tree_argument_list *l = *p_arg_lists;
        l->accept (*this);
	atmp = popATerm();
	term_lhs = ATmake("CellIndex(<term>,<term>)",term_lhs, atmp) ;
	break;
      }
      case '.':
      {
        string_vector nm = *p_arg_names;
        assert (nm.length () == 1);
        term_lhs = ATmake("FieldVar(<term>,<str>)",term_lhs, nm(0).c_str()) ;
        break;
      }
      default:
        panic_impossible ();
    }

    p_arg_lists++;
    p_arg_names++;
  } 

  pushATerm(term_lhs);
}

void
pt_aterm::visit_matrix (tree_matrix& lst)
{
  ATermList trmlst = ATempty;
  if(&lst) 
  {
    ATerm trm;
  
    tree_matrix::iterator p = lst.begin ();

    while (p != lst.end ())
    {
      tree_argument_list *elt = *p++;
  
      if (elt)
      {
        elt->accept (*this);
        trm = popATerm();
        trmlst = ATinsert(trmlst,trm);
      }
    }
  }
  pushATerm(ATmake("Matrix(<term>)",ATreverse(trmlst)));
}

void
pt_aterm::visit_cell (tree_cell& lst)
{
  ATermList trmlst = ATempty;
  if(&lst) 
  {
    ATerm trm;
  
    tree_matrix::iterator p = lst.begin ();

    while (p != lst.end ())
    {
      tree_argument_list *elt = *p++;
  
      if (elt)
      {
        elt->accept (*this);
        trm = popATerm();
        trmlst = ATinsert(trmlst,trm);
      }
    }
  }
  pushATerm(ATmake("Cell(<term>)",ATreverse(trmlst)));
}

void
pt_aterm::visit_multi_assignment (tree_multi_assignment& expr)
{
  expr.left_hand_side () -> accept(*this) ;
  ATerm term1 = popATerm();

  expr.right_hand_side () -> accept(*this) ;
  ATerm term2 = popATerm();

  pushATerm(ATmake("AssignMulti(<term>,<str>,<term>)",term1,expr.oper().c_str(),term2));
}

void
pt_aterm::visit_no_op_command (tree_no_op_command& cmd)
{
  pushATerm(ATmake("NilExp"));
}

ATerm 
octave_value_to_ATerm(octave_value v)
{
  ATerm retval ;
  bool set = false;
  string type = v.type_name();

  if ( type == "scalar" ) {
    string classname = v.class_name();
    if ( classname == "double") {
      retval = ATmake("Number(<real>)",v.double_value());
	  set = true;
    }
    else {
      retval = ATmake("ScalarConstantNotImplemented");
	set = true;
    }
  } 
  else if ( type == "complex scalar") { 
    Complex cpl = v.complex_value();
    retval = 
      ATmake( "BinOp(Number(<real>),<str>,BinOp(Number(<real>),<str>,Constant(<str>)))"
            , cpl.real(), "+", cpl.imag(), "*", "i"
      );
    set = true;
  }
  else if ( type == "string") {
    retval = ATmake("String(<str>)",v.string_value().c_str());
	set = true;
  }
  else if ( type == "matrix" || type == "bool matrix" ) {
    NDArray arr = v.array_value();

    ATermList alst = ATempty;
    int r = arr.rows();
    int c = arr.cols();
  
    for(int i = 0 ; i < r ; i++ ) {
      ATermList alst2 = ATempty ;
      for(int j = 0 ; j < c ; j++ ) {
        alst2 = ATinsert(alst2, octave_value_to_ATerm(arr(i,j)) );
      }
      alst = ATinsert(alst,ATmake("<term>",ATreverse(alst2)));
    }

    retval = ATmake("Matrix(<term>)",ATreverse(alst));
	set = true;
  }
  else if ( type == "complex matrix") {
    ComplexNDArray arr = v.complex_array_value();

    ATermList alst = ATempty;
    int r = arr.rows();
    int c = arr.cols();
  
    for(int i = 0 ; i < r ; i++ ) {
      ATermList alst2 = ATempty ;
      for(int j = 0 ; j < c ; j++ ) {
        alst2 = ATinsert(alst2, octave_value_to_ATerm(arr(i,j)) );
      }
      alst = ATinsert(alst,ATmake("<term>",ATreverse(alst2)));
    }


    retval = ATmake("Matrix(<term>)",ATreverse(alst));
	set = true;
  }
  else if ( type == "range") {
    retval = 
      ATmake(
        "Range(Number(<real>),Number(<real>),Number(<real>))"
      , v.range_value().base()
      , v.range_value().inc()
      , v.range_value().limit()
      );
	  set = true;
  }
  else if ( type == "bool") {
    if(v.bool_value()) {
      retval = ATmake("True");
	  set = true;
    }
    else {
      retval = ATmake("False"); 
	  set = true;
    }
  }
  else if ( type == "magic-colon" ) {
    retval = ATmake("Colon()"); set = true;
  } 
  else if (v.is_sq_string()){
	retval = ATmake("String(<str>)",v.string_value().c_str());
	set = true; 
  }
  else if ( type == "cell" ) {
    Cell arr = v.cell_value();

    ATermList alst = ATempty;
    int r = arr.rows();
    int c = arr.cols();
  
    for(int i = 0 ; i < r ; i++ ) {
      ATermList alst2 = ATempty ;
      for(int j = 0 ; j < c ; j++ ) {
        alst2 = ATinsert(alst2, octave_value_to_ATerm(arr(i,j)) );
      }
      alst = ATinsert(alst,ATmake("<term>",ATreverse(alst2)));
    }

    retval = ATmake("Cell(<term>)",ATreverse(alst)) ;set = true;
  }
  if (!set) {
	  printf("Failed to transform term: interface changed?? \n");
  }
  return retval;
}

void
pt_aterm::visit_constant (tree_constant& val)
{
  octave_value v = val.rvalue();
  pushATerm(octave_value_to_ATerm(v));
}

void
pt_aterm::visit_fcn_handle (tree_fcn_handle& fh)
{
  pushATerm(ATmake("FcnHandle(<str>)",fh.name().c_str()));
}

void
pt_aterm::visit_parameter_list (tree_parameter_list& lst)
{
  ATermList trmlst = ATempty;
  if(&lst)
  {
    ATerm trm;
  
    tree_parameter_list::iterator p = lst.begin ();

    while (p != lst.end ())
    {
      tree_decl_elt *elt = *p++;
  
      if (elt)
      {
        elt->accept (*this);
        trm = popATerm();
        trmlst = ATinsert(trmlst,trm);
      }
    }
    if(lst.takes_varargs()) {
      trmlst = ATinsert(trmlst,ATmake("VarArgs"));
    }
  }
  pushATerm(ATmake("<term>",ATreverse(trmlst)));
}

void
pt_aterm::visit_postfix_expression (tree_postfix_expression& expr)
{
  expr.operand () -> accept(*this);
  ATerm term1 = popATerm();

  pushATerm(ATmake("PostfixExp(<term>,<str>)",term1,expr.oper().c_str()));
}

void
pt_aterm::visit_prefix_expression (tree_prefix_expression& expr)
{
  expr.operand () -> accept(*this);
  ATerm term1 = popATerm();

  pushATerm(ATmake("PrefixExp(<str>,<term>)",expr.oper().c_str(),term1));
}

void
pt_aterm::visit_return_command (tree_return_command&)
{
  pushATerm(ATmake("Return"));
}

void
pt_aterm::visit_return_list (tree_return_list& lst)
{
  ATermList trmlst = ATempty;
  if(&lst) 
  {
    ATerm trm;
  
    tree_return_list::iterator p = lst.begin ();

    while (p != lst.end ())
    {
      tree_expression *elt = *p++;
  
      if (elt)
      {
        elt->accept (*this);
        trm = popATerm();
        trmlst = ATinsert(trmlst,trm);
      }
    }
  }
  pushATerm(ATmake("<term>",ATreverse(trmlst)));
}

void
pt_aterm::visit_simple_assignment (tree_simple_assignment& expr)
{
  expr.left_hand_side () -> accept(*this) ;
  ATerm term1 = popATerm();
  expr.right_hand_side () -> accept(*this) ;
  ATerm term2 = popATerm();

  pushATerm(ATmake("Assign(<term>,<str>,<term>)",term1,expr.oper().c_str(),term2));
}

void
pt_aterm::visit_statement (tree_statement& stmt)
{
  tree_command *cmd = stmt.command ();
  if(cmd)
  {
    cmd->accept (*this);
  }
  else
  {
    tree_expression *exp = stmt.expression();

    if(exp)
    {
      exp->accept (*this);
    }
  }
  if(!stmt.print_result())
  {
    ATerm trm = popATerm();
    trm = ATmake("Silent(<term>)",trm);
    pushATerm(trm);
  }
}

void
pt_aterm::visit_statement_list (tree_statement_list& lst)
{
  ATermList trmlst = ATempty;

  if(&lst) 
  {
    ATerm trm;
  
    tree_statement_list::iterator p = lst.begin ();

    while (p != lst.end ())
    {
      tree_statement *elt = *p++;
  
      if (elt)
      {
        elt->accept (*this);
        trm = popATerm();

        trmlst = ATinsert(trmlst,trm);
      }
    }
  }
  pushATerm(ATmake("Stats(<term>)",ATreverse(trmlst)));
}

void
pt_aterm::visit_switch_case (tree_switch_case& cs)
{
  tree_expression *exp = cs.case_label ();
  if(exp) {
    exp-> accept(*this) ;
    ATerm term1 = popATerm();

    cs.commands () -> accept(*this) ;
    ATerm term2 = popATerm();

    pushATerm(ATmake("Case(<term>,<term>)", term1, term2));
  }
  else {
    cs.commands () -> accept(*this) ;
    ATerm term1 = popATerm();

    pushATerm(ATmake("Default(<term>)", term1));
  }
}

void
pt_aterm::visit_switch_case_list (tree_switch_case_list& lst)
{
  ATermList trmlst = ATempty;
  if(&lst) 
  {
    ATerm trm;
  
    tree_switch_case_list::iterator p = lst.begin ();

    while (p != lst.end ())
    {
      tree_switch_case *elt = *p++;
  
      if (elt)
      {
        elt->accept (*this);
        trm = popATerm();
        trmlst = ATinsert(trmlst,trm);
      }
    }
  }
  pushATerm(ATmake("<term>",ATreverse(trmlst)));
}

void
pt_aterm::visit_switch_command (tree_switch_command& cmd)
{
  cmd.switch_value () -> accept(*this) ;
  ATerm term1 = popATerm();

  cmd.case_list () -> accept(*this) ;
  ATerm term2 = popATerm();

  pushATerm(ATmake("Switch(<term>,<term>)",term1,term2));
}

void
pt_aterm::visit_try_catch_command (tree_try_catch_command& cmd)
{
  cmd.body () -> accept(*this) ;
  ATerm term1 = popATerm();

  cmd.cleanup () -> accept(*this) ;
  ATerm term2 = popATerm();

  pushATerm(ATmake("TryCatch(<term>,<term>)",term1,term2));
}

void
pt_aterm::visit_unwind_protect_command
  (tree_unwind_protect_command& cmd)
{
  cmd.body () -> accept(*this) ;
  ATerm term1 = popATerm();

  cmd.cleanup () -> accept(*this) ;
  ATerm term2 = popATerm();

  pushATerm(ATmake("UnwindProtect(<term>,<term>)",term1,term2));
}


void
pt_aterm::visit_while_command (tree_while_command& cmd)
{
  cmd.condition () -> accept(*this) ;
  ATerm term1 = popATerm();

  cmd.body () -> accept(*this) ;
  ATerm term2 = popATerm();

  pushATerm(ATmake("While(<term>,<term>)",term1,term2));
}

void
pt_aterm::visit_do_until_command (tree_do_until_command& cmd)
{
  cmd.condition () -> accept(*this) ;
  ATerm term1 = popATerm();

  cmd.body () -> accept(*this) ;
  ATerm term2 = popATerm();

  pushATerm(ATmake("DoUntil(<term>,<term>)",term1,term2));
}

void
pt_aterm::write_output (void)
{
  FILE *fp;

  fp = fopen(output.c_str(),"w");

  ATwriteToTextFile(tmp.top(),fp);

  fclose(fp);
}

ATerm
pt_aterm::get_ast(void)
{
	return tmp.top();
}


extern "C" {

ATerm initialize_octave_stuff(void) 
{
  Vstruct_levels_to_print = 10;
  char* oargv[] = {"octave","-q", "--no-line-editing", "--no-history", NULL};
  octave_main(3, oargv, 1);
 
  return ATmake("[]");
}


ATerm parse_octave(ATerm fn) 
{
  ATerm result ;
  char *fnc ;
  int retval = 0;
  fnc = ATgetName(ATgetSymbol(fn));
  pt_aterm ast(fnc);

  curr_sym_tab = top_level_sym_tab;

  
  symbol_record *s = lookup_by_name(fnc,false);

  if(s) {
    if(s->is_user_function()) {
      octave_user_function *f = (octave_user_function*)s->def().function_value();
      f->accept(ast);
      result = ast.get_ast();
    }
    else if (s->is_builtin_function()) {
      printf("            IS A BUILTIN-function!!!\n\n");
      //result = ATmake("BuiltinFunction");
      //result = ATmake("[]");
      result = ATmake("BUILTIN-unction(<str>)","dld-func");     
    }
    else if (s->is_dld_function()) {
      printf("            IS A DLD-function!!!\n\n");
      result = ATmake("DLDFunction(<str>)","dld-func");
      //result = ATmake("DLDFunction");
    } 
    else if (s->is_mapper_function()) {
      printf("            IS A mapper-function!!!\n\n");
      result = ATmake("MAPFunction(<str>)","dld-func");
      //result = ATmake("MAPFunction");
    }   
    else {
      result = ATmake("[]");
    }
 }
 return result;
}

ATerm is_user_function(ATerm fn) 
{
  ATerm result ;
  char *fnc;
  fnc = ATgetName(ATgetSymbol(fn));
  symbol_record *s = lookup_by_name(fnc,false);
  
  if(s && s->is_user_function()) {
    return fn;
  }
  else {
    return ATmake("[]");
  }
}

ATerm is_builtin_function(ATerm fn) 
{
  ATerm result ;
  char *fnc;
  fnc = ATgetName(ATgetSymbol(fn));
  symbol_record *s = lookup_by_name(fnc,false);
  
  if(s && s->is_builtin_function()) {
    return fn;
  }
  else {
    return ATmake("[]");
  } 
}

ATerm is_dld_function(ATerm fn) 
{
  ATerm result ;
  char *fnc;
  fnc = ATgetName(ATgetSymbol(fn));
  //symbol_record *s = lookup_by_name(fnc,false);
  int r = symbol_exist(fnc, "file");

  if (r == 3) return fn;

  /* if (s) {
    printf(" the symbol_record is not empty\n");
  }

  if(s && s->is_dld_function()) {
    return fn;
    } */
  else {
    return ATmake("[]");
  }
}

ATerm is_command(ATerm fn) 
{
  ATerm result ;
  char *fnc;
  fnc = ATgetName(ATgetSymbol(fn));
  symbol_record *s = lookup_by_name(fnc,false);
  
  if(s && s->is_command()) {
    return fn;
  }
  else {
    return ATmake("[]");
  }
  
}

ATerm is_function(ATerm fn) 
{
  ATerm result ;
  char *fnc;
  fnc = ATgetName(ATgetSymbol(fn));
  symbol_record *s = lookup_by_name(fnc,false);
  
  if(s && s->is_function()) {
    return fn;
  }
  else {
    return ATmake("[]");
  }
}

ATerm is_mapping_function(ATerm fn) 
{
  ATerm result ;
  char *fnc;
  fnc = ATgetName(ATgetSymbol(fn));
  symbol_record *s = lookup_by_name(fnc,false);
  
  if(s && s->is_mapper_function()) {
    return fn;
  }
  else {
    return ATmake("[]");
  }
}

}

/*
int main(int argc, char *argv[]) 
{
  ATerm output;
  char *fnc = "easy";
  ATinit(argc,argv,&output);

  initialize_octave_stuff();

  parse_octave(ATmake("<str>","easy"));
 
}*/

