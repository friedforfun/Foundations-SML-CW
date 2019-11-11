(* 
	Foundations 1 Assignment 1
	Sam Fay-Hunt
	sf52
*)

use "sml-files.sml";

(* -------------- Question 3 ----------------------- *)
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
val bt8 = (BLAM(BAPP(BID 1,(BAPP(bt1,BID 1))))); (* ( \1((\1)1) ) *)
val bt9 = (BAPP(bt8,bt3)); (* (\1((\1)1))((\1)(\2)3) *)

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

(* one credex on ct9 *)
val ct10 = CAPP((CAPP(CI, CAPP(CAPP(CI, CAPP(CK, cvx)), cvz))), (CAPP(CI, CAPP(CAPP(CI, CAPP(CK, cvx)), cvz))));

(* -------------- Question 4 ----------------------- *)
(* M':  print item notation *)
fun printILEXP (IID v) = (print v; print " ") |
	printILEXP (ILAM (v,e)) = (print "["; print v; print "]"; printILEXP e) |
	printILEXP (IAPP (e1,e2)) = (print "<"; printILEXP e1; print ">"; printILEXP e2);

(* omega: print de Bruijn normal notation *)
fun printBLEXP (BID v) = print (Int.toString v) |
	printBLEXP (BLAM (e)) = (print "(\\"; printBLEXP(e); print ")") |
	printBLEXP (BAPP (e1,e2)) = (print "("; printBLEXP (e1); print " "; printBLEXP (e2); print ")");

(* omega Prime: print de Bruijn in item notation *)
fun printIBLEXP (IBID v) = print (Int.toString v) |
	printIBLEXP (IBLAM (e)) = (print "[]"; printIBLEXP(e)) |
	printIBLEXP (IBAPP (e1, e2)) = (print "<"; printIBLEXP(e1); print ">"; printIBLEXP(e2) );

(* M'': combinator *)
fun printCOM (CID v) = print v |
	printCOM (CI) = print "I''" |
	printCOM (CK) = print "K''" |
	printCOM (CS) = print "S''" |
	printCOM (CAPP (e1, e2)) = (print "("; printCOM (e1); print " "; printCOM(e2); print ")");

(* -------------- Question 5 ----------------------- *)

fun Cfree id1 (CID id2) = if (id1 = CID id2) then true else false |
	Cfree id (CAPP(e1, e2)) = (Cfree id e1) orelse (Cfree id e2) |
	Cfree id CI = false |
	Cfree id CK = false |
	Cfree id CS = false;

(* is free in M': for fun. *)
fun Ifree id1 (IID id2) = if (id1 = id2) then  true else false |
    Ifree id1 (IAPP(e1,e2))= (Ifree id1 e1) orelse (Ifree id1 e2) | 
    Ifree id1 (ILAM(id2, e1)) = if (id1 = id2) then false else (Ifree id1 e1);

(* return left / right hand side of CAPP*)
fun lhs (CAPP(e1, e2)) = e1;
fun rhs (CAPP(e1,e2)) = e2;
	
(* Accompanying function for translating to combinatory logic, converted from datasheet *)
fun fFun (v1, v2) = if (v1 = v2) then (CI) 
								else if not(Cfree v1 v2) then (CAPP(CK, v2))
								else if not(Cfree v1 (lhs(v2))) andalso (v1 = (rhs(v2))) then lhs(v2)
								else (CAPP(CAPP(CS, fFun(v1, (lhs(v2)))), fFun(v1, (rhs(v2)))));

(* translate lambda term to item notation *)
fun Itran (ID id) = (IID id) |
	Itran (LAM(v,e)) = (ILAM(v, Itran(e))) |
	Itran (APP(e1,e2)) = IAPP(Itran(e2), Itran(e1));

(* translate lambda term to combinatory logic *)
fun Utran (ID id) = (CID id) |
	Utran (LAM(v,e)) = fFun(CID v, Utran(e)) |
	Utran (APP(e1,e2)) = (CAPP(Utran(e1), Utran(e2)));


(* translate lambda item notation term to combinatory logic *)
fun Ttran (IID id) = (CID id) |
	Ttran (ILAM(v,e)) = fFun(CID v, Ttran(e)) |
	Ttran (IAPP(e1, e2)) = (CAPP(Ttran(e1), Ttran(e2))) ;

(* -------------- Question 7 ----------------------- *)

(* return list of subterms with duplicates *)
fun subterms (CID id) = [(CID id)] |
	subterms (CI) = [(CI)] |
	subterms (CK) = [(CK)] |
	subterms (CS) = [(CS)] |
	subterms (CAPP(e1, e2)) = [CAPP(e1, e2)] @ (subterms e1) @ (subterms e2);

(* clear duplicates from a list *)
fun ClrDup [] = [] |
	ClrDup (h::t) = h :: ClrDup (List.filter (fn x => x <> h) t) ;

(* returns a list of the set of subterms *)
fun setterms t = ClrDup(subterms(t));

(* print a list of COM datatype *)
fun PrintCOMlist [] =  print "" |
	PrintCOMlist (h::t)= (printCOM h; print "\n"; PrintCOMlist t);

(* print helper function *)
fun printlistcomb t = PrintCOMlist(setterms(t));

(* -------------- Question 8 ----------------------- *)

fun is_credex (CAPP(CI, _)) = true |
	is_credex (CAPP(CAPP(CK, _), _)) = true |
	is_credex (CAPP(CAPP(CAPP(CS, _), _), _)) = true |
	is_credex _ = false;

fun has_credex (CID id) = false |
	has_credex (CI) = false |
	has_credex (CS) = false |
	has_credex (CK) = false |
	has_credex (CAPP(e1, e2)) = if (is_credex (CAPP(e1,e2))) then true 
								else ((has_credex e1) orelse (has_credex e2));

(* perform eta reduction once *)
fun one_credex (CAPP(CI, e)) = e |
	one_credex (CAPP(CAPP(CK, e1), e2)) = e1 |
	one_credex (CAPP(CAPP(CAPP(CS, e1), e2), e3)) = (CAPP(CAPP(e1, e3), CAPP(e2, e3))) ;


(* adds capp backward to list *)
fun caddbackapp [] e2 = []|
    caddbackapp (e1::l) e2 = (CAPP(e1,e2)):: (caddbackapp l e2);

(* adds capp forward to list *)
fun caddfrontapp e1 [] = []|
    caddfrontapp e1  (e2::l) = (CAPP(e1,e2)):: (caddfrontapp e1 l);

(* perform eta reduction and return list of eta reduction steps *)
fun cmreduce (CID id) =  [(CID id)] | 
	cmreduce (CI) = [(CI)] |
	cmreduce (CK) = [(CK)] |
	cmreduce (CS) = [(CS)] |
	cmreduce (CAPP(e1,e2)) = (let val l1 = (cmreduce e1)
				val l2 = (cmreduce e2)
				val l3 = (caddbackapp l1 e2)				
				val l4 = (caddfrontapp (List.last l1) l2)
				val l5 = (List.last l4)
				val l6 =  if (is_credex l5) then (cmreduce (one_credex l5)) else [l5]
			    in l3 @ l4 @ l6
			    end);


(* print COM redex list *)
fun Printcredexlist [] =  print "" |
	Printcredexlist (h::nil) = (printCOM h; print "\n") |
	Printcredexlist (h::t)= (printCOM h; print "--> \n"; Printcredexlist t);

(* ---Question 9--- *)
fun numCredex l = List.length (ClrDup(cmreduce(l))) -1 ;
fun printcredexnum t = ClrDup(cmreduce(t));
(* -------------- Question 8 / 9 ----------------------- *)
fun	credex e = (Printcredexlist(ClrDup(cmreduce(e))); print (Int.toString(numCredex(e))); print " steps \n");

(* -------------- Question 10 ----------------------- *)

fun is_eredex (LAM(id, (APP(e1, e2)))) = (if not(free id e1) andalso (ID id = e2) then true else false) |
	is_eredex (_) = false;

fun has_eredex (ID id) = false |
	has_eredex (APP(e1, e2)) = ((has_eredex(e1)) orelse (has_eredex(e2))) |
	has_eredex (LAM(id, e)) = if (is_eredex(LAM(id, e))) then true else (has_eredex(e));

(* perform eta reduction *)
fun ered (LAM(id, (APP(e1, e2)))) = e1;

(* find next eta reduction *)
fun one_ereduce (ID id) = (ID id) |
	one_ereduce (APP(e1, e2)) = (APP(one_ereduce(e1), one_ereduce(e2))) |
	one_ereduce (LAM(id, e)) = if (is_eredex(LAM(id, e))) then ered(LAM(id, e)) 
								else if (has_eredex(e)) then one_ereduce(e)
								else e;

(* perform eta reduction and return list of eta reduction steps *)
fun eloreduce (ID id) =  [(ID id)] |
    eloreduce (LAM(id,e)) = if (is_eredex(LAM(id,e))) then ([(LAM(id, e))]@(eloreduce (ered(LAM(id,e))))) else (addlam id (eloreduce e)) |
    eloreduce (APP(e1,e2)) = (let val l1 = 
				 if (has_eredex e1) then (eloreduce (APP(one_ereduce e1, e2))) else 
				 if (has_eredex e2) then  (eloreduce (APP(e1, (one_ereduce e2)))) else []
				 in [APP(e1,e2)]@l1
			      end);

(* print LEXP reduction list *)
fun Printlredexlist [] =  print "" |
	Printlredexlist (h::nil) = (printLEXP h; print "\n") |
	Printlredexlist (h::t)= (printLEXP h; print "--> \n"; Printlredexlist t);

(* visualise clear eta reduction *)
fun ereduce e = (Printlredexlist(eloreduce(e)));

(* test val for Q10 *)
val t10 = (LAM("x", APP(vy, vx)));
val t11 = (APP((LAM("z", (APP(t1, vz)))), t10));
val t12 = (LAM("x", (APP(t10, t11))));
val t13 = (LAM("x", APP(t12, vx)));
val t14 = (APP((LAM("y", (APP(t13, vy)))), t6));
val t15 = (LAM("x", (APP(t1, vx))));
val t16 = (APP(t15, t15));
val t17 = (APP(t16, t16));


(* -------------- Question 11 ----------------------- *)

(* gives the number of reduction steps *)
fun numLredex l = List.length (ClrDup(loreduce(l))) -1 ;

(* Print loreduce with arrows, and number of steps *)
fun leftreduce e = (Printlredexlist(loreduce(e)); print (Int.toString(numLredex(e))); print " steps \n");