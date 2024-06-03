import wollok.game.*
import tomas.*
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
	
	method desaparecer(){ if (game.hasVisual(self)) {game.removeVisual(self)} }
	
//Colision con el personaje
	method esEncontrado(){
		if(tomas.tieneCapacidad()){
			tomas.mochila().add(game.uniqueCollider(tomas))
			game.say(tomas, "En la mochila")
			self.desaparecer()
		} else { game.say(self, "No puedo cargar más") }
	}
	
	method proximidadTomas(colisionador){}	
	method recibirDanio(danio){}
	
// Propio de cada tipo
	method activar(personaje)
	
	method malosEnMapa() = game.allVisuals().filter({malo => malo.esMalo()})
	method malosMoviles() = self.malosEnMapa().filter({malo => malo.movil()})
}

class PocionInvencible inherits Pociones (tipoPocion = "invencibilidad") {
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
		self.malosEnMapa().forEach({ malo => malo.detenerse() malo.movil(false)})
	 }
}