import wollok.game.*
import monstruos.*
import extra.*
import visuales.*
import sonidos.*

class Pociones{
	var property position

	const nombre = "pocion_"
	var tipoPocion

	var property esCaminable = true

//Aparicion de la pocion
	method image() = imagen.agregar(nombre, tipoPocion)
	
	method aparecer() {
		self.image()
		game.schedule(3000, { =>self.desaparecer()})
	}
	
	method desaparecer(){ game.removeVisual(self)}
	
//Colision con el personaje
	method esEncontrado(personaje){
		if(personaje.tieneCapacidad()){
			personaje.mochila().add(game.uniqueCollider(personaje))
			//pociones.actualizar()
		} else { game.say(self, "No puedo cargar más")}
		self.desaparecer()
	}
	
	method proximidadTomas(colisionador) {
		game.say(self, "Soy una pocion!")
	}
	
	method recibirDanio(){}
	
// Propio de cada tipo
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
	 	personaje.poderBase(20)
		game.schedule(5000, { personaje.poderBase(10)})
	 }
}