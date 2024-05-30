import wollok.game.*
import monstruos.*
import extra.*

class Pociones{
	var property position
	var tipoPocion
	const nombre = "pocion_"

//Aparicion de la pocion
	method image() = imagen.agregar(nombre, tipoPocion)
	method aparecer(posicionMonstruo) {
		position = posicionMonstruo
		self.image()
		game.schedule(3000, { =>self.desaparecer()})
	}
	method desaparecer(){ game.removeVisual(self)}
	
//Colision con el personaje
	method esEncontrado(personaje){
		if(personaje.tieneCapacidad()){
			personaje.mochila().add(game.uniqueCollider(personaje))
		} else { game.say(self, "No puedo cargar más")}
		self.desaparecer()
	}
	method proximidadTomas(colisionador) {
		game.say(self, "Soy una pocion!")
	}
	
	method activar(personaje)
}

class PocionInvencible inherits Pociones (tipoPocion = "invencible") {
	 override method activar(personaje){
		personaje.vida(100)
		personaje.estado("invisible")
		personaje.esInvencible(true)
		game.schedule(5000, {personaje.estado("Basico") 
							personaje.esInvencible(false)})
	 }
}

class PocionFuerza inherits Pociones (tipoPocion = "fuerza") {
	 override method activar(personaje){
	 	personaje.poderBase(20)
		game.schedule(5000, { personaje.poderBase(10)})
	 }
}

class PocionAturdimiento inherits Pociones (tipoPocion = "aturdimiento") {
	 override method activar(personaje){
		//a pensar mas adelante
	}
}