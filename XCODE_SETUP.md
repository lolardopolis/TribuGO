# Instrucciones para Crear el Proyecto Xcode

## Opción 1: Crear Proyecto Nuevo en Xcode (Recomendado)

### Paso 1: Crear el Proyecto Base

1. **Abrir Xcode** (versión 15.0 o superior)

2. **Crear nuevo proyecto:**
   - File → New → Project (⇧⌘N)
   - Seleccionar **iOS** → **App**
   - Click **Next**

3. **Configurar:**
   - **Product Name**: `TribuGO`
   - **Team**: Tu equipo de desarrollo
   - **Organization Identifier**: `com.tuorganizacion`
   - **Bundle Identifier**: Se generará automáticamente
   - **Interface**: **SwiftUI**
   - **Language**: **Swift**
   - **Storage**: Marca **Use Core Data** (opcional)
   - **Include Tests**: Puedes marcar si quieres (opcional)
   - Click **Next**

4. **Guardar:**
   - Selecciona la ubicación (puede ser este mismo directorio)
   - Click **Create**

### Paso 2: Organizar la Estructura

1. **Eliminar archivos por defecto:**
   - Elimina `ContentView.swift` (no lo necesitamos)
   - Si creaste con Core Data, mantén el archivo `.xcdatamodeld`

2. **Crear grupos (carpetas) en Xcode:**
   - Click derecho en el proyecto → New Group
   - Crea estos grupos:
     ```
     Models
     ViewModels
     Views
       ├── Auth
       ├── Trip
       ├── History
       ├── Profile
       └── Components
     Services
     Utils
     ```

### Paso 3: Agregar los Archivos

**Opción A: Arrastrar y Soltar**
1. Abre Finder y navega a este directorio
2. Arrastra cada archivo Swift a su grupo correspondiente en Xcode
3. Asegúrate de marcar "Copy items if needed"
4. Asegúrate de marcar el target "TribuGO"

**Opción B: Agregar Manualmente**
1. Click derecho en cada grupo → Add Files to "TribuGO"
2. Selecciona los archivos correspondientes
3. Marca "Copy items if needed"
4. Marca el target "TribuGO"

### Paso 4: Configurar Info.plist

1. **Localizar Info.plist:**
   - En Xcode 14+, el Info.plist puede estar oculto
   - Ve a Target → Info tab

2. **Agregar permisos de ubicación:**
   - Click en el botón "+" para agregar nuevas claves
   - Agrega estas claves con sus valores:

   ```
   Privacy - Location When In Use Usage Description
   Valor: TribuGO necesita acceso a tu ubicación para monitorear tu trayecto al campus y garantizar tu seguridad durante el viaje.

   Privacy - Location Always and When In Use Usage Description
   Valor: TribuGO necesita acceso continuo a tu ubicación para poder rastrear tu trayecto incluso cuando la app está en segundo plano, garantizando tu seguridad en todo momento.

   Privacy - Camera Usage Description
   Valor: TribuGO necesita acceso a la cámara para escanear códigos QR del campus y registrar tu llegada.
   ```

3. **Agregar Background Modes:**
   - Ve a Target → Signing & Capabilities
   - Click en "+ Capability"
   - Busca "Background Modes"
   - Marca "Location updates"

### Paso 5: Configurar el Target

1. **General:**
   - Display Name: `TribuGO`
   - Bundle Identifier: Verifica que sea correcto
   - Version: `1.0`
   - Build: `1`
   - Minimum Deployments: **iOS 16.0**
   - Supported Destinations: **iPhone**

2. **Signing & Capabilities:**
   - Selecciona tu equipo
   - Automatic signing (recomendado para desarrollo)

### Paso 6: Verificar la Compilación

1. **Seleccionar un simulador:**
   - iPhone 15 Pro (recomendado)
   - O cualquier iPhone con iOS 16+

2. **Compilar:**
   - Presiona ⌘ + B
   - Verifica que no haya errores

3. **Ejecutar:**
   - Presiona ⌘ + R
   - La app debería iniciar en el simulador

---

## Opción 2: Usar Proyecto Existente

Si ya tienes un proyecto Xcode creado:

