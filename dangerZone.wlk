

// primer requerimiento

// empleado.estaIncapacitado()

class Empleado {
   var puesto
   var salud = 100
   

   method estaIncapacitado() = salud < puesto.saludCritica()

}

object espia {

   method saludCritica() = 30
}













