import wollok.game.*

// Las músicas quedan guardadas para poder pausarlas y retomarlas desde distintas pantallas.
const inicio = game.sound("musicaInicio.mp3")
const batalla = game.sound("batalla.mp3")
const perder = game.sound("perdiste.mp3")
const ganar = game.sound("ganaste.mp3")

object sonidos {
	// Cada efecto crea un sonido nuevo porque en Wollok un mismo sonido se reproduce una sola vez.
	method reproducir(archivo) {
		game.sound(archivo).play()
	}
}
