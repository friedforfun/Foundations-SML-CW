use "Question-4.sml";

fun Itran (ID id) = (IID id) |
	Itran (LAM(v,e)) = (ILAM(v, Itran(e))) |
	Itran (APP(e1,e2)) = IAPP(Itran(e2), Itran(e1));

