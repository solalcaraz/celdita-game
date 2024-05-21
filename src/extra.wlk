import wollok.game.*
import tomas.*

object espada {
	var property position = game.at(15, 7)
	
	method image() = "espada.png"
	method esEncontrado(personaje) {
		personaje.tieneEspada(true)
		self.desaparecer()
	}
	
	method proximidadTomas(collider){
		game.say(self, "Una espada!\nLevántala con 'n'.")
	}
	method desaparecer(){ game.removeVisual(self)}
}