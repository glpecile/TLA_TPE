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