import wollok.game.*
import tomas.*
import pocion.*
import extra.*
import monstruos.*

object celdita {
	method iniciar() {
		game.title("Celdita")
		game.height(10)
		game.width(20)
		game.addVisual(menu)
		keyboard.enter().onPressDo{ self.explicar()}
	}
	
	method explicar() {
		game.clear()
		game.addVisual(explicacion)
		keyboard.enter().onPressDo{ self.configurar()}
	}
	
	method configurar() {
		game.clear()
		game.addVisual(fondo)

		//Visuales
		game.addVisual(espada)
		game.addVisual(tomas)
		game.addVisual(tomasIzquierda)
		game.addVisual(tomasDerecha)
		game.addVisual(tomasArriba)
		game.addVisual(tomasAbajo)
		//Configuraciones
		config.configurarTeclas()
		config.configurarColision()
		game.onTick(2000, "generarEnemigos", { => enemigos.generar()})
		
	}	
}

object config {
	method configurarTeclas() {
		keyboard.a().onPressDo({ tomas.moverseA(tomasIzquierda)})
		keyboard.d().onPressDo({ tomas.moverseA(tomasDerecha)})
		keyboard.w().onPressDo({ tomas.moverseA(tomasArriba)})
		keyboard.s().onPressDo({ tomas.moverseA(tomasAbajo)})
		
		//Para atacar
		keyboard.up().onPressDo({ tomas.atacar(tomasArriba)})
		keyboard.down().onPressDo({ tomas.atacar(tomasAbajo)})
		keyboard.left().onPressDo({ tomas.atacar(tomasIzquierda)})
		keyboard.right().onPressDo({ tomas.atacar(tomasDerecha)})
		
		//Para usar las pociones
		keyboard.num1().onPressDo({ tomas.usarPocion(0)})
		keyboard.num2().onPressDo({ tomas.usarPocion(1)})
		keyboard.num3().onPressDo({ tomas.usarPocion(2)})
	}
	method configurarColision(){
		game.onCollideDo( tomas, { algo => algo.esEncontrado(tomas) })
		game.onCollideDo( tomasDerecha, { algo => algo.proximidadTomas(tomasDerecha) })
		game.onCollideDo( tomasArriba, { algo => algo.proximidadTomas(tomasArriba) })
		game.onCollideDo( tomasAbajo, { algo => algo.proximidadTomas(tomasAbajo) })
		game.onCollideDo( tomasIzquierda, { algo => algo.esEncontrado(tomasIzquierda) })
	}
}

object enemigos{
	const slime = new Slime()
	const sombrio = new Sombrio()
	const esqueleto = new Esqueleto()
	
	method valorRan() = 0.randomUpTo(3).truncate(0)
	method generar(){
		if(self.valorRan() == 1){ slime.aparecer()
		} else if(self.valorRan() == 2){ sombrio.aparecer()
		} else if(self.valorRan() == 3){ esqueleto.aparecer() }
	}
}