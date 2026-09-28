import wollok.game.*
import celdita.*
import extra.*
import visuales.*
import sonidos.*

object tomas {
	var property mochila = []
	const capacidad = 3

	var vivo = true
	var property vida = 100

	var property poderBase = 10
	var property tieneEspada = false
	var property esInvencible = false
	const property esMalo = false
	var property puntaje = 0

	var property estado = "Basico"
	const nombre = "tomas"

	var property position = game.at(0, 4)
	method image() = imagen.archivo(nombre, estado)

	method puedePisar(colisionador) = game.colliders(colisionador).isEmpty()
									or game.uniqueCollider(colisionador).esCaminable()

	method procesarMovimiento(colisionador){
		if(self.puedePisar(colisionador)){
			sonidos.reproducir("pasos.mp3")
			position = colisionador.position()
		}
	}

	method moverseA(colisionador) {
		if(tablero.contiene(colisionador.position()) and vivo){
			self.procesarMovimiento(colisionador)
		} else { game.say(self, "Por aca no puedo ir")}
	}

	method esAtacado(danio) {
		if (not esInvencible){
			vida -= danio
			vidaCorazon.actualizar(vida)
			if(vida <= 0) { self.morir()} else {
				estado = "Herido"
				game.schedule(80,{estado = "Basico"
								sonidos.reproducir("herido.mp3") })
			}
		}
	}

	method morir() {
		vivo = false
		sonidos.reproducir("muere.mp3")
		celdita.gameOver()
	}

	method atacar(colisionador) {
		if(not game.colliders(colisionador).isEmpty()){
			if(tieneEspada){ sonidos.reproducir("golpeEspada.mp3")} else { sonidos.reproducir("golpeMano.mp3")}
			game.colliders(colisionador).first().recibirDanio(poderBase)
		}
	}

	method actualizarPuntaje() {
		puntaje = puntaje + 1
		self.verificarVictoria()
	}

	method verificarVictoria(){
		if(puntaje == 20){
			game.clear()
			batalla.pause()
			game.addVisual(ganaste)
			celdita.winner()
		}
	}

	method tieneCapacidad() = mochila.size() < capacidad

	method usarPocion(){
		if (mochila.isEmpty()){
			game.say(self, "No tengo pocion")
		} else {
			mochila.first().activar(self)
			sonidos.reproducir("beber.mp3")
			mochila.remove(mochila.first())
		}
	}

	method reiniciar() {
		mochila = []
		vivo = true
		vida = 100
		vidaCorazon.actualizar(100)
		poderBase = 10
		tieneEspada = false
		esInvencible = false
		puntaje = 0
		position = game.origin()
		estado = "Basico"
	}
}
