import wollok.game.*
import monstruos.*

class Pociones{
	var property position

//Aparicion de la pocion
	method aparecer(posicionMonstruo) {
		position = posicionMonstruo
		self.image()
		game.schedule(3000, { =>self.desaparecer()})
	}
	method desaparecer(){ game.removeVisual(self)}
		
	method esEncontrado(personaje){}
	
	method image(){}
	method activar(){}
}

class PocionInvisibilidad inherits Pociones {
	 override method image() = "pocion_invisibilidad.png"

//Poder que activa la pocion en el personaje	
	//te da invisibilidad por un par de segundos y vida al maximo
	 override method activar(){	}
}

class PocionFuerza inherits Pociones {
	 override method image() = "pocion_fuerza.png"	

//Poder que activa la pocion en el personaje
	//te da poder extra, quizas por un tiempo determinado
	 override method activar(){	}
}

class PocionAturdimiento inherits Pociones {
	 override method image() = "pocion_aturdimiento.png"

//Poder que activa la pocion en el personaje
	//deja quieto a los bichos que esten al rededor del personaje, tipo 3 posiciones al rededor o bien a todos los personajes en general
	 override method activar(){	}
}