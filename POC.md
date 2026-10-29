# Architecture Decision Record: Integración de sensor biométrico

## Contexto
La aplicación muestra las subscripciones de diferentes aplicaciones de un usuario como: youtube, spotify o netflix. Esta información es considerada privada y se debe resguarda con un metodo de seguridad que proporcione el dispositivo.
En este caso, se selecciono el sensor biométrico de huella digital para proteger la informacion critica del usuario en la aplicacion.
Sin embargo, esto introduce un alto riesgo técnico asociado a la dependencia de hardware, el manejo de llamadas hacia el sistema operativo y inexistencia de este hardware en el dispositivo del usuario. Por lo tanto, es viable aisla en una rama del proyecto main para validad la comunicacion antes de acoplarla a la arquitectura del proyecto.

## Decisión 
**Librerias**: Se selecciono el paquete de local_auth para realizar la comunicacion con las APIs biométricas de Android.

**Aislamiento**: Se desarrollo una aislamiento por rama para la prueba de concepto en poc/sensor_biometrico. En esta rama, se reemplazo la información que contenia main.dart en la rama main por una interfaz basica de diagnostico dedica a observar  y probar la respuesta del hardware con el software.

**Mitigacion de Conflictos**: Ante un bloquea de symlinks en Windows y un conflicto de resolucion de dependencias en Gradle que forzaba el uso de una version heredada, se adopto por utilizar la sintaxis clasica de invocacion para garantizar la compilacion y poder testear la reactividad del hardware.

## Consecuencias y Resultados
**Validacion exitosa**: El experimento comprobo que Flutter puede invocar la asincronia del hardware de forma estable. El bloque de try-catch capturo las instancias de PlatformException, permitiendo el manejo de errores controlado.

**Integracion**: El codigo de la PoC se integrara dentro de una clase especializada operando como un singleton exponiendo metodos asincronicos booleando. Esto mantendra la capa de presentacion aislada de las dependencias del hardware.