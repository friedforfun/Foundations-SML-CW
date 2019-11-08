use "Question-4.sml";
Control.Print.printDepth := 1024;

fun Subterms2 (CID id) = [(CID id)] |
	Subterms2 (CI) = [(CI)] |
	Subterms2 (CK) = [(CK)] |
	Subterms2 (CS) = [(CS)] |
	Subterms2 (CAPP(e1, e2)) = [CAPP(e1, e2)] @ (Subterms2 e1) @ (Subterms2 e2);