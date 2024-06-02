import wollok.game.*
import tomas.*
import extra.*

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
		keyboard.p().onPressDo({ tomas.usarPocion()})
	}
	method configurarColision(){
		game.onCollideDo( tomas, { algo => algo.esEncontrado(tomas) })
		game.onCollideDo( tomasDerecha, { algo => algo.proximidadTomas(tomasDerecha) })
		game.onCollideDo( tomasArriba, { algo => algo.proximidadTomas(tomasArriba) })
		game.onCollideDo( tomasAbajo, { algo => algo.proximidadTomas(tomasAbajo) })
		game.onCollideDo( tomasIzquierda, { algo => algo.esEncontrado(tomasIzquierda) })
	}
}