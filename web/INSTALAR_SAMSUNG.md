# 📱 Cómo Instalar TribuGO en tu Samsung

## ✨ ¡Ahora TribuGO es una PWA!

La app web ahora se puede **instalar en tu Samsung** como si fuera una app nativa de la Play Store.

---

## 🚀 Opción 1: Instalar desde el Navegador (Más Fácil)

### Paso 1: Abre la App en Chrome
1. Abre **Chrome** en tu Samsung
2. Ve a: `https://lolardopolis.github.io/TribuGO/`
   (Primero debes activar GitHub Pages - ver abajo)

### Paso 2: Verás un Botón "Instalar App"
- Aparecerá un botón flotante: **📱 Instalar App**
- Click en él

### Paso 3: Confirma la Instalación
- Aparecerá un popup: "Agregar TribuGO a la pantalla de inicio"
- Click en **"Agregar"** o **"Instalar"**

### Paso 4: ¡Listo!
- La app se instalará en tu pantalla de inicio
- Tendrá su propio ícono
- Se abrirá como app independiente (sin barra del navegador)

---

## 🌐 Opción 2: Desde el Menú de Chrome

### Paso 1: Abre la App
1. Chrome → `https://lolardopolis.github.io/TribuGO/`

### Paso 2: Menú de Chrome
1. Toca los **3 puntos** (arriba a la derecha)
2. Busca **"Agregar a pantalla de inicio"** o **"Instalar app"**
3. Click en esa opción

### Paso 3: Personaliza (Opcional)
- Puedes cambiar el nombre si quieres
- Click en **"Agregar"**

### Paso 4: ¡Listo!
- La app aparecerá en tu pantalla de inicio

---

## 📲 Opción 3: Desde Samsung Internet Browser

Si usas el navegador de Samsung:

### Paso 1: Abre la App
1. Samsung Internet → `https://lolardopolis.github.io/TribuGO/`

### Paso 2: Menú
1. Toca el ícono de **menú** (abajo)
2. Selecciona **"Agregar página a"**
3. Elige **"Pantalla de inicio"**

### Paso 3: Confirma
- Click en **"Agregar"**

---

## ✅ Cómo Saber que Está Instalada

Cuando la app está instalada correctamente:

1. **Ícono en pantalla de inicio** ✅
2. **Se abre en pantalla completa** (sin barra del navegador) ✅
3. **Aparece en el cajón de apps** ✅
4. **Funciona offline** (después de abrirla una vez) ✅
5. **Barra de estado azul** (color de TribuGO) ✅

---

## 🎯 Funcionalidades que Funcionan

Una vez instalada en tu Samsung:

- ✅ **GPS Real** - Usa tu ubicación real
- ✅ **Notificaciones** - Toast notifications
- ✅ **Vibración** - Feedback háptico
- ✅ **Cámara** - Para QR (si lo implementas)
- ✅ **Offline** - Funciona sin internet (después de cargar una vez)
- ✅ **Pantalla completa** - Como app nativa
- ✅ **Modo oscuro** - Se adapta al tema del sistema

---

## 🔧 Activar GitHub Pages Primero

Para que la app esté disponible en línea:

### Paso 1: Ve a GitHub
```
https://github.com/lolardopolis/TribuGO
```

### Paso 2: Settings → Pages
1. Click en **"Settings"** (arriba)
2. En el menú izquierdo, click en **"Pages"**

### Paso 3: Configurar
- **Source:** Deploy from a branch
- **Branch:** main
- **Folder:** /web ← **IMPORTANTE**
- Click **"Save"**

### Paso 4: Esperar
- Espera 1-2 minutos
- Recarga la página
- Verás: "Your site is live at https://lolardopolis.github.io/TribuGO/"

### Paso 5: Probar
- Abre ese link en tu Samsung
- ¡Listo para instalar!

---

## 📱 Probarlo Ahora (Sin GitHub Pages)

Si quieres probarlo YA en tu Samsung sin esperar GitHub Pages:

### Opción A: Servidor Local
1. En tu PC, abre terminal en la carpeta `web`
2. Ejecuta: `python -m http.server 8000`
3. En tu Samsung, conectado a la misma WiFi
4. Abre Chrome y ve a: `http://TU_IP_PC:8000`
   (Reemplaza TU_IP_PC con la IP de tu PC)

### Opción B: Netlify Drop (Gratis y Rápido)
1. Ve a: https://app.netlify.com/drop
2. Arrastra la carpeta `web` completa
3. Te dará un link tipo: `https://random-name.netlify.app`
4. Abre ese link en tu Samsung
5. ¡Instala!

---

## 🎨 Cómo Se Verá

### Ícono en Pantalla de Inicio
- Fondo azul (#007AFF)
- Texto "TribuGO"
- Ícono de escudo 🛡️

### Splash Screen
- Al abrir, verás una pantalla de carga azul
- Con el nombre "TribuGO"

### App
- Pantalla completa
- Sin barra del navegador
- Barra de estado azul
- Como app nativa

---

## 🔄 Actualizar la App

Cuando hagas cambios y los subas a GitHub:

1. La app se actualizará automáticamente
2. Puede tardar unos minutos
3. Cierra y abre la app para ver cambios

---

## 🗑️ Desinstalar

Si quieres desinstalarla:

1. Mantén presionado el ícono
2. Selecciona **"Desinstalar"** o **"Eliminar"**
3. Confirma

---

## ❓ Problemas Comunes

### No aparece el botón "Instalar App"
**Solución:**
- Asegúrate de estar usando HTTPS (GitHub Pages usa HTTPS)
- Recarga la página
- Prueba desde el menú de Chrome

### La app no funciona offline
**Solución:**
- Abre la app una vez con internet
- El Service Worker se instalará
- Luego funcionará offline

### Los cambios no se ven
**Solución:**
- Cierra completamente la app
- Borra el cache del navegador
- Vuelve a abrir

---

## 📊 Comparación: PWA vs App Nativa

| Característica | PWA (TribuGO) | App Nativa |
|----------------|---------------|------------|
| Instalación | ✅ Desde navegador | Play Store |
| Tamaño | ~2 MB | ~50-100 MB |
| Actualizaciones | ✅ Automáticas | Manual |
| Offline | ✅ Sí | ✅ Sí |
| GPS | ✅ Sí | ✅ Sí |
| Notificaciones | ✅ Sí | ✅ Sí |
| Cámara | ✅ Sí | ✅ Sí |
| Costo | ✅ Gratis | $25 (Play Store) |

---

## 🎉 ¡Listo!

Ahora tienes TribuGO instalado en tu Samsung como una app real.

**Funciona exactamente igual que una app de la Play Store**, pero:
- ✅ Sin necesidad de publicarla
- ✅ Actualizaciones instantáneas
- ✅ Más ligera
- ✅ Multiplataforma (funciona en iPhone también)

---

**¿Necesitas ayuda?** Revisa la documentación en el repositorio de GitHub.
