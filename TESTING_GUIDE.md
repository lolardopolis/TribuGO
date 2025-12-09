# Casos de Uso y Flujos de Prueba - TribuGO

## Objetivo de las Pruebas de Usabilidad

Este documento describe los escenarios que deben probarse con usuarios reales para validar la experiencia y detectar puntos de fricción en el flujo de la aplicación.

---

## Caso de Uso 1: Primer Uso de la Aplicación

### Objetivo
Validar que un usuario nuevo pueda entender y completar el proceso de registro/login sin ayuda.

### Flujo
1. Usuario abre la app por primera vez
2. Ve pantalla de login con branding institucional
3. Ingresa su correo institucional
4. Ingresa una contraseña
5. Presiona "Iniciar Sesión"
6. Accede a la pantalla principal

### Métricas a Observar
- ¿El usuario entiende que debe usar su correo institucional?
- ¿Hay confusión sobre qué contraseña usar?
- ¿El diseño transmite confianza y profesionalismo?
- Tiempo promedio para completar el login

### Preguntas Post-Tarea
- "¿Fue claro qué credenciales debías usar?"
- "¿El diseño te transmitió confianza?"
- "¿Algo te confundió en esta pantalla?"

---

## Caso de Uso 2: Iniciar Primer Trayecto

### Objetivo
Verificar que el usuario comprende cómo iniciar un trayecto y qué significa estar "siendo monitoreado".

### Flujo
1. Usuario está en la pantalla principal (TripStartView)
2. Lee la información sobre el monitoreo
3. Presiona "Iniciar Trayecto al Campus"
4. Sistema solicita permisos de ubicación
5. Usuario acepta permisos
6. Trayecto se inicia y pasa a ActiveTripView

### Métricas a Observar
- ¿El usuario entiende para qué es el botón grande?
- ¿Hay dudas sobre los permisos de ubicación?
- ¿El usuario se siente cómodo siendo monitoreado?
- ¿Entiende la diferencia entre "en curso" y "completado"?

### Preguntas Post-Tarea
- "¿Entendiste qué hace el botón 'Iniciar Trayecto'?"
- "¿Te sentiste cómodo otorgando permisos de ubicación?"
- "¿Qué esperas que pase mientras viajas?"
- "¿Te genera confianza o preocupación el monitoreo?"

---

## Caso de Uso 3: Trayecto en Curso

### Objetivo
Evaluar si el usuario comprende el estado del viaje y puede interactuar con las funciones durante el trayecto.

### Flujo
1. Usuario tiene un trayecto activo
2. Observa el mapa con su ubicación
3. Ve las estadísticas (tiempo, puntos, distancia)
4. Identifica el botón SOS
5. Identifica las opciones para finalizar

### Métricas a Observar
- ¿El usuario entiende que está siendo rastreado?
- ¿El botón SOS es suficientemente visible?
- ¿Entiende cómo finalizar el trayecto?
- ¿Hay confusión sobre qué hacer al llegar?

### Preguntas Post-Tarea
- "¿Qué información te parece más útil durante el viaje?"
- "¿El botón SOS es fácil de encontrar?"
- "¿Cómo finalizarías tu viaje al llegar?"
- "¿Algo te preocupa de esta pantalla?"

---

## Caso de Uso 4: Activar Botón SOS

### Objetivo
Verificar que el usuario puede activar el SOS en una situación de emergencia y entiende qué sucede.

### Flujo
1. Usuario está en trayecto activo
2. Presiona el botón "EMERGENCIA SOS"
3. Ve alerta de confirmación
4. Confirma la activación
5. Ve mensaje de que la alerta fue enviada
6. El viaje cambia a estado "incidente"

### Métricas a Observar
- ¿El botón es fácil de presionar en situación de estrés?
- ¿La confirmación es clara pero no invasiva?
- ¿El usuario entiende qué pasa después de activar SOS?
- ¿Se siente seguro con esta función?

### Preguntas Post-Tarea
- "¿Fue fácil activar el SOS?"
- "¿Entendiste qué pasó después de presionarlo?"
- "¿Te sentirías seguro usando esto en una emergencia real?"
- "¿Cambiarías algo del proceso?"

---

## Caso de Uso 5: Finalizar Trayecto

### Objetivo
Evaluar si el usuario puede finalizar el trayecto de manera intuitiva.

### Flujo
1. Usuario llega al campus
2. Tiene dos opciones:
   - Presionar "He llegado"
   - Escanear código QR
3. Elige una opción
4. Confirma la finalización
5. El trayecto se guarda en el historial
6. Regresa a la pantalla principal

### Métricas a Observar
- ¿Cuál opción prefiere el usuario?
- ¿Entiende la diferencia entre ambas opciones?
- ¿El proceso es rápido y sin fricción?
- ¿Hay confusión sobre qué hacer después?

### Preguntas Post-Tarea
- "¿Qué opción preferiste para finalizar? ¿Por qué?"
- "¿Fue claro que el viaje se guardó?"
- "¿Esperabas alguna confirmación adicional?"

