# TribuGO - Resumen del Proyecto

## 🎯 Descripción General

**TribuGO** es un prototipo funcional de iOS para un Sistema de Seguridad y Trazabilidad Integral de Trayectos, diseñado para que universidades y empresas puedan monitorear los desplazamientos de estudiantes y funcionarios hacia el campus.

### Características Principales
- ✅ Autenticación institucional simulada
- ✅ Inicio y finalización de trayectos
- ✅ Monitoreo GPS en tiempo real
- ✅ Botón SOS de emergencia
- ✅ Historial completo de viajes
- ✅ Visualización de rutas en mapa
- ✅ Escáner QR (simulado)

---

## 📁 Estructura Completa del Proyecto

```
TribuGO/
│
├── 📱 App Entry Point
│   └── TribuGOApp.swift                    # Punto de entrada principal
│
├── 📊 Models (Modelos de Datos)
│   ├── User.swift                          # Modelo de usuario
│   ├── Trip.swift                          # Modelo de trayecto
│   └── SOSEvent.swift                      # Modelo de evento SOS
│
├── 🧠 ViewModels (Lógica de Negocio)
│   ├── AuthViewModel.swift                 # Autenticación
│   ├── TripViewModel.swift                 # Gestión de trayectos
│   └── LocationManager.swift               # Gestor de ubicación GPS
│
├── 🎨 Views (Interfaces de Usuario)
│   ├── Auth/
│   │   └── LoginView.swift                 # Pantalla de login
│   │
│   ├── Trip/
│   │   ├── TripStartView.swift             # Inicio de trayecto
│   │   ├── ActiveTripView.swift            # Trayecto en curso
│   │   └── TripDetailView.swift            # Detalle de trayecto
│   │
│   ├── History/
│   │   └── HistoryView.swift               # Historial de viajes
│   │
│   ├── Profile/
│   │   └── ProfileView.swift               # Perfil de usuario
│   │
│   ├── Components/
│   │   ├── MapView.swift                   # Componente de mapa
│   │   └── QRScannerView.swift             # Escáner QR
│   │
│   └── MainTabView.swift                   # Navegación principal
│
├── 🔧 Services (Servicios)
│   └── PersistenceController.swift         # Controlador Core Data
│
├── 🛠 Utils (Utilidades)
│   ├── Constants.swift                     # Constantes de la app
│   ├── Extensions.swift                    # Extensiones útiles
│   ├── ColorTheme.swift                    # Tema de colores
│   └── MockData.swift                      # Datos de prueba
│
├── 🎨 Assets
│   └── Assets.xcassets/
│       ├── AppIcon.appiconset/
│       └── Contents.json
│
├── ⚙️ Configuration
│   └── Info.plist                          # Permisos y configuración
│
└── 📚 Documentation
    ├── README.md                           # Documentación principal
    ├── BUILD_GUIDE.md                      # Guía de compilación
    └── TESTING_GUIDE.md                    # Guía de pruebas de usabilidad
```

---

## 🔄 Flujo de la Aplicación

### 1. Autenticación
```
LoginView → AuthViewModel → MainTabView
```

### 2. Inicio de Trayecto
```
TripStartView → Permisos GPS → ActiveTripView
```

### 3. Trayecto Activo
```
ActiveTripView → LocationManager → Tracking GPS
                ↓
              Botón SOS → SOSEvent
                ↓
         Finalizar → TripViewModel → Historial
```

### 4. Historial
```
HistoryView → Lista de Trips → TripDetailView
```

---

## 🏗 Arquitectura

### Patrón: MVVM (Model-View-ViewModel)

```
┌─────────────┐
│    Views    │ ← SwiftUI Views (UI)
└──────┬──────┘
       │ Observa
       ↓
┌─────────────┐
│ ViewModels  │ ← Lógica de negocio (@Published)
└──────┬──────┘
       │ Usa
       ↓
┌─────────────┐
│   Models    │ ← Estructuras de datos
└─────────────┘
```

### Flujo de Datos

```
User Input → View → ViewModel → Model → Storage
                                   ↓
                            LocationManager
                                   ↓
                              CoreLocation
```

---

## 🔑 Componentes Clave

### 1. AuthViewModel
- Gestiona autenticación simulada
- Almacena usuario actual en UserDefaults
- Maneja login/logout

### 2. TripViewModel
- Gestiona trayectos (crear, finalizar, historial)
- Registra eventos SOS
- Persiste datos en UserDefaults

### 3. LocationManager
- Wrapper de CoreLocation
- Tracking GPS en tiempo real
- Gestión de permisos
- Acumula puntos de ruta

### 4. MapView
- Visualización de rutas en MapKit
- Marcadores de inicio, actual, y SOS
- Polyline de ruta recorrida

---

## 📦 Dependencias

### Frameworks de iOS
- **SwiftUI**: Interfaz de usuario
- **CoreLocation**: GPS y ubicación
- **MapKit**: Visualización de mapas
- **AVFoundation**: Cámara para QR (preparado)
- **CoreData**: Persistencia (preparado)

### Sin Dependencias Externas
El proyecto no requiere CocoaPods, SPM ni Carthage para el prototipo.

---

