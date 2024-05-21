import wollok.game.*
//import monstruos.*
//import pocion.*
import extra.*

object tomas {	
	var property mochila = []
	var property capacidad = 3
	
	var property vivo = true
	var property vida = 100
	var property estado = "basico"
	
	var property tieneEspada = false
	var property poderBase = 10
	
	var property esInvencible = false
	
//Configurar posicion e imagen
	var property position = game.at(0, 4)
	
	method image() = "tomas_" + estado + ".png"
	method estaEnTablero(posicion) = posicion.x().between(0, 19) and posicion.y().between(0, 9)
	//Verificar que el movimiento sea legal, que no haya obstaculos y que no ocupe el mismo lugar que el monstruo
	method procesarMovimiento(){
		
		
	}
	
	method moverseA(nuevaPosicion) {
		if (self.estaEnTablero(nuevaPosicion) and vivo){
			position = nuevaPosicion		
		}
	}
	
//Vida del personaje
	method esAtacado(danio) {
		estado = "herido"
		game.schedule(80,{estado = "basico"}
		)
		vida -= danio 
		if(vida <= 0) { self.morir()}
	}
	method morir() {
		vivo = false
		game.say(self, "Has muerto!")
		game.removeVisual(self)
		//Podriamos volver al menu en vez de frenar el juego
		game.schedule(5000, { game.stop()})
	}

//Uso de pociones
	method tieneCapacidad() = mochila.size() < capacidad
	
		
//Matar monstruos 
	method atacar(posicion) {
		if(not game.getObjectsIn(posicion).size().equals(1)){		
			if(tieneEspada){
				posicion.recibirDanio(poderBase)
			} else {
				posicion.recibirDanio(poderBase/2)
			}		
		}else {
			game.say(self, "No hay nada que atacar!")
		}
		
	}	
}

class ObjetoInvisible {
	method position()
	method posTomas() = game.at(tomas.position().x(), tomas.position().y())
}
object tomasIzquierda inherits ObjetoInvisible {
	override method position() = game.at(tomas.position().x()-1, tomas.position().y())
}
object tomasDerecha inherits ObjetoInvisible{
	override method position() = game.at(tomas.position().x()+1, tomas.position().y())
}
object tomasArriba inherits ObjetoInvisible{
	override method position() = game.at(tomas.position().x(), tomas.position().y()+1)
}
object tomasAbajo inherits ObjetoInvisible{
	override method position() = game.at(tomas.position().x(), tomas.position().y()-1)
}