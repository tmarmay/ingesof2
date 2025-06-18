sig Interprete {}

sig Cancion {}

sig Catalogo {
	canciones: set Cancion,
	interpretes: set Interprete,
	interpretaciones: canciones -> interpretes
}{
	no (canciones - (interpretaciones . interpretes)) // puedo decir que sea igual con el no chequeando se que sea vacio
	interpretes = interpretaciones[canciones]  // o de esta forma diciendo que son iguales 
}
// Para probar 
//run {} for 1 Catalogo, 1 Cancion, 2 Interprete


//A)
pred New[ci,co: Catalogo, c: Cancion, i: Interprete] {
	co.canciones = ci.canciones ++ c
	co.interpretes = ci.interpretes ++ i
	co.interpretaciones = ci.interpretaciones ++ (c -> i)
}

//B)
pred Delete[ci,co: Catalogo, c: Cancion, i: Interprete] {
	co.canciones = ci.canciones - c
	co.interpretes = ci.interpretes - i
	co.interpretaciones = ci.interpretaciones - (c -> i)
}
//run Delete for 2 Catalogo, 2 Cancion, 2 Interprete

//C
fun MismosInterpretes(cat: Catalogo): set Interprete -> Interprete {
	let inter = cat.interpretaciones |	
	( ~inter . inter ) - iden
}

pred mostrar_funcion (c: Catalogo, inter: (Interprete -> Interprete)) {
    inter = MismosInterpretes[c]
    some can: c.canciones | #(can.(c.interpretaciones))>2
}

run mostrar_funcion for 3 but 2 Catalogo
