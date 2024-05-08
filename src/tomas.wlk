import wollok.game.*
import monstruos.*
import pocion.*
import extra.*

object tomas {	
	var property mochila = []
	var property capacidad = 3
	
	var property vivo = true
	var property vida = 100
	
	var property tieneEspada = false
	var property poderBase = 5
	
//Configurar posicion e imagen
	var property position = game.at(0, 4)
	
	method image() = "tomas_basico.png"
	method estaEnTablero(posicion) = posicion.x().between(0, 19) and posicion.y().between(0, 9)
	//Verificar que el movimiento sea legal, que no haya obstaculos y que no ocupe el mismo lugar que el monstruo
	method procesarMovimiento(){}
	
	method moverseA(nuevaPosicion) {
		if (self.estaEnTablero(nuevaPosicion) and vivo){
			position = nuevaPosicion		
		}
	}
	
//Vida del personaje
	method esAtacado(danio) {
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

//Agarrar objetos
	method agarrar(objeto){
		if (objeto == espada){
			tieneEspada = true
		} else if (mochila.size() < capacidad){
			mochila.add(objeto)
		} else {
			game.say(self, "No puedo cargar más")
		}
		objeto.desaparecer()
	}
	
//Usar pociones
	method usarPocion(numero){
		if (mochila.isNotEmpty()){
			mochila.get(numero).activar()
			mochila.remove(mochila.get(numero))
		} else { game.say(self, "No tengo pociones")}
	}
	
//Matar monstruos 
	method atacar() {
		//if(tieneEspada){
			//monstruo.recibirDanio(poderBase)
		//} else {
			//monstruo.recibirDanio(poderBase/2)
		//}
	}	
}