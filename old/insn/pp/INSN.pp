[
   INT                      -- KW["int"],
   FLOAT                    -- KW["float"],
   STRING                   -- KW["str"],
   WORD                     -- KW["word"],
   ADD                      -- KW["+"],
   SUB                      -- KW["-"],
   MULS                     -- KW["*s"],
   MULU                     -- KW["*"],
   MAC                      -- KW["mac"],
   DIVS                     -- KW["/s"],
   DIVU                     -- KW["/u"],
   NEG                      -- KW["-|"],
   AND                      -- KW["&"],
   OR                       -- KW["|"],
   XOR                      -- KW["xor"],
   NOT                      -- KW["not"],
   A                        -- KW["always"],
   N                        -- KW["never"],
   ASL                      -- KW["<a"],
   ASR                      -- KW[">a"],
   LSL                      -- KW["<l"],
   LSR                      -- KW[">l"],
   ROL                      -- KW["<r"],
   ROR                      -- KW[">r"],
   RCL                      -- KW["<c"],
   RCR                      -- KW[">c"],
   EQ                       -- KW["=i"],
   NE                       -- KW["~=i"],
   MI                       -- KW["min"],
   PL                       -- KW["plus"],
   VS                       -- KW["ows"],
   EQ                       -- KW["owc"],
   LO                       -- KW["lo"],
   LS                       -- KW["los"],
   HS                       -- KW["hs"],
   HI                       -- KW["hi"],
   LT                       -- KW["<s"],
   LE                       -- KW["<=s"],
   GE                       -- KW[">=s"],
   GT                       -- KW[">s"],
   PROGRAM                  -- V  [V vs=2 [KW["program"] _1] KW["end"]],
   PROGRAM.1:iter-star      -- _1,
   FUNCTION                 -- KW["function"] _1 _2 _3 KW["end"],
   FUNCTION.1:iter-star-sep -- _1 KW[","],
   FUNCTION.2:iter-star-sep -- _1 KW[";"],
   FUNCTION.3:iter-star-sep -- _1 KW[","],
   ENTER_FUNC               -- KW["enter_func"],
   LEAVE_FUNC               -- KW["leave_func"],
   LOC                      -- KW["Mem"] _1 KW["of"] _2,
   LABEL                    -- KW["label"] _1 KW[":"],
   CONST                    -- _1 KW[":="] _2,
   LABELREF                 -- _1 KW["addressof"] KW["("] _2 KW[")"],
   DATA                     -- _1 KW["("] _2 KW[","] _3 KW[")"],
   DATA.2:iter-star         -- _1,
   DATA.3:iter-star         -- _1,
   LOAD                     -- _1 KW[":= *"] _2,
   STORE                    -- KW["*"] _1 KW[":="] _2,
   BRANCH                   -- KW["branch"] _1 KW["("] _2 KW[")"] KW["iftrue"] _3 KW["iffalse"] _4,
   BRANCH.2:opt             -- _1,
   BRANCH.4:opt             -- _1,
   CALL                     -- KW["jump"] _1 _2 KW["goto"] _3,
   CALL.2:opt               -- _1,
   NOTE_LOC_BIRTH           -- KW["birth"] _1,
   NOTE_LOC_DEATH           -- KW["death"] _1,
   NOTE_LOOP_START          -- KW["lstart"] _1,
   NOTE_LOOP_FINISH         -- KW["lfinish"] _1,
   IN_ARG                   -- KW["in_arg"] _1 _2,
   IN_RET                   -- KW["ret_vat"] _1 _2,
   OUT_ARG                  -- KW["out_arg"] _1 _2,
   OUT_RET                  -- KW["out_ret_val"] _1 _2,
   ALLOC_FRAME              -- KW["alloc_frame"] _1 _2,
   FREE_FRAME               -- KW["free_frame"] _1 _2,
   ALLOC_STATIC             -- KW["alloc_static"] _1 _2,
   FREE_STATIC              -- KW["free_static"] _1 _2,
   ALLOC_STRING             -- KW["alloc_string"] _1 KW["="] _2,
   SEQS                     -- V  [H  [KW["seqs"]] _1],
   SEQS.1:iter-sep          -- _1 KW[";"],
   SEQ                      -- KW["seq"] _1 _2
]
