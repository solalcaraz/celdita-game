import wollok.game.*
import tomas.*
import visuales.*
import sonidos.*

//Objetos invisibles para validad el movimiento/ataque del personaje
class ObjetoInvisible {
	var property esMalo = false
	method position()
	method posTomas() = game.at(tomas.position().x(), tomas.position().y())
}
object tomasIzquierda inherits ObjetoInvisible {
	override method position() = game.at(tomas.position().x()-1, tomas.position().y())
}
object tomasDerecha inherits ObjetoInvisible{
	override method position() = game.at(tomas.position().x()+1, tomas.position().y())
}
object tomasArriba inherits ObjetoInvisible{
	override method position() = game.at(tomas.position().x(), tomas.position().y()+1)
}
object tomasAbajo inherits ObjetoInvisible{
	override method position() = game.at(tomas.position().x(), tomas.position().y()-1)
}


object espada {
	var property nombre = "estatua"
	const estado = "Aparicion"
	
	const property poderBase = 10
	var property esCaminable = false
	var property esMalo = false
	
//Configuracion de la posicion y la imagen
	var property position = game.at(self.valorRan(18), self.valorRan(9))
	
	method valorRan(num) = 5.randomUpTo(num).truncate(0)
	method image() = imagen.agregar(nombre, estado)
	
//Aparece una estatua que se convierte en espada
	method aparecer(){
		game.schedule(1000,{ game.say(self, "Tomas, valiente caballero")})
		game.schedule(3000,{ game.say(self, "Derrota 15 monstruos")})
		game.schedule(5000,{ game.say(self, "Necesitaras aumentar tu poder")})
		game.schedule(7000,{ game.say(self, "Usame como espada...")})
		game.schedule(9000,{ self.remover()})
	}
	
	method remover(){
		game.removeVisual(self)
		nombre = "espada"
		esCaminable = true
		if(not tomas.tieneEspada()){ game.addVisual(self)}
		inicio.pause()
		sonidos.nuevoSonido("aparicion.mp3")
	}
	
//Interaccion espada-personaje
	method esEncontrado(personaje) {
		personaje.tieneEspada(true)
		personaje.poderBase(personaje.poderBase() + poderBase)
		self.desaparecer()
		sonidos.nuevoSonido("agarrar.mp3")
	}
	
	method desaparecer(){ game.removeVisual(self)}
	
	method proximidadTomas(personaje){ game.say(self, "Agarrame")}
	method recibirDanio(danio){}
}

object puntajeTotal{
	var puntaje = 0
	
	method position() = game.at(17, 10)
	
	method text() = "Puntaje Total:"+ puntaje
	method textColor() = "00000001"
	
	method mostrar(puntos) { puntaje = puntos}
}