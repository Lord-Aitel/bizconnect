# BizConnect

##  Descripción del Proyecto
BizConnect es una maqueta funcional desarrollada en Flutter que busca digitalizar flujos de negocio locales (PYMES de Futrono y Valdivia).  
El objetivo es ofrecer una aplicación móvil que permita visualizar productos, acceder a detalles y gestionar información de manera simple y escalable.

##  Características propias del móvil
- Interfaz modular y adaptable a distintos tamaños de pantalla.
- Navegación jerárquica mediante **Splash → Drawer → Lista → Detalle → About**.
- Uso de `ThemeData` global para identidad visual coherente.
- Inclusión de imágenes y datos reales (ej. Café de Futrono, Miel de Valdivia).
- Flujo optimizado para interacción táctil y navegación intuitiva.

##  Requerimientos

### Historias de Usuario
- Como **cliente**, quiero ver una lista de productos, para decidir qué comprar.  
- Como **usuario**, quiero acceder al detalle de un producto, para conocer sus características.  
- Como **cliente**, quiero navegar fácilmente entre secciones, para encontrar información relevante.  
- Como **usuario**, quiero ver una pantalla inicial (Splash), para identificar la aplicación antes de usarla.  
- Como **usuario**, quiero acceder a una pantalla informativa (About), para conocer el propósito de la aplicación y el equipo de desarrollo.  

### Requerimientos Funcionales (RF)
1. RF1: Implementar pantalla de acceso (SplashScreen).  
2. RF2: Implementar menú de navegación (Drawer).  
3. RF3: Implementar lista de productos con datos reales.  
4. RF4: Implementar vista de detalle con parámetros.  
5. RF5: Configurar rutas y navegación entre pantallas.  
6. RF6: Implementar pantalla informativa (About).  

### Requerimientos No Funcionales (RNF)
1. RNF1: Arquitectura modular con separación de vistas, modelos y widgets.  
2. RNF2: Identidad visual centralizada mediante `ThemeData`.  
3. RNF3: Uso de imágenes y textos coherentes con el contexto local.  
4. RNF4: Historial de commits atómicos y descriptivos en Git.  
5. RNF5: Flujo adaptable a distintos dispositivos móviles.  

diagrama secuencia
    actor Usuario
    participant UI as Flutter UI
    participant Dominio as Lógica de Negocio
    participant Datos as Firebase

    Usuario->>UI: Selecciona Local
    UI->>Dominio: Solicita productos del Local
    Dominio->>Datos: Consulta colección productos
    Datos-->>Dominio: Retorna lista (éxito/error)
    Dominio-->>UI: Procesa respuesta
    UI-->>Usuario: Muestra productos o mensaje de error

Diagrama estado
    [*] --> Idle

    Idle --> Loading: Usuario solicita productos
    Loading --> ErrorConexion: Sin conexión a internet
    Loading --> MostrandoProductos: Datos recibidos correctamente

    ErrorConexion --> Reintento: Usuario pulsa "Reintentar"
    Reintento --> Loading

    ErrorConexion --> [*]: Usuario cierra la app
    MostrandoProductos --> [*]: Usuario navega a otra pantalla

