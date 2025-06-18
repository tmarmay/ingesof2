sig VueloID, Ciudad, Horario {}
sig Alianza {}

sig Aerolinea {
	  nro_vuelo : set VueloID, //B, hago que todos los campos de vueloID sean iguales
	  rutadirecta: nro_vuelo -> one Ciudad -> Ciudad,
	  partidas: nro_vuelo -> one Horario, //A
	  arribos: nro_vuelo -> one Horario,
	  socio: nro_vuelo -> lone Alianza //C
}

//D, necestio fact para interacturar con disintas aerolineas
fact DistintosNroVuelo {
	all a1,a2: Aerolinea |
		no (a1.arribos . Horario) & (a2.arribos . Horario) or a1 = a2
}

//E hay rura (no necesariamente directa) 
pred HayRuta[a:Aerolinea, co,cd: Ciudad] {
	(co ->  cd) in ^(a.rutadirecta[VueloID])
}

//run HayRuta for 2 Aerolinea, 3 VueloID, 6 Horario, 1 Alianza, 3 Ciudad

//F returne todos los numeros de vuelos que tienen ruta directa entre dichas ciudades en el horario indicado
fun GetVuelos(a:Alianza, co,cd: Ciudad, hpartida:Horario): set VueloID {
	((Aerolinea.rutadirecta . cd) . co) & (Aerolinea.partidas . hpartida) & (Aerolinea.socio . a)
}

pred show[al:Alianza, co,cd:Ciudad, conj: set VueloID, h: Horario]{
	conj = GetVuelos[al, co, cd, h]
	no (conj)
	#(conj)>2
}

run show for 24
