import wollok.game.*
import celdita.*
import extra.*
import visuales.*
import sonidos.*

object tomas {	
	var property mochila = []
	var property capacidad = 3
	
	var property vivo = true
	var property vida = 100
		
	var property poderBase = 10
	var property tieneEspada = false
	var property esInvencible = false
	
	var property estado = "Basico" 
	var property nombre = "tomas"
	var property position = game.at(0, 4)
	
//Configurar imagen y sonido
	method image() = imagen.agregar(nombre, estado)
	method sonido(nuevo) { sonidos.nuevoSonido(nuevo)}
	
//Validaciones de movimiento
	method estaEnTablero(posicion) = posicion.x().between(0, 19) and posicion.y().between(0, 10)
	method visualMochila(posicion) = posicion.between([17,10], [19, 10])
	method validacion(colisionador) = game.colliders(colisionador).isEmpty() 
									and self.estaEnTablero(colisionador.position()) 
									//and self.visualMochila(colisionador.position())

	method procesarMovimiento(colisionador) {
		if(self.validacion(colisionador)){
			return true
		} else { return game.uniqueCollider(colisionador).esCaminable()	}
	} 
	
	method moverseA(colisionador) {
		if(self.procesarMovimiento(colisionador) and vivo){
			sonidos.nuevoSonido("pasos.mp3")
			position = colisionador.position()
		} else { game.say(self, "Por aca no puedo ir")}
	}
	
//Vida del personaje
	method esAtacado(danio) {
		estado = "Herido"
		game.schedule(80,{estado = "Basico" 
						self.sonido("herido.mp3") })
		vida -= danio 
		game.say(self, "vida"+ vida.toString())
		vidaCorazon.actualizar(vida)
		if(vida <= 0) { self.morir()} 
	}
	
	method morir() {
		vivo = false
		self.sonido("muere.mp3")
		game.say(self, "Has muerto!")
		celdita.reiniciar()
	}
		
//Matar monstruos 
	method atacar(colisionador) {
		if(not game.colliders(colisionador).isEmpty()){		
			if(tieneEspada){ self.sonido("golpeEspada.mp3")} else { self.sonido("golpeMano.mp3")}
			game.uniqueCollider(colisionador).recibirDanio(poderBase)
		} else { game.say(self, "No hay nada que atacar!")}	
	}

//Uso de pociones
	method tieneCapacidad() = mochila.size() < capacidad

	method usarPocion(numero){
		if (not mochila.isEmpty()){
			mochila.get(numero).activar()
			self.sonido("beber.mp3")
			mochila.remove(mochila.get(numero))
		} else { game.say(self, "No tengo pocion")}
	}	
}