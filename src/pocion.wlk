import wollok.game.*
import monstruos.*
import extra.*
import visuales.*
import sonidos.*

class Pociones{
	const nombre = "pocion_"
	var tipoPocion

	var property esCaminable = true
	var property esMalo = false

//Aparicion de la pocion
	method image() = imagen.agregar(nombre, tipoPocion)
	
	method aparecer(posMonstruo) {
		game.addVisualIn(self, posMonstruo)
		game.schedule(3000, { =>self.desaparecer()})
	}
	
	method desaparecer(){ game.removeVisual(self)}
	
//Colision con el personaje
	method esEncontrado(personaje){
		if(personaje.tieneCapacidad()){
			personaje.mochila().add(game.uniqueCollider(personaje))
			game.say(personaje, "En la mochila")
		} else { game.say(self, "No puedo cargar más")}
		self.desaparecer()
	}
	
	method proximidadTomas(colisionador) {
		game.say(self, "Soy una pocion!")
	}
	
	method recibirDanio(){}
	
// Propio de cada tipo
	method activar(personaje)
	
	method malosEnMapa() = game.allVisuals().filter({malo => malo.esMalo()})
}

class PocionInvencible inherits Pociones (tipoPocion = "invencibilidad") {
	 override method activar(personaje){
	 	game.say(personaje, "Invencible!")
		personaje.vida(100)
		personaje.estado("Invencible")
		personaje.esInvencible(true)
		game.schedule(5000, {personaje.estado("Basico") 
							personaje.esInvencible(false)})
	 }
}

class PocionFuerza inherits Pociones (tipoPocion = "fuerza") {
	 override method activar(personaje){
	 	game.say(personaje, 'Fuerte!')
	 	personaje.poderBase(personaje.poderBase()*2)
		game.schedule(5000, { personaje.poderBase(personaje.poderBase()/2)})
	 }
}

class PocionAturdimiento inherits Pociones (tipoPocion = "aturdimiento") {
	override method activar(personaje){
	 	game.say(personaje, 'Aturdir!!')
		self.malosEnMapa().forEach({ malo => malo.detenerse() })
		game.schedule(5000, { self.malosEnMapa().forEach({ malo => malo.movimiento() })})
	 }
}