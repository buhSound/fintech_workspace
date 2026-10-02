# Maqueta Funcional: Fintech Workspace

Maqueta funcional móvil desarrollada para el sector financiero, orientada a la gestion de subscripciones de aplicaciones.

## Arquitectura del Software y Explicación de Decisiones Técnicas
* **Framework:** Flutter. Fue utilizada por su capacidad de renderizar a 60 FPS, permitiendo compilar interfaces de alta fidelidad desde un unico código base.
* **Paradigma:** Programación Orientada a Objetos. Se utilizaron clases inmutables para proteger la integridad de los datos financieros del usuario.
* **Patrón de Navegación:** Master-Detail. La lista y el detalle dentro del modelo, se comunican pasando instancias tipadas en memoria, evitando acoplamientos.

## Estructura de los Archivos

* 'domain/models': Contiene la lógica de la aplicacion
* 'ui/screens': Vistas principales del flujo
* 'ui/widgets': Componentes reutilizables
* 'ui/theme': Identidad Visual

# Presentación Software

* **Link:** https://youtu.be/tnGEbksoXHI