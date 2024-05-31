import wollok.game.*
import pocion.*
import extra.*
import tomas.*

class Monstruos {
	var property estado = "Basico"
	var nombre
	var vida
	
	var pocion
	var poderBase
	var property esCaminable = false

//Posicion e imagen para los monstruos en general
	var property position = game.origin()
	method image() = imagen.agregar(nombre, estado)
	
	method aparecer(){
		position = game.at(0.randomUpTo(game.width()).truncate(0), 0.randomUpTo(game.height()).truncate(0))
		game.addVisual(self)
		return self.movimiento()
	}	
	
	method desaparecer(){ game.removeVisual(self)}
	
//Validaciones
	method movimiento() = game.onTick(2000, "movimientoMonstruo", { => self.moverse()})
	method detenerse() = game.removeTickEvent("movimientoMonstruo")
	method validacion(colisionador) = not game.colliders(colisionador).isEmpty() and game.uniqueCollider(colisionador).equals(self)

//Acercamiento con tomas, ataca si esta cerca
	method logicaAtaque(colisionador) {
		game.schedule(1000, {self.atacar(colisionador.posTomas())})
		game.schedule(1000, {self.continuarAtaque(colisionador)})		
	}
	
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
	
//Vida del monstruo
	method recibirDanio(danio){
		estado = "Herido"
		game.schedule(50,{estado = "Basico"})
		vida -= danio
		if(vida <= 0){ self.morir()} else { self.error("Sigue vivo")}
	}
	
	method morir() {
		if(self.aleatorio()){
			self.soltarPocion()			
		} else { 
			self.detenerse()
			self.desaparecer()
		}	
	}
	
	method aleatorio()
	method soltarPocion(){ game.addVisualIn(pocion, position)}

//Independientes para cada tipo
	method moverse()
}

class Sombrio inherits Monstruos(vida = 100, poderBase = 10, pocion = "invisibilidad", nombre = "sombrio") {
	override method aleatorio() = (0.randomUpTo(3).truncate(0) == 1)
		
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

class Slime inherits Monstruos(vida = 80, poderBase = 8, pocion = "aturdimiento", nombre = "slime") {

	override method aleatorio() = (0.randomUpTo(2).truncate(0) == 1)
	
	override method moverse(){
		if(self.position().y() > tomas.position().y()){
			position = self.position().down(1)
		} else {
			position = self.position().up(1)
		}
	}
}

class Esqueleto inherits Monstruos(vida = 50, poderBase = 5, pocion = "fuerza", nombre = "esqueleto") {
	
	override method aleatorio() = (0.randomUpTo(3).truncate(0) != 1)
	
	override method moverse(){
		//pensar
	}
}