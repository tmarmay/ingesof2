sig Addr, Data {}

sig Memory {
	addrs: set Addr, //addrs esta incluido en Addr, osea es un subconjunto
	map: Addr -> one Data //indica que hay una relacion entre Addr y Data (Addr x Data)
} { //como map es una relacion, no tiene porque ser funcion
	~map.map in iden  //ahora es funcion
	map.Data = addrs // map es total
} //tambien me puedo evitar esto agergando el one adelante de Data

//##############################

sig MainMemory extends Memory {} //Tengo una nueva instancia de memoria

sig Cache extends Memory { //Tengo una nueva instancia de memoria pero con un atributo mas 
	dirty: set addrs // dirty esta incluido en addrs, osea que tengo a lo sumo todas las addrs dirty
}

sig System {
	cache: Cache, //Hace como una instancia 
	main: MainMemory
}

//##############################

//la sig definen el dominio

// ++ es la union disjunta
// 	Son los elementos de ambas relaciones
//	Pero si tienen un elemento en comun (en el primer elemento de la tupla) 
//		pone el del segundo operando (2do elemento de la tupla) 
pred Write [mi, mo: Memory, d: Data, a: Addr] { //Escritura en sig!
	mo.map = mi.map ++ (a -> d) // en la direccion a quedate con el valor d (que es nuevo)
}

//##############################

// Con fact, pongo restricciones sobre mi conjunto

fact {
	all s:System | s.cache.addrs in s.main.addrs //para todos los modelos que me genera alloy, 
									    //las direcciones de cache tienen que estar en la main 
}

//##############################

//Con un assert puedo saber si una propiedad se cumple o no
assert {
	all s:System | //para todos los sistemas que me generes
		all a: s.cache.addrs-s.cache.dirty | // a son las direcciones que no estas sucias
		      s.cache.map[a] = s.main.map[a] // si no esta suscia => los datos deben conicidir
}

run {} for 3
