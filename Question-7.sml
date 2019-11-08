use "Question-4.sml";

fun Subterms2 (CID id) = [(CID id)] |
	Subterms2 (CI) = [(CI)] |
	Subterms2 (CK) = [(CK)] |
	Subterms2 (CS) = [(CS)] |
	Subterms2 (CAPP(e1, e2)) = [CAPP(Subterms2(e1), Subterms2(e2))] ;