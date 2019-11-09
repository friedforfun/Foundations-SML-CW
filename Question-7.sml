use "Question-4.sml";
Control.Print.printDepth := 1024;

fun subterms (CID id) = [(CID id)] |
	subterms (CI) = [(CI)] |
	subterms (CK) = [(CK)] |
	subterms (CS) = [(CS)] |
	subterms (CAPP(e1, e2)) = [CAPP(e1, e2)] @ (subterms e1) @ (subterms e2);

fun ClrDup [] = [] |
	ClrDup (h::t) = h :: ClrDup (List.filter (fn x => x <> h) t) ;

fun setterms t = ClrDup(subterms(t));

fun PrintCOMlist [] =  print "" |
	PrintCOMlist (h::t)= (printCOM h; print "\n"; PrintCOMlist t);

fun printlistcomb t = PrintCOMlist(setterms(t));