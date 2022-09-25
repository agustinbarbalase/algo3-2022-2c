
# Preguntas

## Abstracción de los tests 01 y 02 

En los test 01 y 02 hay código repetido. Cuando lo extrajeron crearon algo nuevo. Eso es algo que estaba en la realidad y no estaba representado en nuestro código, por eso teníamos código repetido. ¿Cuál es esa entidad de la realidad que crearon?

## Cómo representar en Smalltalk

¿Cuáles son las formas en que podemos representar entes de la realidad en Smalltalk que conocés? Es decir, ¿qué cosas del lenguaje Smalltalk puedo usar para representar entidades de la realidad?

## Teoría de Naur

¿Qué relación hay entre sacar código repetido (creando abstracciones) y la teoría del modelo/sistema (del paper de Naur)?

## Respuestas

1. Basicamente, lo que no estaba representado en la realidad, y nosotros representamos es una especie de cronometro que ejecutara un bloque
de codigo y nos dijiera cuanto tiempo tardó este en ejecutarse. Toda esa abstraccion la hicimos a traves del mensaje '#measureTimeExecution'
que pasa como colaborador un bloque de codigo a ejecutarse y devuelve cuando tardo este ultimo en ejecutarse. Tambien, vimos la posibilidad
de crear una clase, que representara un cronometro, pero nos parecia que eso podría complejizar el modelo y que esto no formaba parte del
dominio del problema.

2. Existen dos formas de representar entes de la realidad de SmallTalk, la primera es a traves de la creacion de objetos. Por la propia
definicion de objetos, que es que estos son una entidad de la realidad en un dominio dado, cuando definimos un objeto estamos definiendo
una entidad de la forma mas pura, por asi decirlo. Por otro lado, tenemos las clases estas tambien son objetos, pero representan conceptos de 
un objeto, ej: un numero. Lo que hacemos es definir para cada clase una serie de mensajes que sabra responder, luego a partir de la clase 
creamos una instancia de dicha clase, lo que nos permitira tener un objeto concreto de nuestra realidad. Tanto crear objetos directamente, 
como las clases, tienen sus propias formas para jerarquizar el conocimiento. Cuando creamos objetos, es el prototipado que a traves del 
algortimo  de LookUp, permite ver si objetos 'padre' del mismo permiten responder mensajes que el mismo objeto no sabe responder. Mientras que
la subclasificacion, nos permite en las clases, subclasificar diferentes clases entre si, de forma que estas nos permiten armar un arbol de 
conceptos, ya que digimos que las clases reprensentan conceptos de la realidad, no objetos concretos. Las formas de definir objetos en 
el entorno de SmallTalk es a traves del DenotativeBrowser, mientras que las clases se hace en el ClassBrowser. 

3. Naur señala en su teoria, a los costos de la programacion, y uno de las cuestiones es la flexibilidad. Basicamente, la flexibilidad es
la que nos permite que armemos un diseño funcional preparado para futuros requirimientos. Sin embargo, esta se alcanza a un coste muy
grande y no es viable para un mundo tan cambiante. Por otro lado, las abstracciones son justamente las que nos permiten flexibilizar el
diseño de un programa, ya que nos permite olvidarnos un poco del 'como' y enfocarnos mas en el 'que'. Este aspecto, es fundamental, ya que
nos permite al mismo tiempo crear teorias mas complejas sobre nuestro programa. Por otro lado, como las abstracciones nos permite olvidarnos
del 'como', si el dia de mañana, quisiaramos cambiar la forma en como una abstraccion realiza determinada tarea, reduciria los costes de
modificar programas.
