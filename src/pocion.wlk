import wollok.game.*
import tomas.*
import visuales.*

class Pocion {
	const nombre = "pocion_"
	const tipoPocion

	const property esCaminable = true
	const property esMalo = false

	method image() = imagen.archivo(nombre, tipoPocion)

	method aparecer(posMonstruo) {
		game.addVisualIn(self, posMonstruo)
		game.schedule(3000, { =>self.desaparecer()})
	}

	method desaparecer(){ if (game.hasVisual(self)) {game.removeVisual(self)} }

	method esEncontrado(){
		if(tomas.tieneCapacidad()){
			tomas.mochila().add(game.uniqueCollider(tomas))
			game.say(tomas, "En la mochila")
			self.desaparecer()
		} else { game.say(self, "No puedo cargar más") }
	}

	method proximidadTomas(colisionador){}
	method recibirDanio(danio){}

	method activar(personaje)

	method malosEnMapa() = game.allVisuals().filter({malo => malo.esMalo()})
}

class PocionInvencible inherits Pocion (tipoPocion = "invencibilidad") {
	 override method activar(personaje){
	 	game.say(personaje, "Invencible!")
		personaje.vida(100)
		vidaCorazon.actualizar(100)
		personaje.estado("Invencible")
		personaje.esInvencible(true)
		game.schedule(5000, {personaje.estado("Basico")
							personaje.esInvencible(false)})
	 }
}

class PocionFuerza inherits Pocion (tipoPocion = "fuerza") {
	 override method activar(personaje){
	 	game.say(personaje, 'Fuerte!')
	 	personaje.poderBase(personaje.poderBase()*2)
		game.schedule(5000, { personaje.poderBase(personaje.poderBase()/2)})
	 }
}

class PocionAturdimiento inherits Pocion (tipoPocion = "aturdimiento") {
	override method activar(personaje){
	 	game.say(personaje, 'Aturdir!!')
		self.malosEnMapa().forEach({ malo => malo.detenerse()})
	 }
}
