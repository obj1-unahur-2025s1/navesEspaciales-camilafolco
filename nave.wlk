class Nave {
    var velocidad
    var direccion 
    var combustible

    method acelerar(cuanto) {
        velocidad = (velocidad + cuanto).min(100000)
    }
    method desacelerar(cuanto) {
        velocidad = (velocidad - cuanto).max(0)
    } 
    method irHaciaElSol() {direccion = 10}
    method escaparDelSol() {direccion = -10}
    method ponerseParaleloAlSol() {direccion = 0}
    method acercarseAlSol() {
        direccion = (direccion + 1).min(10)
    }
    method alejarseDelSol() {
        direccion = (direccion - 1).max(-10)
    }
    method prepararViaje() {
        self.cargarCombustible(30000)
        self.acelerar(5000)
    }
    method cargarCombustible(cantidad) {
        combustible += cantidad
    }
    method descargarCombustible(cantidad) {
        combustible -= cantidad
    }
    method estaTranquila() = combustible >= 4000 && velocidad <= 12000
    method recibirAmenaza() {
        self.escapar()
        self.avisar()
    }
    method escapar()
    method avisar()
    method estaDeRelajo() = self.estaTranquila() && self.tienePocaActividad()
    method tienePocaActividad()
}

class NaveBaliza inherits Nave {
    var color = "azul"
    const colores = []

    method cambiarColorDeBaliza(colorNuevo) {
        color = colorNuevo
        colores.add(colorNuevo)
    }
    override method prepararViaje() {
        super()
        self.cambiarColorDeBaliza("verde")
        self.ponerseParaleloAlSol()
    }
    override method estaTranquila() = super() && color != "rojo"
    override method escapar() {
        self.irHaciaElSol()
    }
    override method avisar() {
        self.cambiarColorDeBaliza("rojo")
    }
    override method tienePocaActividad() = colores.isEmpty()
}

class NavePasajeros inherits Nave {
    var property pasajeros 
    var comida
    var bebida

    method agregarComida(racion) {
        comida += racion
    }
    method agregarBebida(racion) {
        bebida += racion
    }
    method descargarComida(racion) {
        comida -= racion
    }
    method descargarBebida(racion) {
        bebida -= racion
    }
    override method prepararViaje() {
        super()
        self.agregarBebida(6 * pasajeros)
        self.agregarComida(4 * pasajeros)
        self.acercarseAlSol()
    }
    override method escapar() {
        velocidad *= 2
    }
    override method avisar() {
        self.agregarBebida(2 * pasajeros)
        self.agregarComida(pasajeros)
    }
    override method tienePocaActividad() = comida < 50
}

class NaveCombate inherits Nave {
    var estaInvisible = true
    var misilesDesplegados = true 
    const mensajesEmitidos = []

    method ponerseVisible() {
        estaInvisible = false
    }
    method ponerseInvisible() {
        estaInvisible = true
    }
    method desplegarMisiles() {
        misilesDesplegados = true
    }
    method replegarMisiles() {
        misilesDesplegados = false
    }
    method emitirMensaje(mensaje) {
        mensajesEmitidos.add(mensaje)
    }
    method primerMensajeEmitido() = mensajesEmitidos.first()
    method ultimoMensajeEmitido() = mensajesEmitidos.last()
    method emitioMensaje(mensaje) = mensajesEmitidos.contains(mensaje)
    method esEscueta() = mensajesEmitidos.all({m => m.size() <= 30})
    override method prepararViaje() {
        super()
        self.ponerseVisible()
        self.replegarMisiles()
        self.acelerar(15000)
        self.emitirMensaje("Saliendo en misión")
    }
    override method estaTranquila() = super() && ! misilesDesplegados 
    override method escapar() {
        self.acercarseAlSol()
        self.acercarseAlSol()
    }
    override method avisar() {
        self.emitirMensaje("Amenaza recibida")
    }
}

class NaveHospital inherits NavePasajeros {
    var quirofanosPreparados = false

    method prepararQuirofanos() {
        quirofanosPreparados = true
    }
    override method estaTranquila() = super() && ! quirofanosPreparados
    override method recibirAmenaza() {
        super()
        self.prepararQuirofanos()
    }
}

class NaveDeCombateSigilosa inherits NaveCombate {

    override method estaTranquila() = super() && ! estaInvisible
    override method recibirAmenaza() {
        super()
        self.desplegarMisiles()
        self.ponerseInvisible()
    }
}