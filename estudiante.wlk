import cursadas.*

const leo = new Estudiante(formaDeEstudiar = remadora)
const caro = new Estudiante(formaDeEstudiar = new Prioritaria(materia = "AdS"))

class Estudiante {
        const property tareasPendientes = []
        const tareasCompletas = []
        var property formaDeEstudiar

        method recibirTarea(tarea){
tareasPendientes.add(tarea)
        }
        method estudiar(){
formaDeEstudiar.estudiar(self)
        }
        method trabajarSobre(tareaElegida){
tareasPendientes.remove(tareaElegida)
tareasCompletas.add(tareaElegida)
        }

        method completo(tarea) = tareasCompletas.contains(tarea)

        method cursoMasColgado() = self.cursos().max {curso => self.nivelDeCuelgue(curso)
        }

        method nivelDeCuelgue(curso)
 = tareasCompletas.count {tarea => tarea.curso() == curso}
 - tareasPendientes.count {tarea => tarea.curso() == curso}

        method cursos() = self.tareasRecibidas().map {tarea => tarea.curso()}.asSet()

        method tareasRecibidas() = tareasCompletas + tareasPendientes

        method tiempoQueRequiere(tarea) = tarea.tiempoEstimado()

}

object hijoDelRigor inherits Selectiva {
        override method elegirTarea(tareas, estudiante) = tareas.min {tarea => tarea.proximidadAFechaDeEntrega()
        }
}

object prudente inherits Selectiva {
        override method elegirTarea(tareas, estudiante) = tareas.max {tarea =>
estudiante.tiempoQueRequiere(tarea)
        }
}

class Prioritaria inherits Selectiva {
        const property materia
        override method elegirTarea(tareas, estudiante)
 = tareas.findOrElse({tarea =>
 tarea.materia() == materia}, {tareas.first()})
}

object remadora inherits Selectiva {
        override method elegirTarea(tareas, estudiante) = tareas.max { tarea => tarea.curso() == estudiante.cursoMasColgado()
        }
}


///////////////////////////////////////
// Formas de estudiar (último cambio)
///////////////////////////////////////

class Selectiva {
        method estudiar(estudiante){
                 const tareaElegida = self.elegirTarea(estudiante.tareasPendientes(), estudiante) estudiante.trabajarSobre(tareaElegida)
        }
        method elegirTarea(tareas, estudiante)
}

class Complecionista {
        method estudiar(estudiante){
estudiante.tareasPendientes().forEach {tarea => estudiante.trabajarSobre(tarea)}
        }
}


////////////////////////////////////
// Administración de tiempo:
// Nuevos tipos de estudiantes
////////////////////////////////////


class Distraido inherits Estudiante {
        var distraccion = 0

        override method estudiar(){
                super()
                distraccion += 1
        }
        method despejarse(){
                distraccion = 0
        }
        override method tiempoQueRequiere(tarea) = super(tarea) + distraccion

}


//a los enfocados les rinde mas el tiempo. 


class Enfocado inherits Estudiante {
        override method tiempoQueRequiere(tarea) = (super(tarea) - 2).max(1)
}



//acoplamiento entre formadeelegir y estudiante? prioritaria tiene una materia que esta relacionada al estudiante. La forma de elegir esta muy arraigada al eatudiante, esta muy acopladas. Aun asi pudimos dividir bien las prioridades. Igual siempre estan acoplados. Por ejemplo el curso mas colgado depende del estudiante. La forma de elegir solo se encarga de elegir

//cohesion. es cuando el objeto hace pocas cosas... en cambio si meto todo en un solo objeto chau cohesion. Aca la cohesion bastante bien, muchos objetos chiquitos, hacen pocas cosas.

//estos dos conceptos son cualitativos. No hay una medicion preciaa



// la herencia es algo estatico y la estamos utilizando en tipo simple (hereda de 1 sola superclase).

