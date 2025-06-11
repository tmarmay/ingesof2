sig Interprete {}

sig Cancion {}

sig Catalogo {
	canciones: set Cancion,
	interpretes: set Interprete,
	interpretaciones: canciones -> interpretes
}{
	all c: canciones | some i: interpretes | c -> i in interpretaciones
    	all i: interpretes | some c: canciones | c -> i in interpretaciones
}

//fact CantidadesExactas {
//    #Cancion = 2
//    #Interprete = 1
//}


//run {} for 2 Cancion, 1 Interprete, 1 Catalogo

//a) Un predicado que dado un catalogo y una cancion con su interprete, devuelva un nuevo catalogo igual al primero pero con esa interpretacion agragada.
pred agregarInterpretacion[cat_in, cat_out: Catalogo, can: Cancion, inter: Interprete] {
	// Aseguramos que ya estaban, osea que ese interprete nunca habia cantado esa cancion hasta ahora
	can in cat_in.canciones
	inter in cat_in.interpretes

	// Las canciones e intérpretes no cambian
	cat_out.canciones = cat_in.canciones
	cat_out.interpretes = cat_in.interpretes
	
	// Interpretaciones: iguales pero agregando nuevo elemento a la relacion
	cat_out.interpretaciones = cat_in.interpretaciones + (can -> inter)
}


//run {
//    some cat_in,cat_out: Catalogo, c: Cancion, i: Interprete |
//        agregarInterpretacion[cat_in, cat_out, c, i]
//}


//b) Un predicado que dado un catalogo y una cancion con su interprete, devuelva un nuevo catalogo igual al primero pero eliminando esa interpretacion
pred eliminaInterpretacion[cat_in, cat_out: Catalogo, can: Cancion, inter: Interprete] {
	// Las canciones e intérpretes no cambian
	cat_out.canciones = cat_in.canciones
	cat_out.interpretes = cat_in.interpretes
	
	// Interpretaciones: iguales pero agregando nuevo elemento a la relacion
	cat_out.interpretaciones = cat_in.interpretaciones - (can -> inter)
}

//run {
//    some cat_in,cat_out: Catalogo, c: Cancion, i: Interprete |
//        eliminaInterpretacion[cat_in, cat_out, c, i]
//}

//c) Una funcion que, dado un catalogo, devuelva los pares de interpretes que interpretan la misma cancion.
fun paresMismoTema(cat: Catalogo): set Interprete -> Interprete {
  {i1, i2: cat.interpretes |
    some c: cat.canciones |
      (c -> i1 in cat.interpretaciones and c -> i2 in cat.interpretaciones and i1 != i2)
  }
}

run {
    some cat: Catalogo |
        some paresMismoTema[cat]
}

