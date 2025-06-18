// ejercicios 1 y 2 
sig VueloID, Ciudad, Horario {}

sig Aeroline{
    nrovuelo: set VueloID,
    ruta_directa : nrovuelo -> one Ciudad -> Ciudad,
    partidas : nrovuelo -> one Horario,
    arribos: nrovuelo ->  one Horario
} 

// ejercicio 3
fact unico {
    all a1,a2 : Aeroline | no ((a1.nrovuelo) & (a2.nrovuelo)) or a1=a2
}

//ejercicio 4 
pred reach [a: Aeroline, c_org,c_dest : Ciudad]{
    c_org -> c_dest in ^(a.ruta_directa[a.nrovuelo])
}

fun origen [a:Aeroline, cd: Ciudad]: set Ciudad{
    *( (a.ruta_directa[a.nrovuelo])) . cd
}

//dado un horario una ciudad de orgien y una de destino 
//quiero construir las rutas que salen
// hay un vuelo desde origen a destino en el horario con cualquier aerolinia

pred ruta_global [h: Horario, co,cd : Ciudad]{
    let v = (Aeroline.partidas).h | 
    // salida                           //
    cd in (((Aeroline.ruta_directa)[v][co]) . * (Aeroline.ruta_directa[VueloID]))
}
