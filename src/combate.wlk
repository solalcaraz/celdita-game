import wollok.game.*
import monstruos.*
import visuales.*
import sonidos.*

class Combate {
	
	method iniciar(){
		batalla.play()
		batalla.volume(0.2)
		//game.addVisual(pociones)
		//game.addVisual(combate)
		//game.schedule(80, { game.removeVisual(combate)})
		game.onTick(5000, "generarEnemigos", { => enemigos.generar()})	
	}
}

object enemigos{
	method valorRan() = 0.randomUpTo(3).truncate(0)
	method generar(){
//		new Slime().aparecer()
		if(self.valorRan() == 1){ new Slime().aparecer()
		} else if(self.valorRan() == 0){ new Sombrio().aparecer()
		} else if(self.valorRan() == 2){ new Esqueleto().aparecer() }
	}
}