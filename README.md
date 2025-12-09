# TribuGO - Sistema de Seguridad y Trazabilidad Integral de Trayectos

## 📱 Descripción

TribuGO es una aplicación iOS que permite a universidades y empresas monitorear y registrar los trayectos de estudiantes y funcionarios desde que salen hacia el campus hasta que ingresan, con foco en:

- **Seguridad del usuario**: Monitoreo GPS en tiempo real
- **Trazabilidad del viaje**: Registro completo de rutas
- **Botón SOS**: Alertas de emergencia instantáneas
- **Confianza**: Sistema institucional verificado

## 🎯 Características Principales

### Para el Usuario Final

1. **Autenticación Institucional**
   - Login con correo institucional
   - Simulación de SSO para prototipo

2. **Gestión de Trayectos**
   - Inicio de trayecto con un toque
   - Monitoreo GPS en tiempo real
   - Visualización de ruta en mapa
   - Cierre de trayecto (manual o con QR)

3. **Seguridad**
   - Botón SOS visible durante el trayecto
   - Registro de incidentes con ubicación exacta
   - Alertas a la institución

4. **Historial**
   - Lista de todos los trayectos realizados
   - Visualización de rutas en mapa
   - Detalles de duración y estado
   - Registro de incidentes SOS

## 🛠 Tecnologías Utilizadas

- **Lenguaje**: Swift 5.9+
- **UI Framework**: SwiftUI
- **Mapas**: MapKit (Apple Maps)
- **Localización**: CoreLocation
- **Persistencia**: Core Data
- **Mínimo iOS**: 16.0+

## 📂 Estructura del Proyecto

```
TribuGO/
├── Models/
│   ├── User.swift              # Modelo de usuario
│   ├── Trip.swift              # Modelo de trayecto
│   └── SOSEvent.swift          # Modelo de evento SOS
├── Views/
│   ├── Auth/
│   │   └── LoginView.swift     # Pantalla de login
│   ├── Trip/
│   │   ├── TripStartView.swift # Inicio de trayecto
│   │   ├── ActiveTripView.swift # Trayecto en curso
│   │   └── TripDetailView.swift # Detalle de trayecto
│   ├── History/
│   │   └── HistoryView.swift   # Historial de viajes
│   └── Components/
│       ├── MapView.swift       # Vista de mapa
│       └── SOSButton.swift     # Botón de emergencia
├── ViewModels/
│   ├── AuthViewModel.swift     # Lógica de autenticación
│   ├── TripViewModel.swift     # Lógica de trayectos
│   └── LocationManager.swift   # Gestor de ubicación
├── Services/
│   ├── PersistenceController.swift # Core Data
│   └── QRScannerService.swift  # Escáner QR
└── TribuGOApp.swift            # Punto de entrada

```

## 🚀 Instalación y Configuración

### Requisitos Previos

- Xcode 15.0 o superior
- macOS Sonoma o superior
- Dispositivo iOS 16.0+ o simulador

### Pasos de Instalación

1. **Clonar o abrir el proyecto**
   ```bash
   cd TribuGO
   open TribuGO.xcodeproj
   ```

2. **Configurar permisos en Info.plist**
   - Ya están incluidos en el proyecto:
     - `NSLocationWhenInUseUsageDescription`
     - `NSLocationAlwaysAndWhenInUseUsageDescription`
     - `NSCameraUsageDescription`

3. **Ejecutar en simulador o dispositivo**
   - Seleccionar target (iPhone)
   - Presionar ⌘ + R para compilar y ejecutar

### Credenciales de Prueba

Para el prototipo, puedes usar cualquier correo institucional:
- **Email**: `estudiante@universidad.edu`
- **Contraseña**: `cualquier_texto`

## 📱 Flujo de Usuario

### 1. Login
- Ingresar correo institucional
- Contraseña (simulada, cualquier texto funciona)
- Acceso a pantalla principal

### 2. Iniciar Trayecto
- Presionar botón "Iniciar Trayecto al Campus"
- Otorgar permisos de ubicación si es necesario
- El tracking GPS comienza automáticamente

### 3. Durante el Trayecto
- Ver posición actual en mapa
- Tiempo transcurrido
- Botón SOS siempre visible
- Puntos GPS registrados cada 5 segundos

### 4. Emergencia (Opcional)
- Presionar botón SOS
- Se registra ubicación exacta del incidente
- Alerta simulada a la institución

