import wollok.game.*

object imagen {
	method archivo(nombre, estado) = nombre + estado + ".png"
}

class Visual {
	const nombre
	const property esCaminable = true
	const property esMalo = false

	var property position = game.origin()
	var property estado = "Inicial"
	var property image = imagen.archivo(nombre, estado)

	method esEncontrado(){}
	method proximidadTomas(personaje){}
	method recibirDanio(danio){}
}
object menu inherits Visual (nombre = "menu"){}
object explicacion inherits Visual (nombre = "explicacion"){}
object fondo inherits Visual (nombre = "bosque"){}

object ganaste inherits Visual(nombre = "ganaste"){}
object perdiste inherits Visual(nombre = "perdiste"){}

object vidaCorazon inherits Visual (nombre = "corazones_", estado = "3", position = game.at(17, 0)){
	method recargarImagen(valor){
		estado = valor
		image = imagen.archivo(nombre, estado)
	}
	method actualizar(vidaTomas){
		if (vidaTomas  <= 0){ game.removeVisual(self)
		} else if (vidaTomas <= 30){ self.recargarImagen("1")
		} else if (vidaTomas <= 60){ self.recargarImagen("2")
		} else { self.recargarImagen("3")}
	}
}
