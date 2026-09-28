import wollok.game.*
import tomas.*
import pocion.*
import extra.*
import visuales.*
import sonidos.*

class Monstruo {
	const nombre
	var vida
	var vivo = false
	const sonidoHerido
	var estado = "Basico"

	const pocion
	const poderBase
	const property esCaminable = false
	const property esMalo = true

	var property position = game.origin()
	method image() = imagen.archivo(nombre, estado)

	method aparecer(){
		position = game.at(azar.entero(0, game.width()), azar.entero(0, game.height()))
		game.addVisual(self)
		vivo = true
		self.movimiento()
	}

	method desaparecer(){ self.detenerse() game.removeVisual(self)}

	method movimiento() { game.onTick(2000, "movimiento", { => self.moverse()})}
	method detenerse() {
		// removeTickEvent da error si ya no queda ningún evento con ese nombre,
		// y todos los monstruos comparten el mismo.
		try{
			game.removeTickEvent("movimiento")
		} catch e:wollok.lang.Exception{}
	}

	method sigueAlLado(colisionador) = not game.colliders(colisionador).isEmpty() and game.uniqueCollider(colisionador).equals(self)

	method logicaAtaque(colisionador) {
		// La posición de Tomás se toma ahora y el golpe llega medio segundo después:
		// si Tomás se movió en ese tiempo, el golpe no le llega.
		const posicionDeTomas = colisionador.posTomas()
		game.schedule(500, {self.atacar(posicionDeTomas)})
		game.schedule(1000, {self.continuarAtaque(colisionador)})
	}

	method esEncontrado(){}

	method proximidadTomas(colisionador){
		self.detenerse()
		self.logicaAtaque(colisionador)
	}

	method continuarAtaque(colisionador){
		if(self.sigueAlLado(colisionador) and vivo){
			self.logicaAtaque(colisionador)
		} else { self.movimiento()}
	}

	method atacar(posicion){
		if(game.getObjectsIn(posicion).contains(tomas) and vivo){
			game.getObjectsIn(posicion).first().esAtacado(poderBase)
		}
	}

	method recibirDanio(danio){
		vida -= danio
		estado = "Herido"
		game.schedule(50,{estado = "Basico" sonidos.reproducir(sonidoHerido)})
		if(vida <= 0){ self.morir()}
	}

	method morir() {
		vivo = false
		sonidos.reproducir("muerteMonst.mp3")
		self.desaparecer()
		if(azar.entero(0, 2) == 1){ self.soltarPocion()}
		tomas.actualizarPuntaje()
	}

	method soltarPocion() { pocion.aparecer(position)}
	method moverse()
}

class Sombrio inherits Monstruo(vida = 50, poderBase = 40, pocion = new PocionInvencible(), nombre = "sombrio", sonidoHerido = "sombrioHerido.mp3") {
	override method moverse(){
		if (azar.entero(0, 2) == 1  and tablero.contiene(position)){
			position = self.position().left(2)
			position = self.position().up(1)
		} else {
			position = self.position().left(2)
			position = self.position().down(1)
		}
	}
}

class Slime inherits Monstruo(vida = 60, poderBase = 20, pocion = new PocionFuerza(), nombre = "slime", sonidoHerido = "slimeHerido.mp3") {
	override method moverse(){
		if(self.position().y() > tomas.position().y()  and tablero.contiene(position)){
			position = self.position().down(1)
		} else {
			position = self.position().up(1)
		}
	}
}

class Esqueleto inherits Monstruo(vida = 80, poderBase = 10, pocion = new PocionAturdimiento(), nombre = "esqueleto", sonidoHerido = "esqueletoHerido.mp3") {
	override method moverse(){
		if(self.position().x() > tomas.position().x() and tablero.contiene(position)){
			position = self.position().down(1)
		} else {
			position = self.position().up(1)
		}
	}
}
