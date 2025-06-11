abstract sig Object { //por abstractm object no va a tener elementos a menos que lo declaremos como abajo
	eats: set Object
}

//cada una de estas sig va a tener un solo elemento
one sig Farmer, Fox, Chicken, Grain extends Object {}

//ponemos las condiciones
fact eating {
	eats = Fox -> Chicken + Chicken -> Grain
}

sig State {
	near: set Object, //los elementos que esten aca van a estar cerca
	far: set Object,
}

open util/ordering[State]

fact initialState {
	let s0 = first[] |
		s0.near = Object && no s0.far
}
