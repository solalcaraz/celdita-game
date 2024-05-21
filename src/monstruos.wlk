import wollok.game.*
import pocion.*

//dañan a tomas con esAtacado(daño)
class Monstruos {
	var vida
	var poderBase
	var pocion

//Posicion e imagen para los monstruos en general
	var property position
	method image() = "pocion_aturdimiento.png"
	method aparecer(){
		position = game.at(0.randomUpTo(game.width()).truncate(0), 0.randomUpTo(game.height()).truncate(0))
		self.movimiento()
	}	
	
	method proximidadTomas(colisionador){
		game.schedule(1000, {self.atacar(colisionador.posTomas())})
		game.schedule(1000, {self.continuarAtaque(colisionador)})
	}
	
	method continuarAtaque(colisionador){
		if(game.uniqueCollider(colisionador).equals(self)){
			game.schedule(1000, {self.atacar(colisionador.posTomas())})
			game.schedule(1000, {self.continuarAtaque(colisionador)})
		}
	}
	
	method desaparecer(){ game.removeVisual(self)}
	
//Vida del monstruo
	method recibirDanio(danio){
		vida -= danio
		if(vida <= 0){ self.morir()}
	}
	
	method morir() {	
		self.desaparecer()
		self.soltarPocion()
	}
	
	method soltarPocion(){
		game.addVisual(pocion)
	}

//Acciones independientes para cada tipo
	method atacar(posicion){
		if(not game.getObjectsIn(posicion).isEmpty()){
			game.getObjectsIn(posicion).first().esAtacado(poderBase)
		}
	}
	
	method movimiento(){}
}

class Sombrio inherits Monstruos(vida = 100, poderBase = 10, pocion = "invisibilidad") {
	override method morir(){
		if (0.randomUpTo(3) == 0){
			self.soltarPocion()
		} else {
			self.desaparecer()
		}
	}
	method moverse(){
		//se mueve tipo caballo de ajedrez o algo asi, estilo "se teletransporta"
	}
}

class Golem inherits Monstruos(vida = 80, poderBase = 8, pocion = "aturdimiento") {
	override method morir(){
		if (0.randomUpTo(2) == 0){
			self.soltarPocion()
		} else { 
			self.desaparecer()
		}
	}
	method moverse(){
		//se puede mover en y igual que el personaje pero en x va avanzando
	}
}

class Esqueleto inherits Monstruos(vida = 50, poderBase = 5, pocion = "fuerza") {
	override method morir(){
		if (0.randomUpTo(3) != 0){
			self.soltarPocion()
		} else {
			self.desaparecer()
		}
	}
	method moverse(){
		//pensar
	}
}