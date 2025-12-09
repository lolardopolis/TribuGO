# 🌐 TribuGO Web - Versión Demo Interactiva

## 🎯 ¿Qué es esto?

Esta es una **versión web completamente funcional** de TribuGO que simula exactamente la app iOS, pero que puedes ver directamente en tu navegador **sin necesitar Mac ni Xcode**.

## ✨ Características

✅ **Mismo diseño** que la app iOS  
✅ **Totalmente funcional** - puedes probar todo el flujo  
✅ **Simulación de GPS** con mapas reales  
✅ **Responsive** - funciona en móvil y desktop  
✅ **Sin instalación** - solo abre `index.html`  

---

## 🚀 Cómo Verla

### Opción 1: Abrir Localmente (Más Fácil)

1. Abre el archivo `index.html` en tu navegador
2. ¡Listo! Ya puedes probar la app

### Opción 2: Servidor Local (Recomendado)

Si tienes Python instalado:

```bash
# Python 3
python -m http.server 8000

# O Python 2
python -m SimpleHTTPServer 8000
```

Luego abre: `http://localhost:8000`

### Opción 3: Live Server (VS Code)

1. Instala la extensión "Live Server" en VS Code
2. Click derecho en `index.html` → "Open with Live Server"

### Opción 4: GitHub Pages (Para Compartir)

1. Sube la carpeta `web` a GitHub
2. Ve a Settings → Pages
3. Selecciona la rama y carpeta `/web`
4. ¡Tu app estará en línea!

---

## 🧪 Cómo Probar

### 1. Login
- **Email**: `estudiante@universidad.edu` (o cualquier email)
- **Contraseña**: cualquier texto

### 2. Iniciar Trayecto
1. Ve al tab "Inicio"
2. Click en "Iniciar Trayecto al Campus"
3. Verás el mapa con tracking en tiempo real

### 3. Durante el Trayecto
- Observa cómo se actualiza el tiempo
- Los puntos GPS se agregan automáticamente cada 5 segundos
- La ruta se dibuja en el mapa

### 4. Botón SOS
- Click en el botón rojo "EMERGENCIA SOS"
- Confirma la alerta
- Se registra el evento y aparece un marcador rojo en el mapa

### 5. Finalizar
- Click en "He llegado" o "Escanear QR"
- El viaje se guarda en el historial

### 6. Ver Historial
- Ve al tab "Historial"
- Verás estadísticas y lista de viajes
- Click en un viaje para ver detalles

---

## 📱 Funcionalidades Implementadas

### ✅ Completas
- Login institucional (simulado)
- Navegación por tabs
- Inicio de trayecto
- Tracking GPS simulado con mapas reales (OpenStreetMap)
- Botón SOS con registro de eventos
- Finalización de trayecto
- Historial completo con detalles
- Perfil de usuario
- Persistencia en localStorage

### 🎨 Diseño
- Gradiente azul/púrpura en login
- Mapas interactivos con Leaflet.js
- Animaciones suaves
- Iconos emoji para mejor visualización
- Responsive design

---

## 🗂 Archivos

```
web/
├── index.html      # Estructura HTML
├── styles.css      # Estilos completos
├── app.js          # Lógica de la aplicación
└── README.md       # Este archivo
```

---

## 🌐 Subir a GitHub Pages

### Paso 1: Crear Repositorio

```bash
cd web
git init
git add .
git commit -m "TribuGO Web Demo"
git branch -M main
git remote add origin https://github.com/lolardopolis/TribuGO.git
git push -u origin main
```

### Paso 2: Activar GitHub Pages

1. Ve a tu repositorio en GitHub
2. Settings → Pages
3. Source: Deploy from a branch
4. Branch: `main` → `/` (root)
5. Save

### Paso 3: Acceder

Tu app estará en: `https://lolardopolis.github.io/TribuGO/`

---

## 🔧 Tecnologías Usadas

- **HTML5** - Estructura
- **CSS3** - Estilos modernos con gradientes y animaciones
- **JavaScript (Vanilla)** - Sin frameworks, código puro
- **Leaflet.js** - Mapas interactivos
- **OpenStreetMap** - Tiles de mapas
- **LocalStorage** - Persistencia de datos

---

## 📊 Datos de Prueba

La app genera datos simulados:
- Puntos GPS cada 5 segundos
- Movimiento aleatorio en el mapa
- Cálculo de distancia aproximada
- Timer en tiempo real

---

## 🎯 Diferencias con la App iOS

| Característica | iOS | Web |
|----------------|-----|-----|
| GPS Real | ✅ | ❌ (Simulado) |
| Cámara QR | ✅ | ❌ (Simulado) |
| Background Tracking | ✅ | ❌ |
| Notificaciones Push | ✅ | ❌ |
| Diseño | SwiftUI | HTML/CSS |
| Mapas | MapKit | Leaflet/OSM |
| Persistencia | Core Data | LocalStorage |

---

## 🚀 Mejoras Futuras

Para convertir esto en una app real:

1. **Backend**
   - API REST para guardar viajes
   - Base de datos real
   - Autenticación OAuth

2. **GPS Real**
   - Usar Geolocation API del navegador
   - Tracking real en tiempo real

3. **PWA**
   - Service Workers
   - Instalable en móvil
   - Funciona offline

4. **Notificaciones**
   - Push Notifications API
   - Alertas en tiempo real

---

## 📝 Notas

- **Los datos se guardan en localStorage** - se mantienen entre sesiones
- **Los mapas son reales** - usa OpenStreetMap
- **El GPS es simulado** - genera puntos aleatorios
- **Funciona offline** - no necesita internet (excepto mapas)

---

## 🎨 Capturas de Pantalla

Para tomar capturas:
1. Abre la app en tu navegador
2. Presiona F12 → Toggle Device Toolbar
3. Selecciona "iPhone 14 Pro"
4. Navega por las pantallas
5. Click derecho → Capturar screenshot

---

## 🤝 Compartir

Para compartir con otros:

1. **Opción 1**: Sube a GitHub Pages (ver arriba)
2. **Opción 2**: Comprime la carpeta `web` y envía el ZIP
3. **Opción 3**: Usa servicios como Netlify o Vercel

---

## ✅ Checklist de Verificación

- [ ] Abre `index.html` en el navegador
- [ ] Haz login con cualquier email
- [ ] Inicia un trayecto
- [ ] Observa el tracking GPS
- [ ] Activa el botón SOS
- [ ] Finaliza el trayecto
- [ ] Ve el historial
- [ ] Revisa el perfil
- [ ] Cierra sesión

---

## 🆘 Problemas Comunes

### Los mapas no se cargan
**Solución**: Necesitas conexión a internet para los tiles de OpenStreetMap

### Los datos no se guardan
**Solución**: Asegúrate de no estar en modo incógnito

### La app no se ve bien en móvil
**Solución**: Abre en un navegador moderno (Chrome, Safari, Firefox)

---

## 📧 Contacto

Para preguntas o mejoras, abre un issue en GitHub.

---

**Versión**: 1.0.0 (Demo Web)  
**Última actualización**: Diciembre 2025  
**Autor**: TribuGO Team  
**Licencia**: MIT
