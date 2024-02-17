

// 2 requerimientos 

/* Se puede ver como la responsabilidad en el dispositivo tanto para saber si es util para atender a un animal y para hacer que lo atienda. 
 * 
 * 
 * dispositivo.esUtilParaAtender(animal)
 * 
 * dispositivo.atiende(animal)
 * 
 */
 
 /*
  * otra hubiese sido incluirle la responsabilidad al animal
  * 
  * animal.esUtilParaAtenderse(dispositivo)
  * 
  */
 
 /*
  * La interfaz de Dispositivo seria algo muy pobre porque a la clase Gallina deberia preguntarle por el peso Maximo del dispositivo (pierdo Encapsulamiento), le hago hacer preguntas que no debe saber (pierdo Delegacion) y ademas al preguntar si le estÃ¡ hablando a uno u otro dispositivo pierdo el polimorfismo.
  * 
* class Dispositivo {
* 	method esUtilParaAtender(animal)
* 	method atiende(animal)
* }
 */
 
 
 /*
  * el bebedero es util para atender a los animales con sed
  * 
  * 
  */
  
 class Bebedero {
 	
 	method esUtilParaAtender(animal) = animal.tieneSed()
 	
 	method atender(animal){
 		animal.bebe()
 	}
 }
 
/*
 * los comederos deben tener un limite de peso de animal para atenderlo
 * 
 * comedero.puedeAtenderA(animal)
 */
 
 class Comedero {
 	const pesoMaximoSoportado
 	var property cantidadDeComida
 	
 	method esUtilParaAtender(animal) =
 		animal.tieneHambre() &&
 	animal.peso() < pesoMaximoSoportado
 	
 	method atender(animal){ //hay que agregarle la condicion de atenderlo o no por el peso maximo
 		if(
 	self.esUtilParaAtender(animal)
 		)
 		{animal.come(cantidadDeComida)
 		cantidadDeComida = 0}
 		else self.error("no es posible atender al animal en este comedero")
 	}
 	//el self.error es distinto de colocar un return con string porque se convierte de ser un comportamiento de consulta a un comportamiento de ejecucion un retorno. Con el self.error se corta el FLUJO DE CIRCULACION, se levanta RedFlag.
 }
 
 /* ya con que cualquiera entienda los mensajes de tieneSed, tieneHambre y peso, se puede considerar como una interfaz de Animal.
  * 
  * LA INTERFAZ APARECE CON EL USO
  */
 
 /*
* class Animal {
* 	
* 	var property peso
* 	 
* 	method peso() = peso
*	
* 	method come(cantidad)
* 	
* 	method bebe()
* 	
* 	method tieneHambre() = false
* 	
*	method tieneSed() = false
*
* }
 */
 
 /*
  * por ahora solo nos focalizamos en mensajes de consulta, tieneHambre() y tieneSed(), no buscamos comportamiento de ejecicion con come() y bebe().
  * 
  */

