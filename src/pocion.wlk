import wollok.game.*
import monstruos.*

class Pociones{
	var property position
	var property tipoPocion

	method image() = "tomas_" + tipoPocion + ".png"
//Aparicion de la pocion
	method esEncontrado(personaje){
		if(personaje.tieneCapacidad()){
			personaje.mochila().add(game.uniqueCollider(personaje))
		} else { game.say(self, "No puedo cargar más")}
		self.desaparecer()
	}
	method aparecer(posicionMonstruo) {
		position = posicionMonstruo
		self.image()
		game.schedule(3000, { =>self.desaparecer()})
	}
	method desaparecer(){ game.removeVisual(self)}	
	
	method activar(personaje){}
}

class PocionInvencible inherits Pociones (tipoPocion = "invencible") {
//Poder que activa la pocion en el personaje
	 override method activar(personaje){
		personaje.vida(100)
		personaje.estado("invisible")
		personaje.esInvencible(true)
		game.schedule(5000, {personaje.estado("basico") 
							personaje.esInvencible(false)})
	 }
}

class PocionFuerza inherits Pociones (tipoPocion = "fuerza") {
//Poder que activa la pocion en el personaje
	 override method activar(personaje){
	 	personaje.poderBase(20)
		game.schedule(5000, { personaje.poderBase(10)})
	 }
}

class PocionAturdimiento inherits Pociones (tipoPocion = "aturdimiento") {
//Poder que activa la pocion en el personaje
	 override method activar(personaje){
		//a pensar mas adelante
	}
}