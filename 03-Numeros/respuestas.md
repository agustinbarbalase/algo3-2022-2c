# Preguntas

## Aporte de los mensajes de DD
1. En un double dispatch (DD), ¿qué información aporta cada uno de los dos llamados?

## Lógica de instanciado
2. Con lo que vieron y saben hasta ahora, ¿donde les parece mejor tener la lógica de cómo instanciar un objeto? ¿por qué? ¿Y si se crea ese objeto desde diferentes lugares y de diferentes formas? ¿cómo lo resuelven?

## Nombres de las categorías de métodos
3. Con lo que vieron y trabajaron hasta ahora, ¿qué criterio están usando para categorizar métodos?

## Subclass Responsibility
4. Si todas las subclases saben responder un mismo mensaje, ¿por qué ponemos ese mensaje sólo con un “self subclassResponsibility” en la superclase? ¿para qué sirve?

## No rompas
5. ¿Por qué está mal/qué problemas trae romper encapsulamiento?

# Respuestas

1. El primer llamado, aporta cual es el objeto que debe interactuar. Es decir, si hacemos Entero mas: OtroObjeto, OtroObjeto
es el que tiene que mandar o interactuar para mandar el mensaje. Y es ahi donde aparace el segundo mensaje, que sera OtroObjeto masEntero: self
que mandar como deben operar esos dos objetos.

2. En 'instance', en una categoria llamada 'initialization', en un mensaje #initialize o #initializeWith: segun si requiere o no valores.
Si requiere algun valor, en 'class' existe un mensaje llamado #with: y se le pasa los valores; sino se hace 'Class new' y listo.
Porque permite modificar a gusto los colaboradores internos, es decir, poner los valores que nostros queramos. Si existen diferentes formas,
de crear un objeto, pueden existir diferentes subclases que representen cada una de esas diferentes formas de crear un clase. Luego, en
la superclase, a traves de un criterio y un switch dinamico, se decide cual es la subclase que se quiere crear.

3. Segun si lo que hacen es del mismo dominio, es decir, si tengo una clase Numero con dos operaciones sumar y restar, las dos son
operaciones aritmeticas, por lo tanto, deben ir en la misma categoria porque ambas son del dominio de las operaciones aritmeticas. 

4. Poner el mensaje "self subclassResponsiblity" nos asegura que todas sus subclases sepan responder ese mensaje. Supongamos que tenemos
una clase llamada Numero, y dos subclases una llamada Entero y otra Fraccion. Como sabemos tanto los enteros como las fracciones saben sumarse,
ahora la forma en la que se suma un Entero con un Entero o Fraccion, y la forma de que se suma una Fraccion con un Entero o Fraccion es
distinta, por lo tanto, vamos a implementar la suma en sus subclases y no en la superclase. Y si el dia de mañana, quisieramos agregar
otro tipo de Numero, por ejemplo, los complejos, creariamos una subclase Complejo, entonces el mensaje nos obligaria a crear la suma para los
complejos. Basicamente es una forma de no olvidarnos de implementar un mensaje, si es que el mensaje solo sabe ser respondido por sus subclases.

5. Porque si somos capaces de acceder a un colaborador interno de una clase, desde una clase externa, podriamos alterar el valor de dicho
colaborador, eso es conceptualmente incorrecto, porque estamos rompiendo con la responsabilidad de las clases de manejar sus colaboradores
internos. Algunos de los problemas son que puede alterar los tests, si modificamos el valor de un colaborador interno puede hacer o que
fallen tests o que existan tests que pasen. Otro problema puede ser que rompamos con la clase, es decir, que si por ejemplo un colaborador
tiene que ser un numero positivo o cero y nostros por alguna razon lo alteramos ese valor por uno negativo, podriamos romper con el
funcionamiento de la clase.
