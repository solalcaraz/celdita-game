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
	var property esMalo = false
	var property puntaje = 0
	
	var property estado = "Basico" 
	var property nombre = "tomas"
	
//Configurar posicion, imagen y sonido
	var property position = game.at(0, 4)
	method image() = imagen.agregar(nombre, estado)
	method sonido(nuevo) { sonidos.nuevoSonido(nuevo)}
	
//Validaciones de movimiento
	method estaEnTablero(posicion) = posicion.x().between(0, 19) and posicion.y().between(0, 10)
	method enMapa(colisionador) = self.estaEnTablero(colisionador.position())
	
	method validacion(colisionador) = game.colliders(colisionador).isEmpty() 
									or game.uniqueCollider(colisionador).esCaminable()  

	method procesarMovimiento(colisionador){
		if(self.validacion(colisionador)){
			sonidos.nuevoSonido("pasos.mp3")
			position = colisionador.position()	
		}			
	}
	
	method moverseA(colisionador) {
		if(self.enMapa(colisionador) and vivo){
			self.procesarMovimiento(colisionador)
		} else { game.say(self, "Por aca no puedo ir")}
	}
	
//Vida del personaje
	method esAtacado(danio) {
		if (not esInvencible){
			vida -= danio
			vidaCorazon.actualizar(vida)
			if(vida <= 0) { self.morir()} else {
				estado = "Herido"
				game.schedule(80,{estado = "Basico" 
								self.sonido("herido.mp3") })				
			}
		}
	}
	
	method morir() {
		vivo = false
		batalla.pause()
		self.sonido("muere.mp3")
		celdita.gameOver() 
	}
		
//Matar monstruos 
	method atacar(colisionador) {
		if(not game.colliders(colisionador).isEmpty()){
			if(tieneEspada){ self.sonido("golpeEspada.mp3")} else { self.sonido("golpeMano.mp3")}
			game.uniqueCollider(colisionador).recibirDanio(poderBase)
		}
	}
	
//Puntaje
	method actualizarPuntaje() { 
		puntaje = puntaje + 1
		self.checkGanar()
	}
	
	method checkGanar(){
		if(puntaje == 20){
			game.clear()
			batalla.pause()
			game.addVisual(ganaste)
			celdita.winner()
		}
	} 

//Uso de pociones
	method tieneCapacidad() = mochila.size() < capacidad

	method usarPocion(){
		if (mochila.isEmpty()){
			game.say(self, "No tengo pocion")
		} else {
			mochila.first().activar(self)
			self.sonido("beber.mp3")
			mochila.remove(mochila.first())
		}		
	}	
}