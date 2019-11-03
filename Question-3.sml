
datatype ILEXP = IAPP of ILEXP * ILEXP | ILAM of string * ILEXP | IID of string;

val ivx = (IID "x");
val ivy = (IID "y");
val ivz = (IID "z");
val it1 = (ILAM("x",ivx)); 
val it2 = (ILAM("y",ivx)); 
val it3 = (IAPP(IAPP(it1,it2),ivz)); 
val it4 = (IAPP(it1,ivz)); 
val it5 = (IAPP(it3,it3));
val it6 = (ILAM("x",(ILAM("y",(ILAM("z",(IAPP(IAPP(ivx,ivz),(IAPP(ivy,ivz))))))))));
val it7 = (IAPP(IAPP(it6,it1),it1));
val it8 = (ILAM("z", (IAPP(ivz,(IAPP(it1,ivz))))));
val it9 = (IAPP(it8,it3));
