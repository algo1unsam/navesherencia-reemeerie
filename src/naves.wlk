class Nave{
	var velocidad = 0 //en kms/seg
	
	method velocidad(){
		return velocidad
	}
	method velocidad(numero){
		velocidad = numero
		
		return velocidad
	}
	method propulsar(){
		if(velocidad < 280001){
			velocidad = velocidad + 20000
			return velocidad
		} else {
			const faltante = 300000 - velocidad
			velocidad = velocidad + faltante
			
			return velocidad
		}
	}
	
	method preparar(){
		if(velocidad < 285001){
			velocidad = velocidad + 15000
			return velocidad
		} else {
			const faltante = 300000 - velocidad
			velocidad += faltante
			
			return velocidad
		}
	}
}

class Nave_de_carga inherits Nave{
	var property masa_carga = 0//en kg - 100T = 100.000kg
	
	method esta_sobrecargada(){
		return (masa_carga > 100000) and (velocidad > 100000)
	}
	
	method recibe_amenaza(){
		masa_carga = 0
	}
	
	method encontrar_enemigo(){
		self.propulsar()
		self.recibe_amenaza()
	}
}

class Nave_de_pasajeros inherits Nave{
	const personal = 4
	var property pasajeros = 0
	var alarma = false
	
	method cantidad_pasajeros(){
		return personal + pasajeros
	}
	
	method recibe_amenaza(){
		alarma = true
	}
	method alarma(){
		return alarma
	}
	method velocidad_maxima(){
		if(self.cantidad_pasajeros() > 100){
			return (300000 / self.cantidad_pasajeros()) - 200
		}else{
			return 300000 / self.cantidad_pasajeros()
		}
	}
	
	method esta_en_peligro(){
		return alarma or (velocidad > self.velocidad_maxima())
	}
	
	method encontrar_enemigo(){
		self.propulsar()
		self.recibe_amenaza()
	}
}
class Nave_de_combate inherits Nave{
	var property modoAtaque = false // false = reposo, true = ataque
	var property desplegarArmas = false
	
	method estaInvisible(){
		return (velocidad < 10000 and not self.modoAtaque()) or not self.desplegarArmas()
	}
	
	method recibe_amenaza(){
		if(modoAtaque){
			return "Enemigo Encontrado"
		} else {
			return "RETIRADA"
		}
	}
	
	override method preparar(){
		if(velocidad < 285001){
			velocidad = velocidad + 15000
		} else {
			const faltante = 300000 - velocidad
			velocidad += faltante
		}
		
		if(modoAtaque){
			return "Volviendo a base"
		} else {
			modoAtaque = true
			return "Saliendo en mision"
		}
	}
	
	method encontrar_enemigo(){
		self.propulsar()
		return self.recibe_amenaza()
	}
}
class Nave_de_carga_radioactiva inherits Nave_de_carga{
	var property sellada_al_vacio = false
	
	override method recibe_amenaza(){
		velocidad = 0
	}
	
	override method preparar(){
		sellada_al_vacio = true
		
		if(velocidad < 285001){
			velocidad = velocidad + 15000
			return velocidad
		} else {
			const faltante = 300000 - velocidad
			velocidad += faltante
			
			return velocidad
		}
	}
} 

