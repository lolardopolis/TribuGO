# TribuGO - Guía de Compilación

## Estructura del Proyecto

El proyecto TribuGO está organizado de la siguiente manera:

```
TribuGO/
├── TribuGOApp.swift           # Punto de entrada de la app
├── Info.plist                 # Configuración y permisos
├── Models/                    # Modelos de datos
│   ├── User.swift
│   ├── Trip.swift
│   └── SOSEvent.swift
├── ViewModels/                # Lógica de negocio
│   ├── AuthViewModel.swift
│   ├── TripViewModel.swift
│   └── LocationManager.swift
├── Views/                     # Interfaces de usuario
│   ├── Auth/
│   │   └── LoginView.swift
│   ├── Trip/
│   │   ├── TripStartView.swift
│   │   ├── ActiveTripView.swift
│   │   └── TripDetailView.swift
│   ├── History/
│   │   └── HistoryView.swift
│   ├── Profile/
│   │   └── ProfileView.swift
│   ├── Components/
│   │   ├── MapView.swift
│   │   └── QRScannerView.swift
│   └── MainTabView.swift
└── Services/
    └── PersistenceController.swift
```

## Pasos para Crear el Proyecto en Xcode

### Opción 1: Crear Proyecto Nuevo (Recomendado)

1. **Abrir Xcode** (versión 15.0 o superior)

2. **Crear nuevo proyecto:**
   - File → New → Project
   - Seleccionar "iOS" → "App"
   - Click "Next"

3. **Configurar el proyecto:**
   - Product Name: `TribuGO`
   - Team: Selecciona tu equipo de desarrollo
   - Organization Identifier: `com.tuorganizacion` (o el que prefieras)
   - Interface: **SwiftUI**
   - Language: **Swift**
   - Storage: **Core Data** (opcional, pero recomendado)
   - Click "Next"

4. **Guardar el proyecto:**
   - Selecciona la ubicación donde quieres guardar
   - Click "Create"

5. **Copiar archivos:**
   - Elimina el archivo `ContentView.swift` que Xcode crea por defecto
   - Copia todos los archivos de este directorio al proyecto de Xcode
   - Asegúrate de mantener la estructura de carpetas

6. **Agregar Info.plist:**
   - Reemplaza el Info.plist generado con el proporcionado
   - O agrega manualmente las claves de permisos

### Opción 2: Usar Proyecto Existente

Si ya tienes un proyecto Xcode:

1. Abre el proyecto en Xcode
2. Arrastra las carpetas al navegador de proyectos
3. Asegúrate de seleccionar "Copy items if needed"
4. Verifica que todos los archivos estén en el target

## Configuración Adicional

### 1. Permisos en Info.plist

Asegúrate de que el archivo `Info.plist` contenga:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>TribuGO necesita acceso a tu ubicación para monitorear tu trayecto</string>

<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>TribuGO necesita acceso continuo a tu ubicación para tu seguridad</string>

<key>NSCameraUsageDescription</key>
<string>TribuGO necesita la cámara para escanear códigos QR</string>

<key>UIBackgroundModes</key>
<array>
    <string>location</string>
</array>
```

### 2. Capabilities

En Xcode:
1. Selecciona el target "TribuGO"
2. Ve a "Signing & Capabilities"
3. Agrega "Background Modes"
4. Marca "Location updates"

### 3. Deployment Target

- Minimum iOS Version: **16.0**
- Supported Devices: **iPhone**

## Compilar y Ejecutar

### En Simulador

1. Selecciona un simulador de iPhone (ej: iPhone 15 Pro)
2. Presiona `⌘ + R` o click en el botón "Run"
3. La app se compilará e iniciará en el simulador

**Nota:** El GPS en el simulador es limitado. Para simular ubicación:
- Debug → Simulate Location → Selecciona una ubicación

### En Dispositivo Físico

1. Conecta tu iPhone
2. Selecciona tu dispositivo en la lista de destinos
3. Asegúrate de tener un certificado de desarrollo válido
4. Presiona `⌘ + R`

**Importante:** Para testing de GPS real, usa un dispositivo físico.

## Solución de Problemas Comunes

### Error: "Cannot find 'MainTabView' in scope"

**Solución:** Asegúrate de que todos los archivos de Views estén agregados al target.

### Error de permisos de ubicación

**Solución:** Verifica que Info.plist tenga las claves correctas y que hayas aceptado los permisos en el dispositivo.

### Error: "PersistenceController not found"

**Solución:** Asegúrate de que `Services/PersistenceController.swift` esté en el proyecto.

### La app no compila

**Solución:** 
1. Limpia el build: `⌘ + Shift + K`
2. Limpia la carpeta DerivedData: `⌘ + Shift + Option + K`
3. Vuelve a compilar: `⌘ + R`

## Testing del Prototipo

### 1. Login
- Email: `estudiante@universidad.edu` (o cualquier email)
- Contraseña: cualquier texto

### 2. Iniciar Trayecto
- Acepta permisos de ubicación
- Click en "Iniciar Trayecto al Campus"

### 3. Durante el Trayecto
- Observa el mapa actualizándose
- Prueba el botón SOS
- Simula movimiento (en simulador: Debug → Simulate Location)

### 4. Finalizar Trayecto
- Click en "He llegado" o "Escanear QR"
- Verifica que aparezca en el historial

### 5. Historial
- Ve al tab "Historial"
- Click en un viaje para ver detalles
- Observa el mapa con la ruta completa

## Próximos Pasos

Para llevar este prototipo a producción:

1. **Backend Real:**
   - Implementar API REST o GraphQL
   - Usar Firebase, Supabase o servidor custom

2. **Autenticación Real:**
   - Integrar con SSO institucional
   - OAuth 2.0 / SAML

3. **Notificaciones Push:**
   - Configurar APNs
   - Alertas en tiempo real para SOS

4. **Optimización GPS:**
   - Mejorar tracking en background
   - Reducir consumo de batería

5. **Dashboard Web:**
   - Panel para administradores
   - Visualización de mapas de calor
   - Gestión de incidentes

## Recursos

- [Documentación de SwiftUI](https://developer.apple.com/documentation/swiftui/)
- [Core Location Guide](https://developer.apple.com/documentation/corelocation)
- [MapKit Documentation](https://developer.apple.com/documentation/mapkit)

---

**¿Necesitas ayuda?** Revisa el README.md principal para más información sobre la arquitectura y funcionalidades.
