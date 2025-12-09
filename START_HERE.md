# 📱 TribuGO - Inicio Rápido

## ¿Qué es TribuGO?

**TribuGO** es un prototipo funcional de iOS para un Sistema de Seguridad y Trazabilidad Integral de Trayectos. Permite a universidades y empresas monitorear los desplazamientos de estudiantes y funcionarios hacia el campus con enfoque en seguridad.

---

## 🚀 Inicio Rápido (3 pasos)

### 1️⃣ Abrir Xcode
- Requiere Xcode 15.0+ y macOS Sonoma+
- Sigue las instrucciones en **[XCODE_SETUP.md](XCODE_SETUP.md)**

### 2️⃣ Agregar Archivos
- Arrastra todos los archivos `.swift` al proyecto
- Configura permisos en `Info.plist`
- Verifica con **[CHECKLIST.md](CHECKLIST.md)**

### 3️⃣ Compilar y Ejecutar
- Presiona ⌘ + R
- Prueba con: `estudiante@universidad.edu`
- Sigue **[BUILD_GUIDE.md](BUILD_GUIDE.md)** si hay problemas

---

## 📚 Documentación Completa

### 🎯 Para Empezar
| Documento | Propósito | Cuándo Leer |
|-----------|-----------|-------------|
| **[README.md](README.md)** | Documentación principal del proyecto | Primero |
| **[PROJECT_SUMMARY.md](PROJECT_SUMMARY.md)** | Resumen ejecutivo y arquitectura | Para entender el proyecto |
| **[XCODE_SETUP.md](XCODE_SETUP.md)** | Crear proyecto desde cero | Antes de abrir Xcode |
| **[CHECKLIST.md](CHECKLIST.md)** | Verificación pre-compilación | Antes de compilar |

### 🔧 Para Desarrollar
| Documento | Propósito | Cuándo Leer |
|-----------|-----------|-------------|
| **[BUILD_GUIDE.md](BUILD_GUIDE.md)** | Compilación y solución de problemas | Al compilar |
| **[FILE_INDEX.md](FILE_INDEX.md)** | Índice de todos los archivos | Para navegar el código |
| **[FLOW_DIAGRAMS.md](FLOW_DIAGRAMS.md)** | Diagramas de flujo de la app | Para entender flujos |

### 🧪 Para Probar
| Documento | Propósito | Cuándo Leer |
|-----------|-----------|-------------|
| **[TESTING_GUIDE.md](TESTING_GUIDE.md)** | Casos de uso y pruebas de usabilidad | Para testing con usuarios |

---

## 📁 Estructura del Proyecto

```
TribuGO/
├── 📱 TribuGOApp.swift              # Punto de entrada
├── 📊 Models/                       # Modelos de datos (3 archivos)
├── 🧠 ViewModels/                   # Lógica de negocio (3 archivos)
├── 🎨 Views/                        # Interfaces (9 archivos)
├── 🔧 Services/                     # Servicios (1 archivo)
├── 🛠 Utils/                        # Utilidades (4 archivos)
├── 🎨 Assets.xcassets/              # Recursos visuales
├── ⚙️ Info.plist                    # Configuración y permisos
└── 📚 Documentation/                # Documentación (8 archivos)
```

**Total:** 28 archivos | ~2,550 líneas de código Swift

---

## ✨ Características Principales

- ✅ **Autenticación institucional** (simulada)
- ✅ **Tracking GPS en tiempo real**
- ✅ **Botón SOS de emergencia**
- ✅ **Historial de trayectos**
- ✅ **Visualización en mapa**
- ✅ **Escáner QR** (simulado)

---

## 🎯 Flujo Básico

```
1. Login → 2. Iniciar Trayecto → 3. Monitoreo GPS → 4. Finalizar → 5. Historial
```

---

## 🛠 Stack Tecnológico

- **Lenguaje:** Swift 5.9+
- **UI:** SwiftUI
- **Mapas:** MapKit
- **Ubicación:** CoreLocation
- **Persistencia:** UserDefaults (prototipo)
- **Arquitectura:** MVVM

---

## 📱 Requisitos

- **iOS:** 16.0+
- **Dispositivo:** iPhone
- **Xcode:** 15.0+
- **macOS:** Sonoma+

---

## 🎨 Capturas de Pantalla (Conceptual)

### Login
- Gradiente azul/púrpura
- Campos de email y contraseña
- Diseño institucional

### Inicio de Trayecto
- Mapa de fondo
- Botón grande "Iniciar Trayecto"
- Información sobre monitoreo

### Trayecto Activo
- Mapa con ruta en tiempo real
- Estadísticas (tiempo, distancia)
- Botón SOS rojo prominente

### Historial
- Lista de viajes
- Estadísticas generales
- Detalle con mapa de ruta

---

## 🧪 Probar la App

### Credenciales de Prueba
```
Email: estudiante@universidad.edu
Contraseña: cualquier_texto
```

