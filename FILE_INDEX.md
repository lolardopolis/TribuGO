# 📋 Índice Completo de Archivos - TribuGO

## 📱 Archivos Principales

### TribuGOApp.swift
**Ubicación:** `/TribuGOApp.swift`  
**Propósito:** Punto de entrada de la aplicación  
**Descripción:** Define la estructura principal de la app con SwiftUI, gestiona el estado de autenticación y la navegación entre LoginView y MainTabView.

---

## 📊 Models (Modelos de Datos)

### User.swift
**Ubicación:** `/Models/User.swift`  
**Propósito:** Modelo de usuario  
**Contenido:**
- `id: UUID` - Identificador único
- `email: String` - Correo institucional
- `name: String?` - Nombre opcional
- `createdAt: Date` - Fecha de creación

### Trip.swift
**Ubicación:** `/Models/Trip.swift`  
**Propósito:** Modelo de trayecto  
**Contenido:**
- `Trip` - Estructura principal del viaje
- `LocationPoint` - Puntos GPS de la ruta
- `TripStatus` - Enum de estados (en_curso, completado, incidente)
- Métodos calculados: duración, distancia, formateo

### SOSEvent.swift
**Ubicación:** `/Models/SOSEvent.swift`  
**Propósito:** Modelo de evento de emergencia  
**Contenido:**
- `id: UUID` - Identificador del evento
- `tripId: UUID` - Referencia al viaje
- `latitude/longitude: Double` - Coordenadas del SOS
- `timestamp: Date` - Momento del evento
- `notes: String?` - Notas opcionales

---

## 🧠 ViewModels (Lógica de Negocio)

### AuthViewModel.swift
**Ubicación:** `/ViewModels/AuthViewModel.swift`  
**Propósito:** Gestión de autenticación  
**Funcionalidades:**
- Login simulado
- Logout
- Persistencia de sesión en UserDefaults
- Validación básica de credenciales

### TripViewModel.swift
**Ubicación:** `/ViewModels/TripViewModel.swift`  
**Propósito:** Gestión de trayectos  
**Funcionalidades:**
- Iniciar/finalizar trayectos
- Agregar puntos GPS
- Registrar eventos SOS
- Gestionar historial
- Estadísticas (total viajes, distancia, SOS)

### LocationManager.swift
**Ubicación:** `/ViewModels/LocationManager.swift`  
**Propósito:** Gestor de ubicación GPS  
**Funcionalidades:**
- Wrapper de CoreLocation
- Solicitar permisos
- Tracking en tiempo real
- Acumular puntos de ruta
- Manejo de errores de ubicación

---

## 🎨 Views (Interfaces de Usuario)

### Auth/LoginView.swift
**Ubicación:** `/Views/Auth/LoginView.swift`  
**Propósito:** Pantalla de login  
**Características:**
- Diseño con gradiente institucional
- Campos de email y contraseña
- Validación básica
- Mensajes de error
- Nota informativa para prototipo

### MainTabView.swift
**Ubicación:** `/Views/MainTabView.swift`  
**Propósito:** Navegación principal con tabs  
**Tabs:**
1. Inicio (TripStartView)
2. Historial (HistoryView)
3. Perfil (ProfileView)

### Trip/TripStartView.swift
**Ubicación:** `/Views/Trip/TripStartView.swift`  
**Propósito:** Pantalla de inicio de trayecto  
**Características:**
- Mapa de fondo con ubicación actual
- Botón grande "Iniciar Trayecto"
- Información sobre el monitoreo
- Gestión de permisos de ubicación
- Indicadores de estado de permisos

### Trip/ActiveTripView.swift
**Ubicación:** `/Views/Trip/ActiveTripView.swift`  
**Propósito:** Vista de trayecto en curso  
**Características:**
- Mapa con ruta en tiempo real
- Estadísticas del viaje (tiempo, puntos, distancia)
- Botón SOS prominente
- Opciones de finalización (manual/QR)
- Timer de duración
- Sincronización de puntos GPS

### Trip/TripDetailView.swift
**Ubicación:** `/Views/Trip/TripDetailView.swift`  
**Propósito:** Detalle de un trayecto específico  
**Características:**
- Mapa con ruta completa
- Estadísticas detalladas
- Fechas de inicio/fin
- Lista de eventos SOS
- Información técnica (ID, frecuencia tracking)

