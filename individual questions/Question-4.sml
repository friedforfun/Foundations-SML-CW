use "Question-3.sml";

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

(* 
fun freeVars (ID id2)       = [id2]
  | freeVars (APP(e1,e2))   = freeVars e1 @ freeVars e2
  | freeVars (LAM(id2, e1)) = List.filter (fn x => not (x = id2)) (freeVars e1); 
*)

