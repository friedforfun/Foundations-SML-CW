use "sml-files.sml";
(* M' - item notation*)
datatype ILEXP = IAPP of ILEXP * ILEXP | ILAM of string * ILEXP | IID of string;

val ivx = (IID "x");
val ivy = (IID "y");
val ivz = (IID "z");
val it1 = (ILAM("x",ivx)); (* [x]x *) 
val it2 = (ILAM("y",ivx));  (* [y]x *)
val it3 = (IAPP(IAPP(it1,it2),ivz)); (* <z><it2>it1 *)
val it4 = (IAPP(it1,ivz)); (* <z>it1 *)
val it5 = (IAPP(it3,it3)); (* <it3>it3 *)
val it6 = (ILAM("x",(ILAM("y",(ILAM("z",(IAPP(IAPP(ivx,ivz),(IAPP(ivy,ivz)))))))))); (* [x][y][z]<<z>y><z>x *)
val it7 = (IAPP(IAPP(it6,it1),it1)); (* <it1><it1>it6 *)
val it8 = (ILAM("z", (IAPP(ivz,(IAPP(it1,ivz)))))); (* [z]<<z>it1>z *)
val it9 = (IAPP(it8,it3)); (* <it3>it8 *)

(* de Bruijn *)
datatype BLEXP = BAPP of BLEXP * BLEXP | BLAM of string * BLEXP | BID of string;

val bvx = (BID 1);
val bvy = (BID 2);
val bvz = (BID 3);
val bt1 = (BLAM(bvx)); (* \1 *)
val bt2 = (BLAM(bvy)); (* \2 *)
val bt3 = (BAPP(BAPP(bt1,bt2),bvz));  (* (\1)(\2)3 *)
val bt4 = (BAPP(bt1,bvz)); (* (\1)3 *)
val bt5 = (BAPP(bt3,bt3)); (* (\1)(\2)3 ((\1)(\2)3) *)
val bt6 = (BLAM(BLAM(BLAM(BAPP(BAPP(bvx,bvz),(BAPP(bvy,bvz))))))); (* \\\31(21) *)
val bt7 = (BAPP(BAPP(bt6,bt1),bt1)); (* ((\\\31(21))(\1))(\1) *)
val bt8 = (BLAM(BAPP(bvz,(BAPP(bt1,bvz))))); (* ( \1((\1)1) ) THIS WILL NOT PRINT CORRECTLY BY DEFAULT *)
val bt9 = (BAPP(bt8,bt3)); (* (\1((\1)1))((\1)(\2)3) WONT PRINT BY DEFAULT *)

(* de Bruijn item notation *)
datatype IBLEXP =  IBAPP of IBLEXP * IBLEXP | IBLAM of string *  IBLEXP |  IBID of string;

val ibvx = (IBID 1);
val ibvy = (IBID 2);
val ibvz = (IBID 3);
val ibt1 = (IBLAM(ibvx)); (* []1 *)
val ibt2 = (IBLAM(ibvx)); (* []2 *)
val ibt3 = (IBAPP(IBAPP(ibt1,ibt2),ibvz)); (* <3><[]2>[]1 *)
val ibt4 = (IBAPP(ibt1,ibvz)); (* <3>[]1 *)
val ibt5 = (IBAPP(ibt3,ibt3)); (* <<3><[]2>[]1> <3><[]2>[]1 *)
val ibt6 = (IBLAM(IBLAM(IBLAM(IBAPP(IBAPP(ibvx,ibvz),(IBAPP(ibvy,ibvz))))))); (* [][][]<<1>2><1>3 *)
val ibt7 = (IBAPP(IBAPP(ibt6,ibt1),ibt1)); (* <[]1><[]1>[][][]<<1>2><1>3 *)
val ibt8 = (IBLAM(IBAPP(ibvz,(IBAPP(ibt1,ibvz))))); (* []<<1>[]1>1 *)
val ibt9 = (IBAPP(ibt8,ibt3)); (* <<3><[]2>[]1> []<<1>[]1>1 *)

(* M'' - Combinatory logic *)
datatype CLEXP =  CAPP of CLEXP * CLEXP | CI of "I''" | CK of "K''" | CS of "S''" |  CID of string;

val cvx = (CID "x");
val cvy = (CID "y");
val cvz = (CID "z");
val ct1 = CI; (* I'' *)
val ct2 = (CAPP(CK, cvx); (* K'' x *)
val ct3 = (CAPP(CAPP(t1,t2),vz)); (* I'' (K'' x) z *)
val ct4 = (CAPP(t1,vz)); (* I'' z *)
val ct5 = (CAPP(t3,t3)); (* I''(K''x)z (I''(K''x)z) *)
val ct6 = CS; (* (Clambda-xyz).xz(yz) *)
val ct7 = CAPP(CAPP(t6,t1),t1); (* ((t6,t1)t1) *)
val ct8 = CAPP(CAPP(CS, CI), CI);
val ct9 = CAPP(t8,t3); (* (t8,t3) *)

