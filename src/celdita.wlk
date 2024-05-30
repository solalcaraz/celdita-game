import wollok.game.*
import tomas.*
import pocion.*
import extra.*
import monstruos.*

object celdita {
	method iniciar() {
		game.addVisual(espada)
		game.addVisual(tomas)
		game.addVisual(tomasIzquierda)
		game.addVisual(tomasDerecha)
		game.addVisual(tomasArriba)
		game.addVisual(tomasAbajo)
//		const pepe = new Monstruos(position=game.center(),nombre="slime",poderBase = 10,vida = 100, pocion=new PocionFuerza(position=game.center()))
//		game.addVisual(pepe)
//		
//		const sombrio = new Sombrio(position=game.center(),poderBase = 10,vida = 100)
//		const golem = new Golem(position=game.at(8, 8),poderBase = 10,vida = 100)
//		game.addVisual(sombrio)
//		game.addVisual(golem)
//		game.addVisual(new Esqueleto(position=game.at(10, 4),poderBase = 10,vida = 100))
//		game.onTick(3000, "mov sombrio", {
//			sombrio.moverse()
//			golem.moverse()
//		})
		
		config.configurarTeclas()
		config.configurarColision()
	}
}

object config {
	method configurarTeclas() {
		keyboard.a().onPressDo({ tomas.moverseA(tomas.position().left(1))})
		keyboard.d().onPressDo({ tomas.moverseA(tomas.position().right(1))})
		keyboard.w().onPressDo({ tomas.moverseA(tomas.position().up(1))})
		keyboard.s().onPressDo({ tomas.moverseA(tomas.position().down(1))})
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