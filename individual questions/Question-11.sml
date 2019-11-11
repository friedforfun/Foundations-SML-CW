use "Question-10.sml";

fun numLredex l = List.length (ClrDup(loreduce(l))) -1 ;

fun leftreduce e = (Printlredexlist(loreduce(e)); print (Int.toString(numLredex(e))); print " steps \n");