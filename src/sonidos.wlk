import wollok.game.*

const inicio = game.sound("musicaInicio.mp3")
const batalla = game.sound("batalla.mp3")
	
object sonidos {
	var property sonido
	
	method nuevoSonido(nombre) { 
		sonido = nombre
		self.play()
	}
	
	method play(){
		game.sound(sonido).play()
	}
	
	//method loop() { sonido.shouldLoop(true)}
}