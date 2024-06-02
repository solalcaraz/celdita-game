import wollok.game.*
import tomas.*
import pocion.*
import extra.*
import visuales.*
import sonidos.*

class Monstruos {
	var nombre
	var vida
	var sonidoDe
	var property estado = "Basico"
	
	var poderBase
	var property esCaminable = false

//Configuracion de imagen, sonido y posicion
	var property position = game.origin()
	method image() = imagen.agregar(nombre, estado)
	method sonido() { sonidos.nuevoSonido(sonidoDe)}
	
	method aparecer(){
		position = game.at(0.randomUpTo(game.width()).truncate(0), 0.randomUpTo(game.height()).truncate(0))
		game.addVisual(self)
		return self.movimiento()
	}	
	
	method desaparecer(){ game.removeVisual(self)}
	
//Validaciones
	method movimiento() = game.onTick(3000, "movimiento", { => self.moverse()})
	method detenerse() = game.removeTickEvent("movimiento")
	method validacion(colisionador) = not game.colliders(colisionador).isEmpty() //and game.uniqueCollider(colisionador).equals(self)

//Acercamiento con tomas y ataque
	method logicaAtaque(colisionador) {
		game.schedule(1000, {self.atacar(colisionador.posTomas())})
		game.schedule(1000, {self.continuarAtaque(colisionador)})		
	}
	
	method esEncontrado(personaje){}
	
	method proximidadTomas(colisionador){
		self.detenerse()
		self.logicaAtaque(colisionador)
	}
	
	method continuarAtaque(colisionador){
		if(self.validacion(colisionador)){
			self.logicaAtaque(colisionador)
		} else { self.movimiento()}
	}
	
	method atacar(posicion){
		if(not game.getObjectsIn(posicion).isEmpty()){
			game.getObjectsIn(posicion).first().esAtacado(poderBase)
		}
	}
	
//Vida del monstruo y muerte
	method recibirDanio(danio){
		estado = "Herido"
		game.schedule(50,{estado = "Basico" self.sonido()})
		vida -= danio
		if(vida <= 0){ self.morir()} else { self.error("Sigue vivo")}
	}
	
	method morir() {
		self.detenerse()
		sonidos.nuevoSonido("muerteMonst.mp3")
		self.desaparecer()	
		if(self.aleatorio()){ self.soltarPocion()}
	}
	
//Independientes para cada tipo
	method aleatorio()
	method soltarPocion()
	method moverse()
}

class Sombrio inherits Monstruos(vida = 100, poderBase = 10, nombre = "sombrio", sonidoDe = "sombrioHerido.mp3") {
	override method aleatorio() = (0.randomUpTo(3).truncate(0) == 1)

	override method soltarPocion() = new PocionInvencible(position = position).aparecer()
		
	override method moverse(){
		if (0.randomUpTo(2).truncate(0) == 1){
			position = self.position().left(2)
			position = self.position().up(1)
		} else {
			position = self.position().left(2)
			position = self.position().down(1)
		}
	}
}

class Slime inherits Monstruos(vida = 80, poderBase = 8, nombre = "slime", sonidoDe = "slimeHerido.mp3") {
	override method aleatorio() = (0.randomUpTo(2).truncate(0) == 1)
	
	override method soltarPocion() = new PocionAturdimiento(position = position).aparecer()
	
	override method moverse(){
		if(self.position().y() > tomas.position().y()){
			position = self.position().down(1)
		} else {
			position = self.position().up(1)
		}
	}
}

class Esqueleto inherits Monstruos(vida = 50, poderBase = 5, nombre = "esqueleto", sonidoDe = "esqueletoHerido.mp3") {
	override method aleatorio() = (0.randomUpTo(3).truncate(0) != 1)
	
	override method soltarPocion() = new PocionFuerza(position = position).aparecer()
	
	override method moverse(){
		if(self.position().x() > tomas.position().x()){
			position = self.position().down(1)
		} else {
			position = self.position().up(1)
		}
	}
}