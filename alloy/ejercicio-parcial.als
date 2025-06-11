sig VueloId, Ciudad, Horario {}

sig Aerolinea {
	nro_vuelos: set VueloId,
	ruta_directa: VueloId -> Ciudad -> Ciudad,
	partidas: VueloId -> Horario,
	arribos: VueloId -> Horario
}

///I: para cada aerolinea, cada vuelo tiene una unica ruta directa asociada, un unico horaio de partida y llegada
pred unic[] {
  all a: Aerolinea, v: VueloId |
    v in a.nro_vuelos implies (
      one c1, c2: Ciudad | v -> c1 -> c2 in a.ruta_directa and
      one h1: Horario | v -> h1 in a.partidas and
      one h2: Horario | v -> h2 in a.arribos
    )
}

//II: todos los numero de vuelos tienen asignado una ruta directa y los horarios de partida y arrivo
pred asig[]{
  all a: Aerolinea, v: VueloId |
    v in a.nro_vuelos implies (
	
    )
}

//III: numeros de vuelos globalmente unicos
pred numeros_globales_unicos[] {
	all a1, a2: Aerolinea | 
		a1 != a2 implies no (a1.nro_vuelos & a2.nro_vuelos)
}

fact {
	asig[]
	numeros_globales_unicos[]
}
