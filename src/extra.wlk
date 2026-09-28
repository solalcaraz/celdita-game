import wollok.game.*
import tomas.*
import visuales.*
import sonidos.*

// Wollok solo avisa colisiones entre objetos que están en la misma celda. Estas cuatro celdas
// invisibles acompañan a Tomás para saber qué tiene al lado: si puede moverse, a quién le pega
// y qué monstruo se le acercó.
class ObjetoInvisible {
	const property esMalo = false
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
	var nombre = "estatua"
	const estado = "Aparicion"

	const poderBase = 10
	var property esCaminable = false
	const property esMalo = false

	var property position = game.at(azar.entero(5, 18), azar.entero(5, 9))

	method image() = imagen.archivo(nombre, estado)

	method aparecer(){
		game.schedule(1000,{ game.say(self, "Tomas, valiente caballero")})
		game.schedule(3000,{ game.say(self, "Derrota 20 monstruos")})
		game.schedule(5000,{ game.say(self, "Necesitaras aumentar tu poder")})
		game.schedule(7000,{ game.say(self, "Usame como espada...")})
		game.schedule(9000,{ self.convertirEnEspada()})
	}

	method convertirEnEspada(){
		game.removeVisual(self)
		nombre = "espada"
		esCaminable = true
		if(not tomas.tieneEspada()) { game.addVisual(self)}
		// La música de inicio ya se pausó al salir de la explicación, y pausarla dos veces da error.
		if(not inicio.paused()) inicio.pause()
		sonidos.reproducir("aparicion.mp3")
	}

	method esEncontrado() {
		tomas.tieneEspada(true)
		tomas.poderBase(tomas.poderBase() + poderBase)
		self.desaparecer()
		sonidos.reproducir("agarrar.mp3")
	}

	method reiniciar() {
		esCaminable = false
		nombre = "estatua"
	}

	method desaparecer(){ game.removeVisual(self)}
	method proximidadTomas(personaje){}
	method recibirDanio(danio){}
}

object puntajeTotal{
	const property esMalo = false
	const property esCaminable = true

	method position() = game.at(17, 10)

	method text() = "Puntaje Total: "+ tomas.puntaje()
	method textColor() = "000001"

	method esEncontrado(){}
	method proximidadTomas(personaje){}
	method recibirDanio(danio){}
}

object azar {
	method entero(desde, hasta) = desde.randomUpTo(hasta).truncate(0)
}

object tablero {
	method contiene(posicion) = posicion.x().between(0, game.width() - 1) and posicion.y().between(0, game.height() - 1)
}
