import wollok.game.*
import tomas.*

//Metodo para colocar una imagen
object imagen {
	method agregar(personaje, estado) = personaje + estado + ".png"
}

//Visuales de la pantalla
class Visuales{
	var nombre
	var property position
	const property esCaminable = true
	var property estado = "Inicial"
	var property image = imagen.agregar(nombre, estado)
	
	//Colisiones con el personaje
	method esEncontrado(personaje){}
	method proximidadTomas(personaje){}
	method recibirDanio(danio){}
}
object menu inherits Visuales (nombre = "menu", position = game.origin()){}
object explicacion inherits Visuales (nombre = "explicacion", position = game.origin()){}
object fondo inherits Visuales (nombre = "bosque", position = game.origin()){}
object perdiste inherits Visuales(nombre = "gameOver", position = game.center()){}
object combate inherits Visuales(nombre = "combate", position = game.center()){}


// Visual de la vida, que al tener mas
object vidaCorazon inherits Visuales (nombre = "corazones_", estado = "3", position = game.at(17, 0)){	
	var vida = tomas.vida()
	
	method actualizar(vidaTomas){
		if (vidaTomas  == 0){
			game.removeVisual(self)
		} else if (vidaTomas <= 30){
			estado = "1"
		} else if (vidaTomas <= 60){
			estado = "2"
		} else { estado = "3"}
	}
}

object pociones inherits Visuales (nombre = "pocion", position = game.at(17, 10)){
	method posicion(n) = tomas.mochila().get(n)
	
	method actualizar(){
		game.addVisualIn(self.posicion(1), position)
		game.addVisualIn(self.posicion(2), position.x()+1)
		game.addVisualIn(self.posicion(3), position.x()+2)
	}
}