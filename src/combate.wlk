import wollok.game.*
import monstruos.*
import visuales.*
import sonidos.*

class Combate {
	
	method iniciar(){
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
	method valorRan() = 0.randomUpTo(3).truncate(0)
	
	method generar(){
		if(self.valorRan() == 1){ new Slime().aparecer()
		} else if(self.valorRan() == 0){ new Sombrio().aparecer()
		} else if(self.valorRan() == 2){ new Esqueleto().aparecer() }
	}
}