### 5. Finalizar Trayecto
- **Opción A**: Presionar "He llegado al campus"
- **Opción B**: Escanear código QR del campus
- El trayecto se guarda en el historial

### 6. Historial
- Ver lista de todos los trayectos
- Entrar a detalle para ver ruta en mapa
- Identificar viajes con incidentes SOS

## 🗄 Modelo de Datos

### User
```swift
{
  id: UUID
  email: String
  name: String?
  createdAt: Date
}
```

### Trip
```swift
{
  id: UUID
  userId: UUID
  startTime: Date
  endTime: Date?
  status: String // "en_curso", "completado", "incidente"
  points: [LocationPoint]
  sosEvents: [SOSEvent]?
}
```

### LocationPoint
```swift
{
  latitude: Double
  longitude: Double
  timestamp: Date
}
```

### SOSEvent
```swift
{
  latitude: Double
  longitude: Double
  timestamp: Date
  tripId: UUID
}
```

## 🎨 Diseño y UX

- **Colores**: Azul institucional (#007AFF), Rojo para SOS (#FF3B30)
- **Tipografía**: SF Pro (sistema iOS)
- **Iconografía**: SF Symbols
- **Diseño**: Minimalista, enfocado en seguridad y claridad

## 🔒 Privacidad y Seguridad

### Para el Prototipo
- Datos almacenados localmente en Core Data
- No hay transmisión a servidor real
- Login simulado (sin validación real)

### Para Producción (Futuro)
- Encriptación end-to-end
- Servidor seguro con SSL
- Autenticación OAuth 2.0 / SAML
- Cumplimiento GDPR/LOPD
- Anonimización de datos sensibles

## 🧪 Testing

### Escenarios de Prueba

1. **Login exitoso**
   - Ingresar email institucional
   - Verificar acceso a pantalla principal

2. **Inicio de trayecto**
   - Verificar permisos de ubicación
   - Confirmar que el mapa muestra posición actual

3. **Tracking GPS**
   - Mover el dispositivo/simulador
   - Verificar que se registran puntos

4. **Botón SOS**
   - Presionar durante trayecto activo
   - Verificar alerta y registro

5. **Finalización**
   - Cerrar trayecto manualmente
   - Verificar que aparece en historial

6. **Historial**
   - Ver lista de viajes
   - Abrir detalle y verificar mapa de ruta

## 📊 Datos para Dashboard B2B (Futuro)

La app está preparada para enviar estos datos a un dashboard administrativo:

- **Mapas de calor**: Rutas más frecuentes
- **Incidentes**: Ubicación y frecuencia de SOS
- **Estadísticas**: Tiempo promedio, distancias
- **Usuarios activos**: Quién está en trayecto ahora
- **Alertas**: Notificaciones de SOS en tiempo real

## 🚧 Limitaciones del Prototipo

- **No hay backend real**: Datos solo en local
- **Login simulado**: No valida credenciales reales
- **Sin notificaciones push**: SOS solo registra localmente
- **Tracking básico**: Funciona mejor con app abierta
- **Sin carpooling**: Preparado para futuras versiones

## 🔮 Roadmap Futuro

### Fase 2
- [ ] Backend real (Firebase/Supabase)
- [ ] Dashboard web para administradores
- [ ] Notificaciones push para SOS
- [ ] Tracking en segundo plano optimizado

### Fase 3
- [ ] Matching de carpooling
- [ ] Chat entre usuarios del mismo viaje
- [ ] Verificación de identidad con foto
- [ ] Calificaciones y reputación

### Fase 4
- [ ] Integración con sistemas de acceso físico
- [ ] Análisis predictivo de rutas
- [ ] Gamificación (puntos por viajes compartidos)
- [ ] App para conductores verificados

## 👥 Contribución

Este es un prototipo para pruebas de usabilidad. Para contribuir:

1. Probar la app con usuarios reales
2. Documentar feedback de UX
3. Reportar bugs o comportamientos inesperados
4. Sugerir mejoras de seguridad

## 📄 Licencia

Prototipo educativo - Todos los derechos reservados

## 📞 Contacto

Para preguntas sobre el proyecto o implementación en tu institución, contacta al equipo de desarrollo.

---

**Versión**: 1.0.0 (Prototipo)  
**Última actualización**: Diciembre 2025  
**Plataforma**: iOS 16.0+
