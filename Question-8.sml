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


(* adds capp backward to list *)
fun caddbackapp [] e2 = []|
    caddbackapp (e1::l) e2 = (CAPP(e1,e2)):: (caddbackapp l e2);

(* adds capp forward to list *)
fun caddfrontapp e1 [] = []|
    caddfrontapp e1  (e2::l) = (CAPP(e1,e2)):: (caddfrontapp e1 l);

fun creduce (CID id) =  [(CID id)] | 
	creduce (CI) = [(CI)] |
	creduce (CK) = [(CK)] |
	creduce (CS) = [(CS)] |
	creduce (CAPP(e1,e2)) = (let val l1 = (creduce e1)
				val l2 = (creduce e2)
				val l3 = (caddbackapp l1 e2)				
				val l4 = (caddfrontapp (List.last l1) l2)
				val l5 = (List.last l4)
				val l6 =  if (is_credex l5) then (creduce (one_credex l5)) else [l5]
			    in l3 @ l4 @ l6
			    end);

fun Printcredexlist [] =  print "" |
	Printcredexlist (h::nil) = (printCOM h; print "\n") |
	Printcredexlist (h::t)= (printCOM h; print "--> \n"; Printcredexlist t);

fun numCredex l = List.length (ClrDup(creduce(l))) -1 ;

fun printcredexnum t = ClrDup(creduce(t));

fun	credex e = (Printcredexlist(ClrDup(creduce(e))); print (Int.toString(numCredex(e))); print " steps \n");