### Flujo de Prueba
1. Login con credenciales
2. Aceptar permisos de ubicación
3. Iniciar trayecto
4. Observar tracking GPS
5. (Opcional) Activar SOS
6. Finalizar trayecto
7. Ver en historial

---

## 🐛 Solución de Problemas

### No compila
```bash
# Limpiar build
⌘ + Shift + K

# Limpiar DerivedData
⌘ + Shift + Option + K

# Recompilar
⌘ + B
```

### Errores comunes
- **"Cannot find X"** → Verifica Target Membership
- **Permisos de ubicación** → Revisa Info.plist
- **Crashes** → Revisa BUILD_GUIDE.md

---

## 📖 Guías Rápidas

### Para Desarrolladores
1. Lee **PROJECT_SUMMARY.md** para entender la arquitectura
2. Revisa **FILE_INDEX.md** para ubicar archivos
3. Consulta **FLOW_DIAGRAMS.md** para entender flujos

### Para Diseñadores UX
1. Lee **TESTING_GUIDE.md** para casos de uso
2. Revisa **FLOW_DIAGRAMS.md** para flujos de usuario
3. Consulta **README.md** para principios de diseño

### Para QA/Testers
1. Sigue **TESTING_GUIDE.md** para casos de prueba
2. Usa **CHECKLIST.md** para verificación
3. Consulta **BUILD_GUIDE.md** para configuración

---

## 🚀 Roadmap

### ✅ Fase 1: Prototipo (Actual)
- Funcionalidades básicas
- UI/UX completo
- Pruebas de usabilidad

### 🔄 Fase 2: Backend
- API REST
- Base de datos real
- Autenticación OAuth

### 🔮 Fase 3: Producción
- Notificaciones push
- Dashboard web
- Optimización de batería

### 🌟 Fase 4: Carpooling
- Matching de usuarios
- Chat en tiempo real
- Sistema de reputación

---

## 📊 Métricas de Éxito

### Técnicas
- ✅ Tracking GPS cada 5-10s
- ✅ Precisión: kCLLocationAccuracyBest
- ✅ SOS < 3 segundos
- ✅ Persistencia 100% confiable

### UX
- 🎯 80% completan flujo sin ayuda
- 🎯 90% entienden el monitoreo
- 🎯 100% pueden activar SOS
- 🎯 Satisfacción ≥ 4/5

---

## 🤝 Contribuir

Este es un prototipo para pruebas de usabilidad. Para contribuir:

1. Probar con usuarios reales
2. Documentar feedback de UX
3. Reportar bugs
4. Sugerir mejoras

---

## 📄 Licencia

Prototipo educativo - Todos los derechos reservados

---

## 📞 Soporte

### Documentación
- **General:** [README.md](README.md)
- **Compilación:** [BUILD_GUIDE.md](BUILD_GUIDE.md)
- **Testing:** [TESTING_GUIDE.md](TESTING_GUIDE.md)
- **Arquitectura:** [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md)

### Recursos
- [Documentación SwiftUI](https://developer.apple.com/documentation/swiftui/)
- [Core Location Guide](https://developer.apple.com/documentation/corelocation)
- [MapKit Documentation](https://developer.apple.com/documentation/mapkit)

---

## 🎯 Próximos Pasos

1. **Leer documentación:**
   - [ ] README.md (este archivo)
   - [ ] PROJECT_SUMMARY.md
   - [ ] XCODE_SETUP.md

2. **Configurar proyecto:**
   - [ ] Crear proyecto en Xcode
   - [ ] Agregar archivos
   - [ ] Configurar permisos

3. **Compilar y probar:**
   - [ ] Primera compilación
   - [ ] Pruebas básicas
   - [ ] Verificar funcionalidades

4. **Testing de usabilidad:**
   - [ ] Preparar casos de uso
   - [ ] Reclutar usuarios
   - [ ] Ejecutar pruebas
   - [ ] Analizar resultados

---

## 📈 Estado del Proyecto

**Versión:** 1.0.0 (Prototipo)  
**Última actualización:** Diciembre 2025  
**Estado:** ✅ Completo y listo para pruebas  
**Archivos:** 28 archivos Swift + Documentación  
**Líneas de código:** ~2,550 líneas

---

## 🌟 Características Destacadas

### Seguridad
- 🚨 Botón SOS siempre visible
- 📍 Tracking GPS continuo
- 🔒 Registro de incidentes

### Usabilidad
- 🎨 Diseño moderno y atractivo
- 📱 Interfaz intuitiva
- ⚡ Flujos rápidos y directos

### Técnico
- 🏗 Arquitectura MVVM limpia
- 📦 Código modular y reutilizable
- 📝 Documentación completa

---

**¡Bienvenido a TribuGO!** 🚀

Para comenzar, lee **[XCODE_SETUP.md](XCODE_SETUP.md)** y sigue el **[CHECKLIST.md](CHECKLIST.md)**.

---

*Desarrollado como prototipo funcional para pruebas de usabilidad.*