### History/HistoryView.swift
**Ubicación:** `/Views/History/HistoryView.swift`  
**Propósito:** Historial de trayectos  
**Características:**
- Estadísticas generales (total viajes, distancia, SOS)
- Lista de trayectos con información resumida
- Navegación a detalle de cada viaje
- Estado vacío cuando no hay viajes
- Menú de opciones (exportar, limpiar)

### Profile/ProfileView.swift
**Ubicación:** `/Views/Profile/ProfileView.swift`  
**Propósito:** Perfil de usuario  
**Características:**
- Avatar generado con iniciales
- Información del usuario
- Opciones de configuración
- Opciones de seguridad
- Información de la app
- Cerrar sesión

### Components/MapView.swift
**Ubicación:** `/Views/Components/MapView.swift`  
**Propósito:** Componente reutilizable de mapa  
**Características:**
- Visualización de ubicación actual
- Polyline de ruta recorrida
- Marcador de punto de inicio
- Marcadores de eventos SOS
- Auto-centrado en ubicación actual

### Components/QRScannerView.swift
**Ubicación:** `/Views/Components/QRScannerView.swift`  
**Propósito:** Escáner de código QR  
**Características:**
- Interfaz de escáner visual
- Simulación de escaneo (prototipo)
- Estructura preparada para AVFoundation
- Feedback háptico
- Controles de cámara (flash)

---

## 🔧 Services (Servicios)

### PersistenceController.swift
**Ubicación:** `/Services/PersistenceController.swift`  
**Propósito:** Controlador de persistencia  
**Características:**
- Configuración de Core Data
- Singleton compartido
- Helper para previews
- Método de guardado

---

## 🛠 Utils (Utilidades)

### Constants.swift
**Ubicación:** `/Utils/Constants.swift`  
**Propósito:** Constantes de la aplicación  
**Contenido:**
- App Info (nombre, versión, build)
- Tracking (intervalos, precisión)
- Storage Keys (claves UserDefaults)
- UI (radios, padding, animaciones)
- Map Settings (zoom, grosor líneas)
- Validation (dominios email, contraseñas)
- API (URLs, timeout)
- Feature Flags (debug, background, QR)
- Messages (éxito, error, informativos)
- Notification Names

### Extensions.swift
**Ubicación:** `/Utils/Extensions.swift`  
**Propósito:** Extensiones útiles  
**Extensiones:**
- `Date` - Formateo de fechas
- `String` - Validación email, iniciales
- `Double` - Formateo de distancias
- `View` - Modificadores condicionales
- `TimeInterval` - Formateo de duración
- `Array<LocationPoint>` - Cálculo de distancia
- `CLLocationCoordinate2D` - Validación

### ColorTheme.swift
**Ubicación:** `/Utils/ColorTheme.swift`  
**Propósito:** Tema de colores  
**Contenido:**
- Colores principales (primary, secondary, accent)
- Colores de estado (success, warning, danger)
- Colores de fondo
- Gradientes predefinidos
- Helper para colores hex

### MockData.swift
**Ubicación:** `/Utils/MockData.swift`  
**Propósito:** Datos de prueba  
**Contenido:**
- Usuarios de ejemplo
- Rutas de ejemplo
- Eventos SOS de ejemplo
- Viajes de ejemplo (completados, con incidentes, activos)
- Coordenadas de referencia
- Helpers para generar datos aleatorios
- Extensiones para previews de ViewModels

---

## 🎨 Assets

### Assets.xcassets/
**Ubicación:** `/Assets.xcassets/`  
**Contenido:**
- `AppIcon.appiconset/` - Iconos de la app
- `Contents.json` - Configuración del asset catalog

---

## ⚙️ Configuration

### Info.plist
**Ubicación:** `/Info.plist`  
**Propósito:** Configuración y permisos  
**Contenido:**
- Información de la app (nombre, versión, bundle ID)
- Permisos de ubicación (when in use, always)
- Permiso de cámara (para QR)
- Background modes (location updates)
- Configuración de UI

---

## 📚 Documentation

### README.md
**Ubicación:** `/README.md`  
**Propósito:** Documentación principal del proyecto  
**Contenido:**
- Descripción general
- Características principales
- Tecnologías utilizadas
- Estructura del proyecto
- Instalación y configuración
- Flujo de usuario
- Modelo de datos
- Diseño y UX
- Testing
- Roadmap futuro

### BUILD_GUIDE.md
**Ubicación:** `/BUILD_GUIDE.md`  
**Propósito:** Guía de compilación  
**Contenido:**
- Estructura del proyecto
- Pasos para crear proyecto en Xcode
- Configuración adicional
- Compilar y ejecutar
- Solución de problemas
- Testing del prototipo
- Próximos pasos

