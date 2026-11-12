# Merxsell - Fintech Wokspace

Aplicación móvil multiplataforma desarrollada en flutter enfocada en la gestión de suscripciones financieras. 

---
## 1. Arquitectura de la Solución (MVVM) 

*  **Views (UI):** Consumen los datos del ViewModel en tiempo real reaccionando a los cambios del estado del sistema. 
*  **ViewModels:** Actúan como intermediarios. Procesan las intenciones del usuario, orquestan las llamadas a los servicios y exponen el estado actualizado mediante `ChangeNotifier`. 
*  **Services / Repositories:** Capa de abstracción encargada de interactuar con el ecosistema nativo (hardware, intents) y las bases de datos locales. 

## 2. Funcionamiento del Login Dentro del Sistema 
    User->>UI: Solicita Ingreso con Huella
    UI->>VM: authenticate()
    VM->>OS: Invoca Biometric Prompt API
    
    alt Huella Correcta
        OS-->>VM: Success (True)
        VM-->>UI: Cambia Estado (isAuthenticated)
        UI->>User: Redirige a MasterListScreen
    else Huella Incorrecta / Cancelado
        OS-->>VM: Failure (False)
        VM-->>UI: Emite Error
        UI->>User: Muestra SnackBar (Fallback manual hablitado)
    end

## 3. Conclusiones del Reporte QA
Después de compilar la versión v1.0 de Merxsell y ejecutar pruebas en un dispositivo físico, se obtuvieron los siguientes resultados.
* Autenticación Biométrica: Exitoso. el sistema del servicio demostró ser robusta. Se valido correctamente el flujo de fallback para entornos sin sensores.
* Persistencia: Exitoso. Dividir la persistencia es la mejor decisión de la arquitectura: el uso de `flutter_secure_storage` resolvió la retención de tokens. mientra que `Hive`(Base de datos NoSQL) ofreció tiempo de lecturas inmediatos.
* Comunicacion `share_plus`: Exitoso. El diseño del sistema de evaluación empaquetado en JSON es renderizado dinámicamente y los resultados se exportan a través del ecosistema del dispositivo exitosamente. Android es capaz de abrir Share Sheet permitiendo compartir el feedback.
---
## Uno de los Muchos Resultados de la Encuesta por un Usuario Anónimo 
    📋 Feedback de Evaluación - Fintech Workspace
    
    --- CUMPLIMIENTO HU ---
    Pregunta 1: ¿Qué tan fácil fue completar el flujo principal de tu solución en la aplicación?
    ⭐ Puntuación: 5/5
    
    Pregunta 2: ¿El servicio móvil o hardware integrado respondió adecuadamente durante la prueba?
    ⭐ Puntuación: 5/5
    
    --- USABILIDAD ---
    Pregunta 3: ¿Cómo calificas la navegación y claridad visual de la interfaz gráfica?
    ⭐ Puntuación: 5/5
    
    Pregunta 4: ¿La información y configuraciones persistieron correctamente al reabrir la app?
    ⭐ Puntuación: 5/5
    
    --- VALORACION GENERAL ---
    Pregunta 5: ¿El contenido y utilidad de la aplicación cumplieron con tus expectativas?
    ⭐ Puntuación: 5/5

    Pregunta 6: ¿Qué tan probable es que recomiendes esta aplicación a otros usuarios?
    ⭐ Puntuación: 5/5

Link apk: https://github.com/buhSound/fintech_workspace/releases/download/v1.0/merxsell-v1.0.apk