### Paso 1: Limpiar el Proyecto

1. Elimina archivos de ejemplo que no necesites
2. Mantén la estructura básica del proyecto

### Paso 2: Agregar Archivos

1. Arrastra todos los archivos `.swift` de este directorio al proyecto
2. Organízalos en grupos según la estructura mostrada arriba
3. Asegúrate de que todos estén en el target

### Paso 3: Configurar Permisos

Sigue el Paso 4 de la Opción 1

---

## Solución de Problemas

### Error: "Cannot find type 'X' in scope"

**Causa:** Archivo no agregado al target o no importado correctamente

**Solución:**
1. Selecciona el archivo en el navegador
2. Ve al File Inspector (⌥⌘1)
3. Verifica que "Target Membership" incluya "TribuGO"

### Error: "No such module 'SwiftUI'"

**Causa:** Deployment target muy bajo

**Solución:**
1. Ve a Target → General
2. Cambia "Minimum Deployments" a iOS 16.0 o superior

### Error de permisos de ubicación

**Causa:** Info.plist no configurado correctamente

**Solución:**
1. Verifica que las claves de privacidad estén agregadas
2. Verifica que los valores sean strings, no booleanos

### La app no compila

**Solución:**
1. Limpia el build: ⌘ + Shift + K
2. Limpia DerivedData: ⌘ + Shift + Option + K
3. Cierra y reabre Xcode
4. Vuelve a compilar: ⌘ + B

### Errores de sintaxis en archivos

**Causa:** Versión de Swift incompatible

**Solución:**
1. Ve a Target → Build Settings
2. Busca "Swift Language Version"
3. Asegúrate de que sea Swift 5.9 o superior

---

## Estructura Final Esperada

```
TribuGO (Project)
├── TribuGO (Target)
│   ├── TribuGOApp.swift
│   ├── Models/
│   │   ├── User.swift
│   │   ├── Trip.swift
│   │   └── SOSEvent.swift
│   ├── ViewModels/
│   │   ├── AuthViewModel.swift
│   │   ├── TripViewModel.swift
│   │   └── LocationManager.swift
│   ├── Views/
│   │   ├── Auth/
│   │   │   └── LoginView.swift
│   │   ├── Trip/
│   │   │   ├── TripStartView.swift
│   │   │   ├── ActiveTripView.swift
│   │   │   └── TripDetailView.swift
│   │   ├── History/
│   │   │   └── HistoryView.swift
│   │   ├── Profile/
│   │   │   └── ProfileView.swift
│   │   ├── Components/
│   │   │   ├── MapView.swift
│   │   │   └── QRScannerView.swift
│   │   └── MainTabView.swift
│   ├── Services/
│   │   └── PersistenceController.swift
│   ├── Utils/
│   │   ├── Constants.swift
│   │   ├── Extensions.swift
│   │   ├── ColorTheme.swift
│   │   └── MockData.swift
│   ├── Assets.xcassets/
│   └── Info.plist
└── Documentation/
    ├── README.md
    ├── BUILD_GUIDE.md
    ├── TESTING_GUIDE.md
    └── PROJECT_SUMMARY.md
```

---

## Checklist de Verificación

Antes de ejecutar, verifica:

- [ ] Todos los archivos .swift están en el proyecto
- [ ] Todos los archivos tienen Target Membership correcto
- [ ] Info.plist tiene los permisos de ubicación
- [ ] Background Modes está configurado
- [ ] Deployment target es iOS 16.0+
- [ ] Signing está configurado
- [ ] No hay errores de compilación

---

## Primer Ejecución

1. **Compilar:** ⌘ + B
2. **Ejecutar:** ⌘ + R
3. **Probar login:**
   - Email: `estudiante@universidad.edu`
   - Contraseña: cualquier texto
4. **Aceptar permisos de ubicación**
5. **Iniciar un trayecto de prueba**

---

## Recursos Adicionales

- [Documentación de Xcode](https://developer.apple.com/xcode/)
- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [Core Location Guide](https://developer.apple.com/documentation/corelocation)

---

**¿Necesitas ayuda?** Revisa BUILD_GUIDE.md para más detalles sobre compilación y ejecución.