### TESTING_GUIDE.md
**Ubicación:** `/TESTING_GUIDE.md`  
**Propósito:** Guía de pruebas de usabilidad  
**Contenido:**
- Casos de uso detallados
- Métricas a observar
- Preguntas post-tarea
- Escenarios de error
- Protocolo de testing
- Criterios de éxito

### PROJECT_SUMMARY.md
**Ubicación:** `/PROJECT_SUMMARY.md`  
**Propósito:** Resumen ejecutivo del proyecto  
**Contenido:**
- Descripción general
- Estructura completa
- Arquitectura MVVM
- Componentes clave
- Diseño y UX
- Almacenamiento
- Permisos
- Roadmap
- Checklist

### XCODE_SETUP.md
**Ubicación:** `/XCODE_SETUP.md`  
**Propósito:** Instrucciones para crear proyecto Xcode  
**Contenido:**
- Crear proyecto nuevo paso a paso
- Organizar estructura
- Agregar archivos
- Configurar Info.plist
- Configurar target
- Solución de problemas
- Checklist de verificación

### FLOW_DIAGRAMS.md
**Ubicación:** `/FLOW_DIAGRAMS.md`  
**Propósito:** Diagramas de flujo de la aplicación  
**Contenido:**
- Flujo principal de la app
- Flujo de inicio de trayecto
- Flujo de trayecto activo
- Flujo de historial
- Flujo de perfil
- Ciclo de vida del trayecto
- Flujo de datos
- Puntos de decisión clave

---

## 📊 Estadísticas del Proyecto

### Archivos por Categoría

```
Models:          3 archivos
ViewModels:      3 archivos
Views:           9 archivos
Services:        1 archivo
Utils:           4 archivos
Configuration:   2 archivos
Documentation:   6 archivos
─────────────────────────────
Total:          28 archivos
```

### Líneas de Código Aproximadas

```
Models:          ~200 líneas
ViewModels:      ~400 líneas
Views:          ~1500 líneas
Services:        ~50 líneas
Utils:          ~400 líneas
─────────────────────────────
Total Swift:   ~2550 líneas
```

---

## 🗂 Organización Recomendada en Xcode

```
TribuGO (Project)
├── 📱 TribuGOApp.swift
├── 📊 Models
│   ├── User.swift
│   ├── Trip.swift
│   └── SOSEvent.swift
├── 🧠 ViewModels
│   ├── AuthViewModel.swift
│   ├── TripViewModel.swift
│   └── LocationManager.swift
├── 🎨 Views
│   ├── Auth
│   │   └── LoginView.swift
│   ├── Trip
│   │   ├── TripStartView.swift
│   │   ├── ActiveTripView.swift
│   │   └── TripDetailView.swift
│   ├── History
│   │   └── HistoryView.swift
│   ├── Profile
│   │   └── ProfileView.swift
│   ├── Components
│   │   ├── MapView.swift
│   │   └── QRScannerView.swift
│   └── MainTabView.swift
├── 🔧 Services
│   └── PersistenceController.swift
├── 🛠 Utils
│   ├── Constants.swift
│   ├── Extensions.swift
│   ├── ColorTheme.swift
│   └── MockData.swift
├── 🎨 Assets.xcassets
└── ⚙️ Info.plist
```

---

## 🔍 Búsqueda Rápida

### Por Funcionalidad

**Autenticación:**
- `AuthViewModel.swift`
- `LoginView.swift`

**Trayectos:**
- `TripViewModel.swift`
- `TripStartView.swift`
- `ActiveTripView.swift`
- `TripDetailView.swift`

**Ubicación GPS:**
- `LocationManager.swift`
- `MapView.swift`

**Emergencias:**
- `SOSEvent.swift`
- Botón SOS en `ActiveTripView.swift`

**Historial:**
- `HistoryView.swift`
- `TripDetailView.swift`

**Perfil:**
- `ProfileView.swift`

**QR:**
- `QRScannerView.swift`

---

## 📝 Notas Importantes

1. **Todos los archivos Swift** están listos para ser agregados a un proyecto Xcode
2. **La documentación** está completa y actualizada
3. **Los datos de prueba** están disponibles en `MockData.swift`
4. **Las constantes** están centralizadas en `Constants.swift`
5. **El tema visual** está definido en `ColorTheme.swift`

---

**Última actualización:** Diciembre 2025  
**Versión del proyecto:** 1.0.0 (Prototipo)  
**Estado:** ✅ Completo y listo para compilar
