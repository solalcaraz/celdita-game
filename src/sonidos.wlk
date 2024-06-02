import wollok.game.*

const inicio = game.sound("musicaInicio.mp3")
const batalla = game.sound("batalla.mp3")
const perder = game.sound("perdiste.mp3")
const ganar = game.sound("ganaste.mp3")
	
object sonidos {
	var property sonido
	
	method nuevoSonido(nombre) { 
		sonido = nombre
		self.play()
	}
	
	method play(){
		game.sound(sonido).play()
	}
}