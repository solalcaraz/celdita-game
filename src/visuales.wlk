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

	var property position
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

object ganaste inherits Visuales(nombre = "ganaste", position = game.origin()){
	method salir(){ 
		ganar.play() 
		keyboard.enter().onPressDo{ ganar.pause() game.stop()}
	}
}	
object perdiste inherits Visuales(nombre = "perdiste", position = game.origin()){
	method resetearValores(){
		perder.play()
		tomas.mochila([])
		tomas.vivo(true)
		tomas.vida(100)
		tomas.poderBase(10)
	 	tomas.tieneEspada(false)
		tomas.esInvencible(false)
		tomas.puntaje(0)		
		keyboard.enter().onPressDo{ game.clear() perder.pause() celdita.configuracionInicial()}
	}
}

// Visual de la vida, que al tener mas
object vidaCorazon inherits Visuales (nombre = "corazones_", estado = "3", position = game.at(17, 0)){	
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