import wollok.game.*
import tomas.*
import configuraciones.*
import combate.*
import extra.*
import visuales.*
import sonidos.*

object celdita {
	method configuracionInicial() {
		game.title("Celdita")
		game.height(11)
		game.width(20)
		game.addVisual(menu)
		game.schedule(500, { => inicio.play() inicio.volume(0.2)})
		keyboard.enter().onPressDo{ self.explicar()}
	}	
	
	method explicar() {
		game.clear()
		game.addVisual(explicacion)
		keyboard.enter().onPressDo{ self.configurar()}
	}
	
	method configurar() {
		inicio.volume(0.2)
		game.clear()
		game.addVisual(fondo)
		
		//Visuales
		game.addVisual(tomas)
		game.addVisual(tomasIzquierda)
		game.addVisual(tomasDerecha)
		game.addVisual(tomasArriba)
		game.addVisual(tomasAbajo)
		game.addVisual(espada)
		game.schedule(1000, { => espada.aparecer()})
		game.addVisual(vidaCorazon)
		
		//Inicio
		config.configurarTeclas()
		config.configurarColision()
		game.showAttributes(tomas)
		game.schedule(15000,{ new Combate().iniciar()})
	}
	
	method reiniciar(){
		game.clear()
		game.addVisual(perdiste)
		batalla.pause()
		game.clear()
		game.schedule(5000, { self.configuracionInicial()})
		tomas.vida(100)
	}	
}