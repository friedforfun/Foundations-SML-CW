use "Question-4.sml";

fun Ufree (CID id1) (CID id2) = if (id1 = id2) then true else false |
	Ufree (CID id1) (CAPP(e1, e2)) = (Ufree id1 e1) orelse (Ufree id1 e2) |
	Ufree (CID id1) CI = false |
	Ufree (CID id1) CK = false |
	Ufree (CID id1) CS = false;

fun CoTerm (CID v, CID v) = CI |
	CoTerm (CID v, COM p) = if (not(Ufree v p)) then CAPP(CK, p) else false |
	CoTerm (CID v, CAPP(p1, p2)) = if ((not(Ufree v p1)) andalso v = p2) then p1 else CAPP(CAPP(CS, CoTerm(v, p1)), CoTerm(v, p2));

fun Itran (ID id) = (IID id) |
	Itran (LAM(v,e)) = (ILAM(v, Itran(e))) |
	Itran (APP(e1,e2)) = IAPP(Itran(e2), Itran(e1));

fun Utran (ID id) = (CID id) |
	Utran (LAM(v,e)) = CoTerm(v, Utran(e)) |
	Utran (APP(e1,e2)) = (CAPP(Utran(e1), Utran(e2)));

(*
fun Ttran (IID id) = (CID id) |
	Ttran (ILAM(v,e)) = ... |
	Ttran (IAPP(e1, e2)) = (CAPP(Ttran(e1), Ttran(e2))) ;
*)


(* ------------  For reference --------------------------------
  fun free id1 (ID id2) = if (id1 = id2) then  true else false|
    free id1 (APP(e1,e2))= (free id1 e1) orelse (free id1 e2) | 
    free id1 (LAM(id2, e1)) = if (id1 = id2) then false else (free id1 e1);

*)