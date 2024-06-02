import wollok.game.*
import tomas.*
import visuales.*
import sonidos.*

//Objetos invisibles para validad el movimiento/ataque del personaje
class ObjetoInvisible {
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
	
	const property position = game.center()

	method image() = imagen.agregar(nombre, estado)
	
//Aparece una estatua que se convierte en espada
	method aparecer(){
		game.schedule(1000,{ game.say(self, "Tomas, valiente caballero")})
		game.schedule(3000,{ game.say(self, "Necesitaras aumentar tu poder")})
		game.schedule(5000,{ game.say(self, "Usame como espada...")})
		game.schedule(7000,{ self.remover()})
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