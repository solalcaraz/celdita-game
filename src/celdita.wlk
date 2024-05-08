import wollok.game.*
import tomas.*
import monstruos.*
import pocion.*
import extra.*

object celdita {
	method iniciar() {
		game.addVisual(tomas)
		game.addVisual(espada)
		config.configurarTeclas()
		config.configurarColision()
	}
}

object config {
	method configurarTeclas() {
		keyboard.a().onPressDo({ tomas.moverseA(tomas.position().left(1)) })
		keyboard.d().onPressDo({ tomas.moverseA(tomas.position().right(1)) })
		keyboard.w().onPressDo({ tomas.moverseA(tomas.position().up(1)) })
		keyboard.s().onPressDo({ tomas.moverseA(tomas.position().down(1)) })
		//Para agarrar
		keyboard.n().onPressDo({ tomas.agarrar( game.uniqueCollider(tomas))})
		//Para atacar, REVISAR
		keyboard.m().onPressDo({ tomas.atacar()})
		//Para usar las pociones
		keyboard.num1().onPressDo({ tomas.usarPocion(0)})
		keyboard.num2().onPressDo({ tomas.usarPocion(1)})
		keyboard.num3().onPressDo({ tomas.usarPocion(2)})
	}
	method configurarColision(){
		game.onCollideDo( tomas, { algo => algo.esEncontrado(tomas) })
	}
}