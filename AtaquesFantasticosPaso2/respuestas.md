## Preguntas

1. ¿Qué crítica le harías al protocolo de #estaHerido y #noEstaHerido? (en vez de tener solo
el mensaje #estaHerido y hacer “#estaHerido not” para saber la negación)

2. ¿Qué opinan de que para algunas funcionalidades tenemos 3 tests para el mismo
comportamiento pero aplicando a cada uno de los combatientes (Arthas, Mankrik y Olgra)

3. ¿Cómo modelaron el resultado de haber desarrollado un combate? ¿qué opciones
consideraron y por qué se quedaron con la que entregaron y por qué descartaron a las otras?

## Respuestas

1. Los mensajes #estaHerido y #noEstaHerido son mensajes contrapuestos, es decir,
cuando al colaborardor se le envia #estaHerido respondera true, mientras #noEstaHerido
false. Entonces corresponde a una especie de codigo repetido, lo mas facil seria
que solo se pueda usar uno y el otro descartarlo. En lo personal, creemos, que es
mejor el mensaje #estaHerido, ya que al hacer la negacion es mas facil de leer
(#estaHerido not). En vez de leer, #noEsaHerido not, que se requiere unos segundos
mas para entender. Despues, en nuestro caso, empezamos implementeando #noEstaHerido,
la forma en que lo hicimos, es ver si la vida del personaje es >= 20*pv, algo que no
es muy practico, porque el dia de mañana si el personaje en vez de arrancar con
20*pv arranca con 30, habria que cambiar la implementacion de #noEstaHerido
y/o #estaHerido. Ademas ya existen mensajes, como #tienePuntosDeVida
o #estaFueraDeCombate, que permitirian dentro de los tests, rapidamente saber
si un personaje esta herido o no.

2. Suponiendo que existiera una herencia entre los objetos, de forma que todos
puedan responder los mismos mensajes o por lo menos algunos (no es nuestro caso), si
es innecesario el uso de 3 tests diferentes para la misma implementacion, por ejemplo #noEstaHerido o #atacar. Existen algunos mensajes, como #atacarA, que si cambian su
implementacion, ya que para algunos personajes se les añade una bonifiacion por fuerza
por lo que daño en los ataques cambia. Por lo tanto, ahi no vemos que haya un problema
en hacer diferentes tests para cada uno de los personajes. Aunque se podria añadir, segun
el personaje la bonificacion de corresponde, sea 0 o 2 puntos, por lo tanto ahi la
implementacion de #atacarA seria la misma. En conclusion, la cantidad de tests es
neceseria o no, en la medida si la implementacion de los mensajes es la misma o cambia.
Lo ideal seria que las implementaciones sean las misma, y en consecuente, la cantidad de
tests se reduzca.

3. Dado el mensaje #desarrolloDuranteRondas, se manda el mensaje #ejecutarRonda.
Este ultimo, se manda, mientras el combate pueda seguir y la cantidad de rondas que
se hayan jugado no sea mayor a las que se enviaron a traves del mensaje. Para saber si
el combate hay que seguir simplemente, basta con saber si para alguno de los bandos hay
al menos un combatiente que, justamente, pueda combatir. Y lo contrario del otro bando,
si eso no se cumple se frena el combate. Luego se mira si hubo algun ganador, si no hubo ninguno de los dos ganadores se devolvera como resultado del combate 'Indeterminado',
si hubo ganador el colaborador resultado cambiara a 'Gano 1' o 'Gano 2'. La manera de
saber si hay ganadores es mirando si hay justamente combatientes preparados para el combate,
una de las formas que consideramos era mirarando y comparando la cantidad de elementos
que hay en la lista, al final, nos terminamos quedando con la opcion de solo mirar si la lista
esta vacia o no, nos quedamos con esta ultima porque nos parecida media ilegible la primera
opcion y poco practica. El mensaje #debeContinuarElCombate, puede determinar si uno
de los dos bandos fue ganador, sabiendo justamente, si el combate puede continuar o no.
Si no pudo continuar es porque uno de los dos bandos gano y es ahi cuando manda
un mensaje #determinarResultado, para saber que bando gano. Sino hay bandos
ganadores ese mensaje no se manda y el resultado es 'Indeterminado'.
