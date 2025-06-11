sig Elemento {}

sig Relacion {
    R: Elemento -> Elemento
}

fact TamañoExacto {
  #Elemento = 3
}


// b) Orden parcial
pred Reflexiva[r: Elemento -> Elemento] {
  all e: Elemento | e -> e in r
}

pred Antisimetrica[r: Elemento -> Elemento] {
  all e1, e2: Elemento |
    (e1 -> e2 in r and e2 -> e1 in r) implies e1 = e2
}

pred Transitiva[r: Elemento -> Elemento] {
  all e1, e2, e3: Elemento |
    (e1 -> e2 in r and e2 -> e3 in r) implies e1 -> e3 in r
}

pred OrdenParcial[r: Elemento -> Elemento] {
    Reflexiva[r]
    Antisimetrica[r]
    Transitiva[r]
}

//run {
//    all r: Relacion | OrdenParcial[r.R]
//}


//c) Orden total 
pred Total[r: Elemento -> Elemento] {
	all a,b: Elemento |
		a != b implies (a -> b in r or b -> a in r) 
}
pred OrdenTotal[r: Elemento -> Elemento] {
    OrdenParcial[r]
    Total[r]
}

//run {
//    all r: Relacion | OrdenTotal[r.R]
//}


//d) Orden estricto
pred Irreflexividad[r: Elemento -> Elemento] {
    all e: Elemento | e -> e not in r
}

pred OrdenEstricto[r: Elemento -> Elemento] {
    Irreflexividad[r]
    Transitiva[r]
}

//run {
//    all r: Relacion | OrdenEstricto[r.R]
//}

//Asserts -> contra-ejemplo

// Sabemos que no es falsa
assert TodoOrdenParcialEsTotal {
    all r: Relacion |
        OrdenParcial[r.R] implies Total[r.R]
}
//check TodoOrdenParcialEsTotal for 3


