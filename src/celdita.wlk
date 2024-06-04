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
		game.schedule(300, { => inicio.play() inicio.volume(0.2)})
		keyboard.enter().onPressDo{ self.explicar()}
	}	
	
	method explicar() {
		game.clear()
		game.addVisual(explicacion)
		keyboard.enter().onPressDo{inicio.pause() self.configurar()}
	}
	
	method configurar() {
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
		
		game.addVisual(puntajeTotal)
		
		//Inicio
		config.configurarTeclas()
		config.configurarColision()
		game.schedule(7000,{ new Combate().iniciar()})
	}	
	
	method gameOver(){
		game.clear()
		game.addVisual(perdiste)
		batalla.pause()
		perder.play()
		keyboard.enter().onPressDo{ 
			game.clear() 
			perder.pause()
			self.resetearValores() 
			self.configurar()
		}
		keyboard.backspace().onPressDo{ game.stop()}
	}
	method resetearValores(){
		tomas.mochila([])
		tomas.vivo(true)
		tomas.vida(100)
		vidaCorazon.actualizar(100)
		tomas.poderBase(10)
	 	tomas.tieneEspada(false)
		tomas.esInvencible(false)
		espada.esCaminable(false)
		tomas.puntaje(0)
		tomas.position(game.origin()) 
		tomas.estado('Basico')
		espada.nombre('estatua')		
	}
	
	method winner(){
		ganar.play() 
		keyboard.enter().onPressDo{ ganar.pause() game.stop()}
	}	
}