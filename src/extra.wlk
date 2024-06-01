import wollok.game.*
import tomas.*

object espada {
	var property esCaminable = true
	var property position = game.at(15, 7)
	
	method image() = "espada.png"
	
	method proximidadTomas(m){}
	method esEncontrado(personaje) {
		personaje.tieneEspada(true)
		self.desaparecer()
	}
	
	method desaparecer(){ game.removeVisual(self)}
}

object imagen {
	method agregar(personaje, estado) = personaje + estado + ".png"
}

//Visuales de pantalla
object menu {
	var property image = "menuInicial.jpg"
	var property position = game.origin()
}
object explicacion{
	var property image = "explicacionInicial.jpg"
	var property position = game.origin()
}
object fondo{
	var property image = "fondo_bosque.png"
	var property position = game.origin()
}