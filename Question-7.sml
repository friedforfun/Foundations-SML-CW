use "Question-4.sml";
Control.Print.printDepth := 1024;


fun Subterms2d (CID id) = [(CID id)] |
	Subterms2d (CI) = [(CI)] |
	Subterms2d (CK) = [(CK)] |
	Subterms2d (CS) = [(CS)] |
	Subterms2d (CAPP(e1, e2)) = [CAPP(e1, e2)] @ (Subterms2d e1) @ (Subterms2d e2);

fun ClrDup [] = [] |
	ClrDup (h::t) = h :: ClrDup (List.filter (fn x => x <> h) t) ;

fun Subterms2 t = ClrDup(Subterms2d(t));
