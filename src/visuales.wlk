import wollok.game.*
import tomas.*
import celdita.*
import sonidos.*

//Metodo para colocar una imagen
object imagen {
	method agregar(personaje, estado) = personaje + estado + ".png"
}

//Visuales de la pantalla
class Visuales{
	var nombre
	const property esCaminable = true
	const property esMalo = false

	var property position = game.origin()
	var property estado = "Inicial"
	var property image = imagen.agregar(nombre, estado)
	
	//Colisiones con el personaje
	method esEncontrado(){}
	method proximidadTomas(personaje){}
	method recibirDanio(danio){}
}
object menu inherits Visuales (nombre = "menu"){}
object explicacion inherits Visuales (nombre = "explicacion"){}
object fondo inherits Visuales (nombre = "bosque"){}

object ganaste inherits Visuales(nombre = "ganaste"){}	
object perdiste inherits Visuales(nombre = "perdiste", position = game.origin()){}

// Visual de la vida, que al tener mas
object vidaCorazon inherits Visuales (nombre = "corazones_", estado = "3", position = game.at(17, 0)){	
	method recargarImagen(valor){
		estado = valor
		image = imagen.agregar(nombre, estado)
	}
	method actualizar(vidaTomas){
		if (vidaTomas  <= 0){ game.removeVisual(self)
		} else if (vidaTomas <= 30){ self.recargarImagen("1")
		} else if (vidaTomas <= 60){ self.recargarImagen("2")
		} else { self.recargarImagen("3")}
	}
}