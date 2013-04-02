#if defined (__GNUG__) && defined (USE_PRAGMA_INTERFACE_IMPLEMENTATION)
#pragma interface
#endif

#include <stack>
#include <string>
//#include <ext/hash_map>
//#include <ext/stl_hash_fun.h>

#include <comment-list.h>
#include <pt-walk.h>
#include <aterm2.h>

using namespace std;

class tree_expression;


class
pt_aterm : public tree_walker
{
	
public:
  pt_aterm(string outputfn) { output = outputfn; debug_stack = false;} 
  ~pt_aterm (void) { }
  
  void visit_anon_fcn_handle (tree_anon_fcn_handle&);

  void visit_argument_list (tree_argument_list&);

  void visit_binary_expression (tree_binary_expression&);

  void visit_break_command (tree_break_command&);

  void visit_colon_expression (tree_colon_expression&);

  void visit_continue_command (tree_continue_command&);

  void visit_decl_command (tree_decl_command&);

  void visit_decl_elt (tree_decl_elt&);

  void visit_decl_init_list (tree_decl_init_list&);

  void visit_simple_for_command (tree_simple_for_command&);

  void visit_complex_for_command (tree_complex_for_command&);

  void visit_octave_user_function (octave_user_function&);

  void visit_octave_user_function_header (octave_user_function&);

  void visit_octave_user_function_trailer (octave_user_function&);

  void visit_identifier (tree_identifier&);

  void visit_if_clause (tree_if_clause&);

  void visit_if_command (tree_if_command&);

  void visit_if_command_list (tree_if_command_list&);

  void visit_index_expression (tree_index_expression&);

  void visit_matrix (tree_matrix&);

  void visit_cell (tree_cell&);

  void visit_multi_assignment (tree_multi_assignment&);

  void visit_no_op_command (tree_no_op_command&);

  void visit_constant (tree_constant&);

  void visit_fcn_handle (tree_fcn_handle&);

  void visit_parameter_list (tree_parameter_list&);

  void visit_postfix_expression (tree_postfix_expression&);

  void visit_prefix_expression (tree_prefix_expression&);

  void visit_return_command (tree_return_command&);

  void visit_return_list (tree_return_list&);

  void visit_simple_assignment (tree_simple_assignment&);

  void visit_statement (tree_statement&);

  void visit_statement_list (tree_statement_list&);

  void visit_switch_case (tree_switch_case&);

  void visit_switch_case_list (tree_switch_case_list&);

  void visit_switch_command (tree_switch_command&);

  void visit_try_catch_command (tree_try_catch_command&);

  void visit_unwind_protect_command (tree_unwind_protect_command&);

  void visit_while_command (tree_while_command&);

  void visit_do_until_command (tree_do_until_command&);

  void write_output(void);

  ATerm 
  get_ast(void);

  void
  pushATerm(ATerm aterm) {
    tmp.push(aterm);
    if(debug_stack) ATprintf("Pushed : %t\n",aterm);
  }

  ATerm
  popATerm() {
    if(!tmp.empty()) {
      ATerm aterm = tmp.top();
      tmp.pop();
      if(debug_stack) ATprintf("Popped : %t\n",aterm);
      return aterm;
    }
    else {
    
      printf("*** ERROR *** pt-aterm: Stack is empty.\n");
      printf("*** ERROR *** pt-aterm: Failling gracefully\n");    
      return ATmake("[]");
      //exit(1);
    }
  }
  
private:
	  
  bool debug_stack ;

  std::stack<ATerm> tmp;
  ATerm ast;
  std::string output;  

  // No copying!
  
  pt_aterm (const pt_aterm&);

  pt_aterm& operator = (const pt_aterm&);
};


/*
;;; Local Variables: ***
;;; mode: C++ ***
;;; End: ***
*/
