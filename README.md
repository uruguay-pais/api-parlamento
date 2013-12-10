Una API que devuelve JSON con los legisladores y el trabajo del Parlamento. Inspirada en la API del Congreso de Sunlight. 

### Caracterizticas

* Buscar datos de legisladores por nombre.
* Comites del parlamento, miembros y temas.

### Uso

##### Metodos

###### Obtener lista de senadores

     GET /senadores

 Campos

     "nombre": "Nombre",
     "apellido": "Apellido",
     "partido": "El partido que sea",
     "email": "Correo electronico"

###### Obtener lista de diputados
	
	Get /diputados

###### Obtener diputados por departamento

	Get /departamento/diputados

###### Obtener lista de comisiones

	Get /comisiones

###### Obtener lista de miembros de una comision

	Get /comisiones/miembros

###### Obtener comisiones de un legislador

	Get /legislador/comisiones

###### Obtener el texto de la constitucion para un año, por defecto la actual

	Get /constitucion

### Mapa de Ruta

* Leyes
* Proyectos de Ley

### Licencia

Este software tiene licencia GPL. Leer en LICENCIA.txt
