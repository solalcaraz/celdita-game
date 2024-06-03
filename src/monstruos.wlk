import wollok.game.*
import tomas.*
import pocion.*
import extra.*
import visuales.*
import sonidos.*

class Monstruos {
	var nombre
	var vida
	var vivo = false
	var sonidoDe
	var property estado = "Basico"
	
	var pocion
	var poderBase
	var property esCaminable = false
	var property esMalo = true
	var property movil = true

//Configuracion de imagen, sonido y posicion
	var property position = game.origin()
	method image() = imagen.agregar(nombre, estado)
	method sonido() { sonidos.nuevoSonido(sonidoDe)}
	
	method aparecer(){
		position = game.at(0.randomUpTo(game.width()).truncate(0), 0.randomUpTo(game.height()).truncate(0))
		game.addVisual(self)
		vivo = true
		self.movimiento()
	}	
	
	method desaparecer(){ self.detenerse() game.removeVisual(self)}
	
//Validaciones
	method movimiento() { game.onTick(2500, "movimiento", { => self.moverse()})}
	method detenerse() { game.removeTickEvent("movimiento")}
	
	 method estaEnElTablero() = position.x().between(0, 19) and position.y().between(0, 10)
	
	method validacion(colisionador) = not game.colliders(colisionador).isEmpty() and game.uniqueCollider(colisionador).equals(self)

//Acercamiento con tomas y ataque
	method logicaAtaque(colisionador) {
		game.schedule(1000, {self.atacar(colisionador.posTomas())})
		game.schedule(1000, {self.continuarAtaque(colisionador)})		
	}
	
	method esEncontrado(){}
	
	method proximidadTomas(colisionador){
		self.detenerse()
		self.logicaAtaque(colisionador)
	}
	
	method continuarAtaque(colisionador){
		if(self.validacion(colisionador) and vivo){
			self.logicaAtaque(colisionador)
		} else { self.movimiento()}
	}
	
	method atacar(posicion){
		if(not game.getObjectsIn(posicion).isEmpty() and vivo){
			game.getObjectsIn(posicion).first().esAtacado(poderBase)
		}
	}
	
//Vida del monstruo y muerte
	method recibirDanio(danio){
		vida -= danio
		estado = "Herido"
		game.schedule(50,{estado = "Basico" self.sonido()})
		if(vida <= 0){ self.morir()}// else { self.error("Sigue vivo")}
	}
	
	method morir() {
		vivo = false
		sonidos.nuevoSonido("muerteMonst.mp3")
		self.desaparecer()	
		if(self.aleatorio()){ self.soltarPocion()}
		tomas.actualizarPuntaje()
	}
	
//Independientes para cada tipo
	method aleatorio() = (0.randomUpTo(2).truncate(0) != 1)
	method soltarPocion() { pocion.aparecer(position)}
	method moverse()
}

class Sombrio inherits Monstruos(vida = 100, poderBase = 10, pocion = new PocionAturdimiento(), nombre = "sombrio", sonidoDe = "sombrioHerido.mp3") {
	override method moverse(){
		if (0.randomUpTo(2).truncate(0) == 1  and self.estaEnElTablero()){
			position = self.position().left(2)
			position = self.position().up(1)
		} else {
			position = self.position().left(2)
			position = self.position().down(1)
		}
	}
}

class Slime inherits Monstruos(vida = 80, poderBase = 8, pocion = new PocionInvencible(), nombre = "slime", sonidoDe = "slimeHerido.mp3") {
	override method moverse(){
		if(self.position().y() > tomas.position().y()  and self.estaEnElTablero()){
			position = self.position().down(1)
		} else {
			position = self.position().up(1)
		}
	}
}

class Esqueleto inherits Monstruos(vida = 50, poderBase = 5, pocion = new PocionFuerza(), nombre = "esqueleto", sonidoDe = "esqueletoHerido.mp3") {
	override method moverse(){
		if(self.position().x() > tomas.position().x() and self.estaEnElTablero()){
			position = self.position().down(1)
		} else {
			position = self.position().up(1)
		}
	}
}