/*
 * En la 2da parte para hacer que un animal se atienda se pueden plantear nuevamente del lado del dispositivo o del lado del animal
 * 
 * dispositivo.atiende(animal)
 * 
 * animal.seAtiendeEn(dispositivo)
 * 
 */

 class Gallina {
 	
 	method peso() = 4
 	method tieneSed() = false
 	method tieneHambre() = true
 	
 	method vacunado() = false
 	
 	method esUtilParaAtenderse(dispositivo) = dispositivo.esUtilParaAtenderse(self)
 	
 	method come(cantidad){
 		//no hace nada
 	}
 	
 	method bebe(){
 		//no hace nada
 	}
 	
 	method convieneSerVacunado() = false
 }
 
 
 class Vaca {
 	
 	var property peso 	
 	var property tieneSed = false //porque no hace falta calcularlo
 	//method tieneSed() = false
 	method vacunado() = false
 	
 	method tieneHambre() = 
 	peso < 200

 	method bebe(){
 		tieneSed = false
 		peso -= 0.5
 	}
 	
 	method come(cantidad) {
 		peso += cantidad / 3
 		tieneSed = true
 	}
 	
 	method convieneSerVacunado() = if (self.vacunado() == true)
 
 }
 
 
 class Cerdo {
 	var property peso
 	var property tieneHambre = false
 	
 	var cantidadDeComidas = 0
 	
 	method vacunado() = false
 	
 	method tieneSed() = cantidadDeComidas > 3
 	
  	method bebe(){
 		if (cantidadDeComidas > 3)
 		self.tieneSed()
 		tieneHambre = true
 	}
  	
  	method come(cantidad) {
  		cantidadDeComidas +=1
  		peso += (cantidad-0.2).max(0)
 		if (cantidad > 1)
 		tieneHambre = false
 	}
 	
 	method convieneSerVacunado() = true
 }
 
 /*
  * COLECCIONES
  * 
  * para saber preguntar si todos los animales tienen hambre puedo usar el all sobre un bloque de codigo
  * 
  * animales.all({animal => animal.tieneHambre()})
  * 
  * 
  * por otro lado puedo filtrar los animales que tienen sed de la misma manera pero aplicando un filter
  * 
  * animales.filter({animal => animal.tieneSed()})
  *
  * y para obtener la suma de los animales se le aplica el "sum" a un "map" o aca en wollok directamente el sum
  * 
  * animales.sum({animal => animal.peso()})
  * 
  * Al aplicar tanto el filter como el map no se me borra la coleccion existes sino que crea una nueva (como en Fucional). Tampoco es necesario verificar si la coleccion es o no Nula.
  * 
  * 
  * Para saber el de mayor peso se envia el mensaje "max"
  * 
  * animales.max({animal => animal.peso()})
  * 
  * 
  * Para encontrar alguno de peso mayor a 250kg se usa el "find", no un "filter" porque devolveria un conjunto de animales.
  * 
  * animales.find({animal => animal.peso() > 250})
  * 
  * 
  * Para hacer que todos coman 300 gramos se usa el "forEach", en vez de ser un mensaje de consulta como todos los anteriores, aca se produce un efecto (en Funcional NO se busca producir Efecto por eso no existe el forEach).
  * 
  * animales.forEach({animal => animal.coma(0.3)})
  * 
  * 
 */
  /* para plantear la estacion de animales hay que agregarle dispositivos y saber si el animal puede ser atendido siempre y cuando tenga un dispositivo util y por otro lado saber cuales son los dispositivos utiles para un animal
   * 
   * la responsabilidad puede ser de la estacion
   * 
   * estacion.puedeAtender(animal)
   * 
   * estacion.dispositivosUtilesPara(animal)
   * 
   */
 class EstacionDeAtencion {
 	const property dispositivos = #{}
 	
 	method agregarDispositivo(dispositivo) = dispositivos.add(dispositivo)
	
	method quitarDispositivo(dispositivo) = dispositivos.remove(dispositivo) 	
 
 	method consumoEnergetico() = dispositivos.sum({dispositivo => dispositivo.consumoEnergetico()}) * 1.1
 
 	method puedeAtender(animal) = dispositivos.any({dispositivo => dispositivo.esUtilParaAtender(animal)})
 
 	method dispositivosUtiles(animal) = dispositivos.filter ({dispositivo => dispositivo.esUtilParaAtender(animal)})
 	
 //hay que entender que todos estos mensajes son de consulta, pero son capaces de producir efecto porque tiene un bloque de codigo pero siempre dentro de la consulta
 
 /*
  * para darle la atencion basica se busca el dispositivo de menor consumo que le sea util
  * 
  * estacion.atencionBasica(animal)
  * 
  * estacion.atencionCompleta(animal)
  * 
  */
 	method atencionBasica(animal) {self.dispositivosUtiles(animal).min({dispositivo => dispositivo.consumoEnergetico()}).atender(animal)
 	// con el min nos aseguramos que si hay una lista vacia este cacho de codigo explota
 }
 
 	method atencionCompleta(animal) {
	if (not self.puedeAtender(animal))
		self.error("el animal no puede atenderse")
	self.dispositivosUtiles(animal).forEach({dispositivo => dispositivo.atender(animal)})
 	}
 	// en este caso con una coleccion vacia el "forEach" no hace nada pero no sabria que no da ninguna atencion a animal se deberia agregar el error para avisar que no fue atendido, que tambien se puede abstraer en otro metodo.
 	
 	/*
 	 * como otra salvedad se puede ver el encapsulamiento de la lista de dispositivos para la Estacion ya que solamente ella la puede usar y en tal caso modificarla. Por mas que se le puso un getter para que quizas alguien de afuera pueda llegar a ponerle o quitarle elementos. No hace falta estar cubiertos por todos lados de este encapsulamiento, solo hay que tener cuidado.
 	 * 
 	 */
 }
 
 /*
  * se agrega el dispositivo vacunatorio que vacuna a un animal.
  * 
  * a la vaca solo conviene vacunarla una vez, a la gallina nunca y a los cerdos siempre
  * 
  * animal.convieneSerVacunado()
  */
 
 class Vacunatorio {
 	
 	var property dosis = 0
 	
 	method tieneDosis() = dosis > 0

 	
 	method esUtilParaAtender(animal) = self.tieneDosis() && animal.convieneVacunar(animal)

 	
 	method atender(animal) {
 		animal.vacunado()
 		dosis -= 1
 	}
 	
 	
 	
 	
 }
 
 