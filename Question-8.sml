use "Question-7.sml";

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

fun one_credex (CAPP(CI, e)) = e |
	one_credex (CAPP(CAPP(CK, e1), e2)) = e1 |
	one_credex (CAPP(CAPP(CAPP(CS, e1), e2), e3)) = (CAPP(CAPP(e1, e3), CAPP(e2, e3))) ;


(*
fun find_credex (CAPP(e1, e2)) = 
*)

fun lbranch (CAPP(e1, e2)) = e1;

fun list_credex [] = [] |
	list_credex ((CAPP(e1, e2))::t) = if is_credex(CAPP(e1, e2)) then (CAPP(e1, e2))::[one_credex(CAPP(e1, e2))]::t 
										else if has_credex(e1)  

fun credex t = if has_credex(t) then list_credex([t]) else raise Fail "this term has no redex";

(*

[ct9] [ct10] [ct11]

fun	credex (CAPP(e1, e2)) = 
								if is_credex(CAPP(e1, e2)) then
									one_credex(CAPP(e1,e2))
								else CAPP(credex(e1), credex(e2))
							
	
*)
	(*credex (CAPP(e1, e2)) = if has_credex(e1)
*)
