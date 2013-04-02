[  BinOp -- H[KW["("] _1 _2 _3 KW[")"]],
   RelOp -- H[_1 KW["("] _2 KW[","] _3 KW[")"]],
   UnOp -- _1 KW["("] _2 KW[")"],
   MBinOp -- H[_1 KW["("] _2 KW[","] _3 KW[")"]],
   MRelOp -- H[_1 KW["("] _2 KW[","] _3 KW[")"]],
   PLUS -- KW["+"],
   MUL -- KW["*"],
   MINUS -- KW["-"],
   DIV -- KW["/"],
   LDIV -- KW["\\"],
   POWER -- KW["^"],
   E_MUL -- KW[".*"],
   E_DIV -- KW["./"],
   E_POWER -- KW[".^"],
   SE_PRE_MINUS -- KW["--"], 
   SE_PRE_PLUS -- KW["++"],
   SE_POST_MINUS -- KW["--p"],
   SE_POST_PLUS -- KW["++p"],
   AND -- KW["&"],
   LAZYAND -- KW["&&"],
   LAZYOR -- KW["||"],
   OR -- KW["|"],
   EQ -- KW["=="],
   NE -- KW["~="],
   LT -- KW["<"],
   GT -- KW[">"],
   LE -- KW["<="],
   GE -- KW[">="],
   NOT -- KW["~"],
   E_CONJUGATE -- KW[".'"],
   CONJUGATE -- KW["'"],
   
   Print -- H [ _2 KW["%"] _1],

  FcnHandle -- H hs=0 [ KW["@"] _1 ],
  AnonFcnHandle -- H hs=0 [ _2 KW["("]  _1 KW[")"] _3 ],
  AnonFcnHandle.1:iter-star-sep-- _1 KW[" ,"],

  PrefixExp -- H[ _1 _2 ],
  PostfixExp -- H[ _1 _2 ],

  ConstantNotImplemented -- KW["---> <---"],

   CellIndex -- H hs=0[ _1 KW["{"] _2 KW["}"] ],
   CellIndex.2:iter-sep -- H [ _1 KW[","]],
   Cell -- KW["{"] _1 KW["}"],
   Cell.1:iter-sep -- _1 KW[" ;"],
   Cell.1:iter-sep.1:iter-sep -- _1 KW[" ,"],

   NilExp -- KW[""],
 
   Prog -- V[_1  _2],
   Prog.1:iter-star -- V[_1],
   Imaginary -- H hs=0[_1 KW["i"]],

   Function -- 
	V[ V is=4[H[KW["function ["]_1 KW["] ="] _2 KW["("] _3 KW[")"]]
		         _4 ]
		    KW["end"]],

   Function.1:iter-star-sep -- H[_1 KW[","]],
   Function.3:iter-star-sep -- H[_1 KW[","]],

   Silent -- H[ _1 KW[";"]],

   AssignMul -- H[ _1 KW["*="] _2 ],

   Assign -- H[KW["("] _1 _2 _3 KW[")"]], 
   AssignMulti -- H[KW["["] _1 KW["]"] _2 _3 ], 
   AssignMulti.1:iter-star-sep -- _1 KW[","],

   Multiple -- H[ KW["["] _1 KW["]"] ],
   Multiple.1:iter-star-sep -- _1 KW[","],

   If -- V [ V is=2[H[ KW["if"] _1]  _2 ] V is=2[ KW["else"] _3]  KW["end"] ],

   IfThen -- V is=2[H[ KW["if"] _1] _2 ] KW["end"],

   DoWhile -- V [KW["do"] _1 _3 H[KW["while"] _2] KW["end"]] _4,

   While -- V[V is=3[H[KW["while"] _1] _2] KW["end"]],
   For --  V[ V is=3[ H[KW["for"] _1 KW["="] _2] _3] KW["end"]],

   ComplexFor -- V is=3[ H[KW["for"] KW["["] _1 KW["]"] KW["="] _2] _3] KW["end"],
   ComplexFor.1:iter-star-sep -- _1 KW[","],

   Break --  H[ KW["break"] ],
   Continue --  H[ KW["continue"] ],
   Return -- H[KW["return"] ],
   NaN    -- KW["NaN"],
   Inf    -- KW["Inf"],
   Stats  --V [ _1],
   Stats.1:iter-star -- _1 ,

   UnwindProtect -- V is=2[KW["unwind_protect"] _1] 
      V is=2[KW["unwind_protect_cleanup"] _2] KW["end"],
   TryCatch -- V[ V is=2[KW["try"] _1] V is=2[KW["catch"] _2] KW["end"] ],
   
   Colon -- KW[":"] ,
   Call -- H hs=0 [_1 KW["("]  _2 KW[")"] ],
   Call.2:iter-star-sep -- _1 KW[","] ,


   Global -- H[KW["global"] _1],
   GlobalInit -- H[KW["global"] _1 KW["="] _2],

   GlobalDecl -- H[KW["global"] _1],
   GlobalDecl.1:iter-sep -- _1 KW[","],
   
   Static -- H[KW["persistent"] _1],
   StaticInit -- H[KW["persistent"] _1 "=" _2],

   VarDecl -- _1,
   VarDecl -- H [ _1 KW["="] _2],

   Func -- _1,
   FuncName --  H[ _1 _2  ],
   Var -- _1,
   Constant -- _1,
   True -- "true",
   False -- "false",
   Int -- _1,
   Char  -- _1,
   Float -- _1,
   String -- H hs=0[KW["\""]_1KW["\""]],
   StringEs -- H hs=0[KW["\""]_1KW["\""]],

   Command -- H hs=1[_1  _2 ],
   Command.2:iter-star -- _1,

   FieldVar --H hs=0[ _1 KW["."] _2],
   Subscript -- H hs=0[_1 KW["("] _2 KW[")"]],
   Subscript.2:iter-sep -- H[ _1 KW[","]],
   Range --H hs=1[KW["("] _1 KW[":"] _2 KW[":"] _3 KW[")"]],
   Matrix -- H[ KW["["] _1 KW["]"] ],
   Matrix.1:iter-sep -- H hs=0[ _1 KW[";"] ],
   Matrix.1:iter-sep.1:iter-sep -- _1 KW[","],
   Matrix.1:iter-sep.2:iter-sep -- _1 KW[","],

   Matrix-R -- KW["["] _1 KW["]"],
   Matrix-R.1:iter-sep -- _1 KW[";"],
   Row -- KW["["] _1 KW["]"],
   Row.1:iter-sep -- _1 KW[","],

   Not -- H hs=0[KW["~"] _1],
   UMinus -- H hs=0[KW["("] KW["-"] _1 KW[")"]],
   SE_PrePlus -- H hs=0[ KW["++"] _1],
   SE_PreMinus -- H hs=0[KW["--"] _1],
   SE_PostPlus -- H hs=0[_1 KW["++"]],
   SE_PostMinus -- H hs=0[_1 KW["--"]],
   
   Complex -- H hs=0[ _1 KW["i"]],
   
   Transpose --  H hs=0 [ KW["("] _1 KW[".'"] KW[")"]], 
   Times -- H hs=0["(" H[_1 KW["*"] _2] ")"],
   Divide --H hs=0["(" H[_1 KW["/"] _2] ")"],
   Mul -- H hs=0["(" H[_1 KW["*"] _2] ")"],
   Power -- H[ KW["("] _1 KW["^"] _2 KW[")"] ],
   ComplexConjugate -- H hs=0 [ _1 KW["'"]],

   Divide -- KW["("] _1 KW["/"] _2 KW[")"],
   LDiv -- KW["("] _1 KW["\\"] _2 KW[")"],


   Plus -- H[ KW["("] _1 KW["+"] _2 KW[")"] ],
   Minus -- H[ KW["("] _1 KW["-"] _2 KW[")"] ],
   ETimes -- H[ KW["("] _1 KW[".*"] _2 KW[")"] ],
   EDivide -- H[ KW["("] _1 KW["./"] _2 KW[")"] ],
   EMul -- H[ KW["("] _1 KW[".*"] _2 KW[")"] ],
   EPower -- H[ KW["("] _1 KW[".^"] _2 KW[")"] ],
   EConjugate -- H[ KW["("] _1 KW[".'"] KW[")"] ],
   ELDivide -- H[ KW["("] _1 KW[".\\"] _2 KW[")"] ],
   Eq -- H[ KW["("] _1 KW["=="] _2 KW[")"] ],
   Neq -- H[ KW["("] _1 KW["~="] _2 KW[")"] ],
   Gt -- H[ KW["("] _1 KW[">"] _2 KW[")"] ],
   Lt -- H[ KW["("] _1 KW["<"] _2 KW[")"] ],
   Geq -- H[ KW["("] _1 KW[">="] _2 KW[")"] ],
   Leq -- H[ KW["("] _1 KW["<="] _2 KW[")"] ],
   And -- H[ KW["("] _1 KW["&"] _2 KW[")"] ],
   Or -- H[ KW["("] _1 KW["|"] _2 KW[")"] ],
   LazyAnd -- H[ KW["("] _1 KW["&&"] _2 KW[")"] ],
   LazyOr -- H[ KW["("] _1 KW["||"] _2 KW[")"] ],

   Switch -- V [ V is=2 [ H[ KW["switch"] _1 ] ] _2 KW["end"] ],
   Switch.1:iter-star -- _1, 
   Case -- V is=2 [ H [ KW["case"] _1 ] _2 ] ,
   Default -- V is=2 [ KW["otherwise"] _1 ],


   Typed -- H[_2 KW["::"] _1],
   MT    -- H[_1],
   MT.1:iter-star-sep   --_1 KW[","],
   UNIT  --KW["u"],
   NIL   --KW["null"],
   INT  -- KW["int"],
   FLOAT  -- KW["float"],
   BOOL  -- KW["bool"],
   CHAR  --  KW["char"],
   COMPLEX  -- KW["complex"],
   SCALAR   -- _1,
   RANGE    -- H hs=1[ "range" ],
   RANGE    -- H hs=1[ "range" H hs=0[ _1 ]],
   RANGE    -- H hs=1[ "range" H hs=0[ _1 KW[":"] _2 ]],
   MATRIX   -- H hs=0[ _1 KW[":"] _2 ],
   MATRIX.2:iter-sep -- _1 KW["x"],

   RECORD   -- H hs=0[KW["R("] _1 KW[")"]],
   RECORD.1:iter-star-sep   -- KW[" "],
   CELL   -- KW["C("] _1 KW[")"],
   CELL.1:iter-sep -- H hs=0[ _1 KW[";"]],
   CELL.1:iter-sep.1:iter-sep -- _1 KW[", "],
   CELL.1:iter-sep.2:iter-sep -- _1 KW[", "],

  UNIVERSAL -- KW["ov"],

   SKIP  -- KW["uk"],
 
   Ifs -- V [ H[ KW["if"] _1 ] KW["end"]],
   Ifs -- V [ H[ KW["if"] _1 ] _2 KW["end"]],
   Ifs.1:iter-sep -- V [ _1 KW["elseif"]] ,
   ElseIf -- V[ H[ _1 ] _2 ], 
   Else -- V [KW["else"] _1],
   Number -- _1
]
