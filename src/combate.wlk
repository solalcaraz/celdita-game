import wollok.game.*
import monstruos.*
import extra.*
import sonidos.*

class Combate {
	
	method iniciar(){
		// Al reintentar, la música de batalla ya se reprodujo una vez y Wollok no deja
		// reproducirla de nuevo: por eso se retoma.
		if(batalla.played()){
			batalla.resume()
		}	
		else{ 
			batalla.play()
		}
		batalla.volume(0.05)
		game.onTick(1000, "generarEnemigos", { => enemigos.generar()})	
	}
}

object enemigos{
	method generar(){
		if(azar.entero(0, 3) == 1){ new Slime().aparecer()
		} else if(azar.entero(0, 3) == 0){ new Sombrio().aparecer()
		} else if(azar.entero(0, 3) == 2){ new Esqueleto().aparecer() }
	}
}