## 🎨 Diseño y UX

### Paleta de Colores
- **Primary**: Azul (#007AFF)
- **Secondary**: Púrpura
- **Success**: Verde
- **Warning**: Naranja
- **Danger**: Rojo (SOS)

### Principios de Diseño
1. **Claridad**: Funciones críticas (SOS) son prominentes
2. **Confianza**: Diseño institucional profesional
3. **Simplicidad**: Flujos directos sin fricción
4. **Seguridad**: Feedback constante del estado

---

## 💾 Almacenamiento de Datos

### UserDefaults (Prototipo)
```swift
- TribuGO_CurrentUser      → User actual
- TribuGO_CurrentTrip      → Trayecto activo
- TribuGO_Trips            → Historial de viajes
```

### Core Data (Preparado para Producción)
- Estructura lista en PersistenceController
- No implementado en prototipo por simplicidad

---

## 🔒 Permisos Requeridos

### Info.plist
```xml
NSLocationWhenInUseUsageDescription
NSLocationAlwaysAndWhenInUseUsageDescription
NSCameraUsageDescription
UIBackgroundModes: location
```

---

## 🧪 Testing

### Datos de Prueba
- MockData.swift proporciona usuarios, rutas y viajes de ejemplo
- Helpers para generar datos aleatorios
- ViewModels con extensiones .preview

### Escenarios de Prueba
Ver `TESTING_GUIDE.md` para casos de uso detallados

---

## 🚀 Próximos Pasos (Post-Prototipo)

### Fase 2: Backend
- [ ] API REST/GraphQL
- [ ] Base de datos real (PostgreSQL/MongoDB)
- [ ] Autenticación OAuth 2.0
- [ ] WebSockets para tiempo real

### Fase 3: Features Avanzadas
- [ ] Notificaciones Push
- [ ] Tracking optimizado en background
- [ ] Dashboard web para administradores
- [ ] Análisis de datos y mapas de calor

### Fase 4: Carpooling
- [ ] Matching de usuarios
- [ ] Chat en tiempo real
- [ ] Sistema de reputación
- [ ] Verificación de identidad

---

## 📊 Métricas de Éxito

### Técnicas
- ✅ Tracking GPS cada 5-10 segundos
- ✅ Precisión de ubicación: kCLLocationAccuracyBest
- ✅ Tiempo de respuesta SOS: < 3 segundos
- ✅ Persistencia de datos: 100% confiable

### UX
- 🎯 80% de usuarios completan flujo sin ayuda
- 🎯 90% entienden el concepto de monitoreo
- 🎯 100% pueden activar SOS rápidamente
- 🎯 Satisfacción promedio ≥ 4/5

---

## 👥 Roles y Responsabilidades

### Para este Prototipo
- **Usuario Final**: Estudiante/funcionario (app iOS)
- **Administrador**: Concepto (dashboard futuro)

### Para Producción
- **Usuario Final**: App iOS + Android
- **Administrador**: Dashboard web
- **Conductor Verificado**: App especializada (futuro)
- **Soporte**: Panel de gestión de incidentes

---

## 🔐 Consideraciones de Seguridad

### Prototipo (Actual)
- ⚠️ Login simulado (sin validación real)
- ⚠️ Datos en local (UserDefaults)
- ⚠️ Sin encriptación
- ⚠️ Sin transmisión a servidor

### Producción (Requerido)
- ✅ Autenticación SSO institucional
- ✅ Encriptación end-to-end
- ✅ HTTPS/SSL para comunicación
- ✅ Cumplimiento GDPR/LOPD
- ✅ Anonimización de datos sensibles
- ✅ Auditoría de accesos

---

## 📱 Requisitos del Sistema

### Mínimos
- iOS 16.0+
- iPhone (optimizado para iPhone)
- GPS habilitado
- 50 MB de espacio

### Recomendados
- iOS 17.0+
- iPhone 12 o superior
- Conexión a internet (para futuro)

---

## 🐛 Problemas Conocidos (Prototipo)

1. **Tracking en Background**: Limitado en simulador
2. **QR Scanner**: Simulado (no usa cámara real)
3. **Notificaciones**: No implementadas
4. **Optimización Batería**: Básica

---

## 📞 Soporte y Contacto

Para preguntas sobre implementación:
- Revisar `README.md` para documentación completa
- Revisar `BUILD_GUIDE.md` para compilación
- Revisar `TESTING_GUIDE.md` para pruebas

---

## 📄 Licencia

Prototipo educativo - Todos los derechos reservados

---

## ✅ Checklist de Implementación

- [x] Modelos de datos (User, Trip, SOSEvent)
- [x] ViewModels (Auth, Trip, Location)
- [x] Vistas principales (Login, Start, Active, History, Profile)
- [x] Componentes (Map, QR Scanner)
- [x] Servicios (Persistence)
- [x] Utilidades (Constants, Extensions, Theme, MockData)
- [x] Configuración (Info.plist, Assets)
- [x] Documentación (README, BUILD_GUIDE, TESTING_GUIDE)

---

**Versión**: 1.0.0 (Prototipo)  
**Última actualización**: Diciembre 2025  
**Estado**: ✅ Listo para pruebas de usabilidad