---

## Caso de Uso 6: Revisar Historial

### Objetivo
Verificar que el usuario puede acceder y entender su historial de viajes.

### Flujo
1. Usuario va al tab "Historial"
2. Ve lista de trayectos previos
3. Ve estadísticas generales (total viajes, distancia, SOS)
4. Selecciona un viaje específico
5. Ve el detalle con mapa de ruta
6. Identifica si hubo eventos SOS

### Métricas a Observar
- ¿El historial es claro y fácil de navegar?
- ¿Las estadísticas son útiles?
- ¿El mapa de ruta es comprensible?
- ¿Se identifican claramente los incidentes?

### Preguntas Post-Tarea
- "¿Qué información te parece más útil del historial?"
- "¿Hay algo que te gustaría ver que no está?"
- "¿El mapa de ruta te ayuda a recordar el viaje?"

---

## Caso de Uso 7: Gestión de Perfil

### Objetivo
Evaluar si el usuario puede gestionar su perfil y cerrar sesión.

### Flujo
1. Usuario va al tab "Perfil"
2. Ve su información
3. Explora las opciones de configuración
4. Decide cerrar sesión
5. Confirma el cierre de sesión
6. Regresa a la pantalla de login

### Métricas a Observar
- ¿El perfil muestra información relevante?
- ¿Las opciones de configuración son claras?
- ¿El proceso de cierre de sesión es intuitivo?

### Preguntas Post-Tarea
- "¿Hay alguna configuración que esperabas encontrar?"
- "¿Fue fácil cerrar sesión?"

---

## Escenarios de Error a Probar

### 1. Sin Permisos de Ubicación
**Qué probar:** Usuario rechaza permisos de ubicación
**Resultado esperado:** Mensaje claro explicando por qué son necesarios

### 2. GPS Desactivado
**Qué probar:** Usuario tiene GPS desactivado en el dispositivo
**Resultado esperado:** Indicación de que debe activar el GPS

### 3. Sin Conexión a Internet
**Qué probar:** Usuario pierde conexión durante el viaje
**Resultado esperado:** App continúa funcionando en modo offline

### 4. Batería Baja
**Qué probar:** Dispositivo con batería baja durante trayecto
**Resultado esperado:** Opción de reducir frecuencia de tracking

---

## Métricas Generales de Usabilidad

### Cuantitativas
- **Tasa de éxito:** % de usuarios que completan cada tarea
- **Tiempo de tarea:** Tiempo promedio para cada flujo
- **Errores:** Número de errores por tarea
- **Clics hasta objetivo:** Número de interacciones necesarias

### Cualitativas
- **Satisfacción:** Escala 1-5 después de cada tarea
- **Confianza:** ¿El usuario se siente seguro usando la app?
- **Claridad:** ¿Los conceptos son fáciles de entender?
- **Valor percibido:** ¿El usuario ve utilidad en la app?

---

## Preguntas Finales (Post-Test)

1. **Utilidad General**
   - "¿Usarías esta app para tus viajes al campus?"
   - "¿Qué es lo que más te gustó?"
   - "¿Qué es lo que menos te gustó?"

2. **Seguridad y Confianza**
   - "¿Te sientes más seguro con esta app?"
   - "¿Confías en que la institución use bien tus datos?"
   - "¿Hay algo que te preocupe sobre el monitoreo?"

3. **Mejoras**
   - "¿Qué agregarías a la app?"
   - "¿Qué quitarías o cambiarías?"
   - "¿Recomendarías esta app a otros estudiantes?"

4. **Comparación**
   - "¿Has usado apps similares? ¿Cuáles?"
   - "¿Cómo se compara TribuGO con ellas?"

---

## Protocolo de Testing

### Preparación
1. Tener dispositivo con la app instalada
2. Preparar escenarios de ubicación simulada
3. Tener códigos QR de prueba
4. Preparar guía de observación

### Durante la Sesión
1. Explicar el contexto sin dar instrucciones específicas
2. Pedir al usuario que "piense en voz alta"
3. Observar sin intervenir (solo si se bloquea completamente)
4. Tomar notas de comportamiento y comentarios

### Después de la Sesión
1. Hacer preguntas post-tarea
2. Recopilar feedback general
3. Agradecer la participación
4. Documentar hallazgos inmediatamente

---

## Criterios de Éxito del Prototipo

✅ **Mínimo Viable:**
- 80% de usuarios completan el flujo básico sin ayuda
- 90% entienden el concepto de monitoreo
- 100% pueden activar SOS en menos de 3 segundos
- 70% se sienten seguros usando la app

✅ **Objetivo Ideal:**
- 95% de usuarios completan todos los flujos
- Satisfacción promedio ≥ 4/5
- Cero confusión sobre funciones críticas (SOS, inicio/fin de viaje)
- Feedback positivo sobre diseño y confianza

---

**Nota:** Este documento debe actualizarse con los resultados reales de las pruebas de usabilidad.
