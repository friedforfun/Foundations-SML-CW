
datatype ILEXP = IAPP of ILEXP * ILEXP | ILAM of string * ILEXP | IID of string;

val ivx = (IID "x");
val ivy = (IID "y");
val ivz = (IID "z");
val it1 = (ILAM("x",ivx)); 
val it2 = (ILAM("y",ivx)); 
val it3 = (IAPP(IAPP(it1,it2),ivz)); 
val it4 = (IAPP(it1,ivz)); 
val it5 = (IAPP(it3,it3));
val it6 = (ILAM("x",(ILAM("y",(ILAM("z",(IAPP(IAPP(ivx,ivz),(IAPP(ivy,ivz))))))))));
val it7 = (IAPP(IAPP(it6,it1),it1));
val it8 = (ILAM("z", (IAPP(ivz,(IAPP(it1,ivz))))));
val it9 = (IAPP(it8,it3));


datatype BLEXP = BAPP of BLEXP * BLEXP | BLAM of string * BLEXP | BID of string;

val bvx = (BID 1);
val bvy = (BID 2);
val bvz = (BID 3);
val bt1 = (BLAM(bvx)); (* \1 *)
val bt2 = (BLAM(bvy)); (* \2 *)
val bt3 = (BAPP(BAPP(bt1,bt2),bvz));  (* (\1)(\2)3 *)
val bt4 = (BAPP(bt1,bvz)); (* (\1)3 *)
val bt5 = (BAPP(bt3,bt3)); (* (\1)(\2)3 ((\1)(\2)3) *)
val bt6 = (BLAM((BLAM((BLAM((BAPP(BAPP(bvx,bvz),(BAPP(bvy,bvz)))))))))); (* \\\31(21) *)
val bt7 = (BAPP(BAPP(bt6,bt1),bt1)); (* ((\\\31(21))(\1))(\1) *)
val bt8 = (BLAM((BAPP(bvz,(BAPP(bt1,bvz)))))); (* ( \1((\1)1) ) THIS WILL NOT PRINT CORRECTLY BY DEFAULT *)
val bt9 = (BAPP(bt8,bt3)); (* (\1((\1)1))((\1)(\2)3) WONT PRINT BY DEFAULT *)
<<<<<<< HEAD


datatype IBLEXP =  IBAPP of IBLEXP * IBLEXP | IBLAM of string *  IBLEXP |  IBID of string;

val ibvx = (IBID 1);
val ibvy = (IBID 2);
val ibvz = (IBID 3);
val ibt1 = (IBLAM(ibvx)); (* []1 *)
val ibt2 = (IBLAM(ibvx)); (* []2 *)
val ibt3 = (APP(APP(ibt1,ibt2),ibvz)); (* ([]1)([]2)3  *)
val ibt4 = (APP(ibt1,ibvz)); (* ([]1)3 *)
val ibt5 = (APP(ibt3,ibt3)); (* ([]1)([]2)3 (([]1)([]2)3) *)
val ibt6 = (IBLAM((IBLAM((IBLAM((APP(APP(ibvx,ibvz),(APP(ibvy,ibvz)))))))))); (* [][][]31(21) *)
val ibt7 = (APP(APP(ibt6,ibt1),ibt1)); (* (([][][]31(21))([]1))([]1) *)
val ibt8 = (IBLAM((APP(ibvz,(APP(ibt1,ibvz)))))); (* []1(([]1)1) *)
val ibt9 = (APP(ibt8,ibt3)); (* ([]1(([]1)1))(([]1)([]2)3) *)
=======
>>>>>>> origin/master
