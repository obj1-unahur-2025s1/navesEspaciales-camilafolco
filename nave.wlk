class Nave {
    var property velocidad
    var property direccion 

    method acelerar(cuanto) {
        velocidad = (velocidad + cuanto).min(100000)
    }
    method desacelerar(cuanto) {
        velocidad = (velocidad - cuanto).max(0)
    }
    method irHaciaElSol() {direccion = 10}
    method escaparDelSol() {direccion = -10}
    method ponerseParaleloAlSol() {direccion = 0}
}

class NaveBaliza inherits Nave {
    var color = "azul"

    method cambiarColorDeBaliza(colorNuevo) {color = colorNuevo}
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
}