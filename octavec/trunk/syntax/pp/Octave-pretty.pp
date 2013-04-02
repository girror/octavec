[  BinOp -- H[_1 KW["("] _2 KW[","] _3 KW[")"]],
   RelOp -- H[_1 KW["("] _2 KW[","] _3 KW[")"]],
   UnOp -- _1 KW["("] _2 KW[")"],

   CellIndex -- _1 KW["{"] _2 KW["}"],
   
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

   
   Prog -- V[_1  V is=1[KW["MainProg"]  _2] KW["endMainProg"]],
   Prog.1:iter-star -- V[_1],

   Function -- V is=4[H[KW["function ["]_1 KW["] ="] _2 KW["("] _3 KW[")"]] _4 ]KW["end"],
   Function.1:iter-star-sep -- H[_1 KW[","]],
   Function.3:iter-star-sep -- H[_1 KW[","]],

   Print -- H[ _2 KW[";"] ],

   Assign -- H[ _1 _2 _3], 
   AssignMulti -- H[KW["["] _1 KW["]"] KW["="] _2], 
   AssignMulti.1:iter-star-sep -- _1 KW[","],

   If -- V is=2[H[ KW["if"] _1] KW["then"] _2  KW["else"] _3] KW["endif"],
   If-Cont --V is=2[H[ KW["if"] _1] KW["then"] _2  KW["else"] _3] KW["endif"] 
	V is=2[KW["beg_cont"] _4] KW["end_cont"],

   IfThen -- V is=2[H[ KW["ifthen"] _1] KW["then"] _2 ] KW["endifthen"],

   IfThen-Cont -- V is=2[H[ KW["ifthen"] _1] KW["then"] _2 ] KW["endifthen"]
	V is=2[KW["beg_cont"] _3] KW["end_cont"],

   If-SSA -- V is=2[H[ KW["if"] _1] KW["then"] _2  KW["else"] _3] KW["endif"]
		_4 _5,
			
   IfThen-SSA -- V is=2[H[ KW["ifthen"] _1] KW["then"] _2 ] KW["endifthen"]
	_3 _4,

   DoUntil -- V [KW["do"] _1  H[KW["until"] _2] KW["enddo"]], 
   While -- V is=3[H[KW["while"] _1] _2] KW["endwhile"],

   For --  V is=3[ H[KW["for"] _1 KW["="] _2] _3] KW["endfor"],
   //UnwindProtect --  H[KW["unwind_protect"] _1 KW["unwind_protect_cleanup"] _2 KW["end"]],

   TryCatch -- V [KW["try"] _1  H[KW["catch"] _2] KW["end"]], 

   Break -- KW["break"],
   Continue -- KW["continue"],
   Return -- KW["return"],
   NaN    -- KW["NaN"],
   Inf    -- KW["Inf"],
   ElseIf -- V is=2[H[KW["elseif"] _1] _2],
   Else -- V is=2[KW["else"] _1],
   Case -- V is=2[H[KW["case"] _1] _2], 
   Let -- V is=2[H[KW["let"] _1] KW["in"] _2]  KW["endlet"],
   Stats --V is=2[KW["{"] _1] KW["}"],
   Stats.1:iter-star -- _1 ,
   Silent -- _1 ,
   UnwindProtect -- V is=2[KW["unwind_protect"] _1] 
      V is=2[KW["unwind_protect_cleanup"] _2] KW["end_unwind_protect"],
   Colon -- KW["(:)"] ,
   VarArgs -- KW["varargs"],
   Call --H hs=0 [_1 KW["("]  _2 KW[")"] ],
   Call.2:iter-star-sep -- _1 KW[","] ,
   NilExp -- KW["()"],

   Global -- H[KW["global"] _1],
   GlobalInit -- H[KW["global"] _1 "=" _2],
   Static -- H[KW["persistent"] _1],
   StaticInit -- H[KW["persistent"] _1 "=" _2],
    
   Func -- _1,
   FuncName --  H[ _1 _2  ],
   Var -- _1,
   Constant -- _1,
   VarTyped --  _1KW["::"]_2,
   VarOrFunc -- _1 ,
   
   True -- "true",
   False -- "false",
   Char  -- _1,
   Int -- _1,
   Float -- _1,
   String -- H hs=0[KW["'"] _1 KW["'"]],
   FieldVar --H hs=0[ _1 KW["."] _2],
   Subscript -- H hs=0[_1 KW["["] _2 KW["]"]],
   Subscript.2:iter-sep -- H[_1 KW[","]],


   Range -- H hs=0[KW["("]_1 KW[":"] _2 KW[":"] _3 KW[")"]],


   Matrix -- H [ KW["["] _1 KW["]"]],
   Matrix.1:iter-sep -- H hs=0[ _1 KW[";"]],
   Matrix.1:iter-sep.1:iter-sep -- _1 KW[" "],
   Matrix.1:iter-sep.2:iter-sep -- _1 KW[" "],


   Cell -- H[KW["{"] _1 KW["}"]],
   Cell.1:iter-star -- H[_1 KW[" "]],
   Cell.1:iter-sep.1:iter-sep -- _1 KW[" ;"],


   Record -- KW["-- RECORD --"],

   Cast-T --KW["cast("] _1 KW[","] _2  KW[")"],

   Not -- H[KW["~"] _1],
   UMinus -- KW["-"] _1,
   SE_PrePlus -- KW["++"] _1,
   SE_PreMinus -- KW["--"] _1,
   SE_PostPlus -- _1 KW["++p"],
   SE_PostMinus -- _1 KW["--p"],
   Imaginary -- H hs=0[ _1 KW["i"]],

   Transpose --  H hs=0 [ KW["("] _1 KW[".'"] KW[")"]], 
   Times -- H hs=0["(" H[_1 KW["*"] _2] ")"],   
   Power -- _1 KW["^"] _2,
   ComplexConjugate -- _1 KW["'"],
   Divide -- H hs=0["(" H[_1 KW["/"] _2] ")"],
   LDivide -- _1 KW["\\"] _2,
   Plus -- _1 KW["+"] _2,
   Minus -- H hs=0["("_1 KW["-"] _2 ")"],
   ETimes -- _1 KW[".*"] _2,
   EDivide -- _1 KW["./"] _2,
   EPower -- _1 KW[".^"] _2,
   EConjugate -- _1 KW[".'"],
   ELDivide -- _1 KW[".\\"] _2,
   Eq -- _1 KW["=="] _2,
   Neq -- _1 KW["~="] _2,
   Gt -- _1 KW[">"] _2,
   Lt -- _1 KW["<"] _2,
   Geq -- _1 KW[">="] _2,
   Leq -- _1 KW["<="] _2,
   And -- _1 KW["&"] _2,
   Or -- _1 KW["|"] _2,
   LazyAnd -- H[ KW["("] _1 KW["&&"] _2 KW[")"] ],
   LazyOr -- H[ KW["("] _1 KW["||"] _2 KW[")"] ],

   Typed -- H[_1 KW["::"] _2 ],
   MT    -- H[_1],
   MT.1:iter-star-sep   --_1 KW[","],
      UNIT  --KW[" u"],
   NIL   --KW[" null"],
   INT  -- KW[" int"],
   FLOAT  -- KW[" float"],
   BOOL  -- KW[" bool"],
   CHAR  --  KW[" char"],
   COMPLEX  -- KW["complex"],
   SCALAR   -- _1,
   RANGE    -- H hs=0[ _1 KW[":"] _2 ],
   MATRIX   -- H hs=0[ _1 KW[":"] _2 ],
   MATRIX.2:iter-sep -- _1 KW["x "],

   RECORD   -- H hs=0[KW["R("] _1 KW[")"]],
   RECORD.1:iter-star-sep   -- KW[" "],
   CELL   -- KW["C("] _1 KW[")"],
   CELL.1:iter-sep -- H hs=0[ _1 KW[";"]],
   CELL.1:iter-sep.1:iter-sep -- _1 KW[", "],
   CELL.1:iter-sep.2:iter-sep -- _1 KW[", "],


   SKIP  -- KW[" uk"],
   VarDecl -- KW[" "] _1 _2 

]
 
