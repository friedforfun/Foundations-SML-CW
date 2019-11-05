use "Question-3.sml";

(* M':  print item notation *)
fun printILEXP (IID v) = (print v; print " ") |
	printILEXP (ILAM (v,e)) = (print "["; print v; print "]"; printILEXP e) |
	printILEXP (IAPP (e1,e2)) = (print "<"; printILEXP e1; print ">"; printILEXP e2);

(* omega: print de Bruijn normal notation *)
fun printBLEXP (BID v) = print (int.toString v) |
	printBLEXP (BLAM (e)) = (print "(\\ "; printBLEXP(e); print ")") |
	printBLEXP (BAPP (e1,e2)) = (print "("; printBLEXP (e1); print " "; printBLEXP (e2); print ")");
