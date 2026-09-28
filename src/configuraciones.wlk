import wollok.game.*
import tomas.*
import extra.*

object config {
	method configurarTeclas() {
		keyboard.a().onPressDo({ tomas.moverseA(tomasIzquierda)})
		keyboard.d().onPressDo({ tomas.moverseA(tomasDerecha)})
		keyboard.w().onPressDo({ tomas.moverseA(tomasArriba)})
		keyboard.s().onPressDo({ tomas.moverseA(tomasAbajo)})
		
		keyboard.up().onPressDo({ tomas.atacar(tomasArriba)})
		keyboard.down().onPressDo({ tomas.atacar(tomasAbajo)})
		keyboard.left().onPressDo({ tomas.atacar(tomasIzquierda)})
		keyboard.right().onPressDo({ tomas.atacar(tomasDerecha)})
		
		keyboard.p().onPressDo({ tomas.usarPocion()})
	}
	method configurarColision(){
		game.onCollideDo( tomas, { algo => algo.esEncontrado() })
		game.onCollideDo( tomasDerecha, { algo => algo.proximidadTomas(tomasDerecha) })
		game.onCollideDo( tomasArriba, { algo => algo.proximidadTomas(tomasArriba) })
		game.onCollideDo( tomasAbajo, { algo => algo.proximidadTomas(tomasAbajo) })
		game.onCollideDo( tomasIzquierda, { algo => algo.proximidadTomas(tomasIzquierda) })
	}
}