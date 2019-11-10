use "Question-4.sml";

fun Cfree id1 (CID id2) = if (id1 = CID id2) then true else false |
	Cfree id (CAPP(e1, e2)) = (Cfree id e1) orelse (Cfree id e2) |
	Cfree id CI = false |
	Cfree id CK = false |
	Cfree id CS = false;


(* is free in M': for fun. *)
fun Ifree id1 (IID id2) = if (id1 = id2) then  true else false |
    Ifree id1 (IAPP(e1,e2))= (Ifree id1 e1) orelse (Ifree id1 e2) | 
    Ifree id1 (ILAM(id2, e1)) = if (id1 = id2) then false else (Ifree id1 e1);



fun lhs (CAPP(e1, e2)) = e1;
fun rhs (CAPP(e1,e2)) = e2;
(*
fun CoFun (v, (CID v2)) = if (v = v2) then CI else CAPP(CK, CID v2) |
	CoFun (v, v2) = if not(Cfree v v2) then (CAPP(CK, v2)) 
								else if not(Cfree v (lhs(v2))) andalso (v = (rhs(v2))) then lhs(v2)  
							  	else (CAPP(CAPP(CS, CoFun(v, (lhs(v2)))), CoFun(v, (rhs(v2)))));
*)						  		


	
fun fFun (v1, v2) = if (v1 = v2) then (CI) 
								else if not(Cfree v1 v2) then (CAPP(CK, v2))
								else if not(Cfree v1 (lhs(v2))) andalso (v1 = (rhs(v2))) then lhs(v2)
								else (CAPP(CAPP(CS, fFun(v1, (lhs(v2)))), fFun(v1, (rhs(v2)))));



fun Itran (ID id) = (IID id) |
	Itran (LAM(v,e)) = (ILAM(v, Itran(e))) |
	Itran (APP(e1,e2)) = IAPP(Itran(e2), Itran(e1));


fun Utran (ID id) = (CID id) |
	Utran (LAM(v,e)) = fFun(CID v, Utran(e)) |
	Utran (APP(e1,e2)) = (CAPP(Utran(e1), Utran(e2)));



fun Ttran (IID id) = (CID id) |
	Ttran (ILAM(v,e)) = fFun(CID v, Ttran(e)) |
	Ttran (IAPP(e1, e2)) = (CAPP(Ttran(e1), Ttran(e2))) ;



(* ------------  For reference --------------------------------
  fun free id1 (ID id2) = if (id1 = id2) then  true else false|
    free id1 (APP(e1,e2))= (free id1 e1) orelse (free id1 e2) | 
    free id1 (LAM(id2, e1)) = if (id1 = id2) then false else (free id1 e1);

*)