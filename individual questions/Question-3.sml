use "sml-files.sml";
(* M' - item notation*)
datatype ILEXP = IAPP of ILEXP * ILEXP | ILAM of string * ILEXP | IID of string;

val ivx = (IID "x");
val ivy = (IID "y");
val ivz = (IID "z");
val it1 = (ILAM("x",ivx)); (* [x]x *) 
val it2 = (ILAM("y",ivx));  (* [y]x *)
val it3 = (IAPP(ivz, IAPP(it2,it1))); (* <z><it2>it1 *)
val it4 = (IAPP(ivz,it1)); (* <z>it1 *)
val it5 = (IAPP(it3,it3)); (* <it3>it3 *)
val it6 = (ILAM("x",(ILAM("y",(ILAM("z",(IAPP (IAPP(ivz, ivy), (IAPP(ivz, ivx)))))))))); (* [x][y][z]<<z>y><z>x *)
val it7 = (IAPP(it1, IAPP(it1,it6))); (* <it1><it1>it6 *)
val it8 = (ILAM("z", (IAPP(IAPP(ivz,it1), ivz)))); (* [z]<<z>it1>z *)
val it9 = (IAPP(it3,it8)); (* <it3>it8 *)

(* de Bruijn *)
datatype BLEXP = BAPP of BLEXP * BLEXP | BLAM of BLEXP | BID of int;

val bvx = (BID 1);
val bvy = (BID 2);
val bvz = (BID 3);
val bt1 = (BLAM(bvx)); (* \1 *)
val bt2 = (BLAM(bvy)); (* \2 *)
val bt3 = (BAPP(BAPP(bt1,bt2),bvz));  (* (\1)(\2)3 *)
val bt4 = (BAPP(bt1,bvz)); (* (\1)3 *)
val bt5 = (BAPP(bt3,bt3)); (* (\1)(\2)3 ((\1)(\2)3) *)
val bt6 = (BLAM(BLAM(BLAM(BAPP(BAPP(BID 3,BID 1),(BAPP(BID 2,BID 1))))))); (* \\\31(21) *)
val bt7 = (BAPP(BAPP(bt6,bt1),bt1)); (* ((\\\31(21))(\1))(\1) *)
val bt8 = (BLAM(BAPP(BID 1,(BAPP(bt1,BID 1))))); (* ( \1((\1)1) ) THIS WILL NOT PRINT CORRECTLY BY DEFAULT *)
val bt9 = (BAPP(bt8,bt3)); (* (\1((\1)1))((\1)(\2)3) WONT PRINT BY DEFAULT *)

(* de Bruijn item notation *)
datatype IBLEXP =  IBAPP of IBLEXP * IBLEXP | IBLAM of IBLEXP |  IBID of int;

val ibvx = (IBID 1);
val ibvy = (IBID 2);
val ibvz = (IBID 3);
val ibt1 = (IBLAM(ibvx)); (* []1 *)
val ibt2 = (IBLAM(ibvy)); (* []2 *)
val ibt3 = (IBAPP(ibvz, IBAPP(ibt2,ibt1))); (* <3><[]2>[]1 *)
val ibt4 = (IBAPP(ibvz,ibt1)); (* <3>[]1 *)
val ibt5 = (IBAPP(ibt3,ibt3)); (* <<3><[]2>[]1> <3><[]2>[]1 *)
val ibt6 = (IBLAM(IBLAM(IBLAM(IBAPP(IBAPP(IBID 1, IBID 2), IBAPP(IBID 1, IBID 3)))))); (* [][][]<<1>2><1>3 *)
val ibt7 = (IBAPP(ibt1, IBAPP(ibt1, ibt6))); (* <[]1><[]1>[][][]<<1>2><1>3 *)
val ibt8 = (IBLAM(IBAPP((IBAPP(IBID 1, ibt1)), IBID 1))); (* []<<1>[]1>1 *)
val ibt9 = (IBAPP(ibt3,ibt8)); (* <<3><[]2>[]1> []<<1>[]1>1 *)

(* M'' - Combinatory logic *)
datatype COM =  CAPP of COM * COM | CI | CK | CS |  CID of string;

val cvx = (CID "x");
val cvy = (CID "y");
val cvz = (CID "z");
val ct1 = CI; (* I'' *)
val ct2 = (CAPP(CK, cvx)); (* K'' x *)
val ct3 = (CAPP(CAPP(ct1,ct2),cvz)); (* I'' (K'' x) z *)
val ct4 = (CAPP(ct1,cvz)); (* I'' z *)
val ct5 = (CAPP(ct3,ct3)); (* I''(K''x)z (I''(K''x)z) *)
val ct6 = CS; (* S'' *)
val ct7 = CAPP(CAPP(ct6,ct1),ct1); (* S'' I'' I'' *)
val ct8 = CAPP(CAPP(CS, CI), CI); (* S'' I'' I'' *)
val ct9 = CAPP(ct8,ct3); (* S'' I'' I'' (I'' (K'' x) z) *)

val ct10 = CAPP((CAPP(CI, CAPP(CAPP(CI, CAPP(CK, cvx)), cvz))), (CAPP(CI, CAPP(CAPP(CI, CAPP(CK, cvx)), cvz))));



