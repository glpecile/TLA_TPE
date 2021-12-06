# TPE TLA - Program**AR**
Trabajo Practico Especial de la materia 72.39 - Autómatas, Teoría de Lenguajes y Compiladores - Segundo Cuatrimestre 2021

![Logo_pill](resources/images/ProgramAR%20Logo%20Pill.png)

## Autores

- [Julián Arce](https://github.com/juarce)
- [Gastón De Shant](https://github.com/GastonDeS)
- [Paula Domingues](https://github.com/pdomins)
- [Gian Luca Pecile](https://github.com/glpecile)

## Objetivo

El objetivo del TPE es la implementación de un lenguaje en español con fines didacticos
para proponer buenas prácticas de programación desde cualquier edad y con cualquier nivel de
conocimiento de programación.

## Compilación

La compilación se realiza con el siguiente comando:

```bash
make
```

## Ejecutable y archivos

Para generar el archivo ejecutable es necesario contar con un archivo `*.ar` y proceder con el siguiente comando:

```bash
./programAR.sh <arhivo.ar> <nombre del ejecutable>
```

El archivo generado se encontrará en el mismo directorio y tendrá el
nombre provisto. El flujo de la creación del ejecutable es el siguiente:

![flow_diagram](resources/images/ProgramAR%20Flow%20Diagram.png)

Luego se puede encontrar en el directorio `resources/docs`
el archivo [`informeProgramAR.pdf`](/resources/docs/informeProgramAR.pdf).

## Ejecución

Por ultimo, para ejecutar el archivo creado anteriormente, basta con:

```bash
./<nombre del ejecutable>
```

## Limpieza

La limpieza de los archivos generados se realiza con el siguiente comando:

```bash
make clean
```

## Testeos

En el directorio [`tests`](/tests) se encuentran los ejemplos de uso con su funcionalidad esperada detallada en el informe. 
Para generar los archivos de tests necesarios se utiliza -luego de haber compilado con ```make```- el siguiente comando:

```bash
make test
```
La limpieza de los archivos generados se realiza con el siguiente comando:

```bash
make clean_test
```

# Correciones

* Informe: El informe está correcto y están bien expresadas las ideas del trabajo.
* Implementación: El programa les quedó un "homomorfismo" con C.  Si se fijan en el .y prácticamente para cada acción semántica están imprimiendo por salida una traducción directa a C.  Este es el riesgo de ir por el lado de generar un lenguaje de alto nivel como salida, que se hace difícil alejarse de la propia gramática del lenguaje target.  Adecuada la implementación de la tabla de símbolos.
* Cumplimiento:  Cumplieron con todos los objetivos planteados en el TPE.
* Calidad:  La calidad es buena.  El compilador compila muy bien, y se pueden ejecutar todos los tests que armaron.
* +Alpha:  Este punto me constó encontrar qué es exactamente lo distintivo o extra.  No me queda clara la idea en los códigos .ar de "contratos" con pre-clausulas, ejecución y postalidaciones.  Por ahí podían haber explotado más esa idea.

El trabajo está aprobado y la nota es un **7 (siete)**.
