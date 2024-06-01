import wollok.game.*
import extra.*

object tomas {	
	var property mochila = []
	var property capacidad = 3
	
	var property vivo = true
	var property vida = 100
	var property estado = "Basico" 
	var property nombre = "tomas"
	
	var property poderBase = 10
	var property tieneEspada = false
	var property esInvencible = false
	
//Configurar posicion e imagen
	var property position = game.at(0, 4)
	method image() = imagen.agregar(nombre, estado)
	
	method estaEnTablero(posicion) = posicion.x().between(0, 19) and posicion.y().between(0, 9)
	
	//Verificar el movimiento y moverse
	method procesarMovimiento(colisionador) {
		if(game.colliders(colisionador).isEmpty() and self.estaEnTablero(colisionador.position())){
			return true
		} else { return game.uniqueCollider(colisionador).esCaminable()	}
	} 
	
	method moverseA(colisionador) {
		if(self.procesarMovimiento(colisionador) and vivo){
			position = colisionador.position()
		} else { game.say(self, "Por aca no puedo ir")}
	}
	
//Vida del personaje
	method esAtacado(danio) {
		estado = "Herido"
		game.schedule(80,{estado = "Basico"})
		vida -= danio 
		if(vida <= 0) { self.morir()} else self.error("Sigue vivo")
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

	method usarPocion(numero){
		if (mochila.isNotEmpty()){
			mochila.get(numero).activar()
			mochila.remove(mochila.get(numero))
		} else { game.say(self, "No tengo pocion")}
	}
		
//Matar monstruos 
	method cuantoDanio(colisionador, cuanto) = game.uniqueCollider(colisionador).recibirDanio(poderBase * cuanto) 
	method daniar(colisionador) = if(tieneEspada){ self.cuantoDanio(colisionador, 1)} else { self.cuantoDanio(colisionador, 0.5)}
	
	method atacar(colisionador) {
		if(not game.colliders(colisionador).isEmpty()){		
			self.daniar(colisionador)
		} else { game.say(self, "No hay nada que atacar!")}	
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