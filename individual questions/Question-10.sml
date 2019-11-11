use "Question-8.sml";

(* implement eta reduction in M *)

fun is_eredex (LAM(id, (APP(e1, e2)))) = (if not(free id e1) andalso (ID id = e2) then true else false) |
	is_eredex (_) = false;

fun has_eredex (ID id) = false |
	has_eredex (APP(e1, e2)) = ((has_eredex(e1)) orelse (has_eredex(e2))) |
	has_eredex (LAM(id, e)) = if (is_eredex(LAM(id, e))) then true else (has_eredex(e));

fun ered (LAM(id, (APP(e1, e2)))) = e1;

fun one_ereduce (ID id) = (ID id) |
	one_ereduce (APP(e1, e2)) = (APP(one_ereduce(e1), one_ereduce(e2))) |
	one_ereduce (LAM(id, e)) = if (is_eredex(LAM(id, e))) then ered(LAM(id, e)) 
								else if (has_eredex(e)) then one_ereduce(e)
								else e;


fun eloreduce (ID id) =  [(ID id)] |
    eloreduce (LAM(id,e)) = if (is_eredex(LAM(id,e))) then ([(LAM(id, e))]@(eloreduce (ered(LAM(id,e))))) else (addlam id (eloreduce e)) |
    eloreduce (APP(e1,e2)) = (let val l1 = 
				 if (has_eredex e1) then (eloreduce (APP(one_ereduce e1, e2))) else 
				 if (has_eredex e2) then  (eloreduce (APP(e1, (one_ereduce e2)))) else []
				 in [APP(e1,e2)]@l1
			      end);

fun Printlredexlist [] =  print "" |
	Printlredexlist (h::nil) = (printLEXP h; print "\n") |
	Printlredexlist (h::t)= (printLEXP h; print "--> \n"; Printlredexlist t);

fun ereduce e = (Printlredexlist(eloreduce(e)));

(* tests for Q10 *)
val t10 = (LAM("x", APP(vy, vx)));
val t11 = (APP((LAM("z", (APP(t1, vz)))), t10));
val t12 = (LAM("x", (APP(t10, t11))));
val t13 = (LAM("x", APP(t12, vx)));
val t14 = (APP((LAM("y", (APP(t13, vy)))), t6));
val t15 = (LAM("x", (APP(t1, vx))));
val t16 = (APP(t15, t15));
val t17 = (APP(t16, t16));
