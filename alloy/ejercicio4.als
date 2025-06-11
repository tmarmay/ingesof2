// Un nodo en el grafo
sig Nodo { 
    alcanza: set Nodo  // Relación de alcanzabilidad directa
}


//a) grafo acicliclo
fun alcanzable[n: Nodo]: set Nodo {
    n.^alcanza
}
pred esAiclico() {
    all n: Nodo | n not in alcanzable[n]
}

//run {
//    esAiclico[]
//} for 5


//b) grafo no dirigido
pred NoDirigido() {
	alcanza = ~alcanza
}

//run {
//    NoDirigido[]
//} for 3


//c) grafo fuertemente conexo
pred FuerteConexo() {
    all n: Nodo | 
		all k: Nodo | k in alcanzable[n]
}

//run {
//    FuerteConexo[]
//} for 5


//d) el grafo es conexo 
pred Conexo() {
    let r = *alcanza + ~*alcanza |
        all a, b: Nodo | a -> b in r
}

run {
    Conexo[]
} for 6
