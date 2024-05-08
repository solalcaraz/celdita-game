import wollok.game.*
import tomas.*

object espada {
	var property position = game.at(15, 7)
	
	method image() = "espada.png"
	method esEncontrado(personaje) {}
	method desaparecer(){ game.removeVisual(self)}
}