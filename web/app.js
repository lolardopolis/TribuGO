// Estado de la aplicación
let currentUser = null;
let currentTrip = null;
let tripHistory = [];
let map = null;
let tripMap = null;
let tripTimer = null;
let tripStartTime = null;
let routePoints = [];
let routePolyline = null;
let currentMarker = null;
let watchId = null;
let useRealGPS = false;
let darkMode = false;
let notifications = true;

// Inicialización
document.addEventListener('DOMContentLoaded', () => {
    loadUserData();
    initializeMaps();
});

// Funciones de Login
function togglePassword() {
    const input = document.getElementById('password-input');
    input.type = input.type === 'password' ? 'text' : 'password';
}

function login() {
    const email = document.getElementById('email-input').value.trim();
    const password = document.getElementById('password-input').value;
    const errorDiv = document.getElementById('error-message');

    // Validación básica
    if (!email) {
        showError('Por favor ingresa tu correo institucional');
        return;
    }

    if (!email.includes('@')) {
        showError('Ingresa un correo válido');
        return;
    }

    if (!password) {
        showError('Por favor ingresa tu contraseña');
        return;
    }

    // Login exitoso (simulado)
    currentUser = {
        id: Date.now(),
        email: email,
        name: email.split('@')[0],
        createdAt: new Date()
    };

    saveUserData();
    showScreen('main-screen');
    updateUserProfile();
    hideError();
}

function showError(message) {
    const errorDiv = document.getElementById('error-message');
    errorDiv.textContent = '⚠️ ' + message;
    errorDiv.classList.remove('hidden');
}

function hideError() {
    const errorDiv = document.getElementById('error-message');
    errorDiv.classList.add('hidden');
}

function logout() {
    if (confirm('¿Estás seguro que deseas cerrar sesión?')) {
        currentUser = null;
        currentTrip = null;
        localStorage.removeItem('tribugo_user');
        showScreen('login-screen');
    }
}

// Navegación
function showScreen(screenId) {
    document.querySelectorAll('.screen').forEach(screen => {
        screen.classList.remove('active');
    });
    document.getElementById(screenId).classList.add('active');

    // Actualizar mapas cuando se muestran
    if (screenId === 'main-screen') {
        setTimeout(() => {
            if (map) map.invalidateSize();
        }, 100);
    } else if (screenId === 'active-trip-screen') {
        setTimeout(() => {
            if (tripMap) tripMap.invalidateSize();
        }, 100);
    }
}

function switchTab(tabName) {
    // Actualizar botones
    document.querySelectorAll('.tab-button').forEach(btn => {
        btn.classList.remove('active');
    });
    event.target.closest('.tab-button').classList.add('active');

    // Actualizar contenido
    document.querySelectorAll('.tab-pane').forEach(pane => {
        pane.classList.remove('active');
    });
    document.getElementById(tabName + '-tab').classList.add('active');

    // Actualizar datos si es necesario
    if (tabName === 'historial') {
        updateHistoryTab();
    }
}

// Inicializar mapas
function initializeMaps() {
    // Mapa principal
    if (document.getElementById('map-container')) {
        map = L.map('map-container').setView([-33.4489, -70.6693], 13);
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap contributors'
        }).addTo(map);

        // Marcador de ubicación actual (simulado)
        L.marker([-33.4489, -70.6693]).addTo(map)
            .bindPopup('Tu ubicación actual')
            .openPopup();
    }
}

// Gestión de trayectos
function startTrip() {
    if (currentTrip) {
        alert('Ya tienes un trayecto activo');
        return;
    }

    // Crear nuevo trayecto
    currentTrip = {
        id: Date.now(),
        userId: currentUser.id,
        startTime: new Date(),
        endTime: null,
        status: 'en_curso',
        points: [],
        sosEvents: []
    };

    tripStartTime = Date.now();
    routePoints = [];

    // Inicializar mapa de trayecto
    showScreen('active-trip-screen');
    initializeTripMap();

    // Iniciar tracking simulado
    startTracking();
}

function initializeTripMap() {
    setTimeout(() => {
        if (!tripMap) {
            tripMap = L.map('trip-map-container').setView([-33.4489, -70.6693], 15);
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '© OpenStreetMap contributors'
            }).addTo(tripMap);
        }

        // Marcador de inicio
        L.marker([-33.4489, -70.6693], {
            icon: L.divIcon({
                className: 'custom-marker',
                html: '<div style="background: #10B981; width: 30px; height: 30px; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-size: 16px;">🚩</div>'
            })
        }).addTo(tripMap);

        // Marcador de posición actual
        L.marker([-33.4489, -70.6693], {
            icon: L.divIcon({
                className: 'custom-marker',
                html: '<div style="background: #007AFF; width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-size: 20px; box-shadow: 0 0 0 8px rgba(0, 122, 255, 0.3);">📍</div>'
            })
        }).addTo(tripMap);
    }, 100);
}

function startTracking() {
    // Actualizar timer
    tripTimer = setInterval(updateTripStats, 1000);

    // Simular puntos GPS cada 5 segundos
    setInterval(() => {
        if (currentTrip && currentTrip.status === 'en_curso') {
            addGPSPoint();
        }
    }, 5000);
}

function updateTripStats() {
    if (!currentTrip) return;

    const elapsed = Math.floor((Date.now() - tripStartTime) / 1000);
    const minutes = Math.floor(elapsed / 60);
    const seconds = elapsed % 60;

    document.getElementById('trip-time').textContent =
        `${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`;
    document.getElementById('trip-points').textContent = currentTrip.points.length;

    // Calcular distancia aproximada
    const distance = currentTrip.points.length * 50; // 50m por punto (simulado)
    document.getElementById('trip-distance').textContent =
        distance < 1000 ? `${distance} m` : `${(distance / 1000).toFixed(2)} km`;
}

function addGPSPoint() {
    // Simular movimiento aleatorio
    const lastPoint = currentTrip.points.length > 0
        ? currentTrip.points[currentTrip.points.length - 1]
        : { lat: -33.4489, lng: -70.6693 };

    const newPoint = {
        lat: lastPoint.lat + (Math.random() - 0.5) * 0.002,
        lng: lastPoint.lng + (Math.random() - 0.5) * 0.002,
        timestamp: new Date()
    };

    currentTrip.points.push(newPoint);
    routePoints.push([newPoint.lat, newPoint.lng]);

    // Actualizar polyline en el mapa
    if (tripMap) {
        if (routePolyline) {
            tripMap.removeLayer(routePolyline);
        }
        routePolyline = L.polyline(routePoints, {
            color: '#007AFF',
            weight: 4
        }).addTo(tripMap);

        // Centrar mapa en la ruta
        tripMap.fitBounds(routePolyline.getBounds());
    }
}

function activateSOS() {
    if (!currentTrip) return;

    if (confirm('🚨 ¿Estás seguro de activar la alerta SOS?\n\nSe registrará tu ubicación actual y se enviará una alerta a la institución.')) {
        const sosEvent = {
            lat: currentTrip.points.length > 0
                ? currentTrip.points[currentTrip.points.length - 1].lat
                : -33.4489,
            lng: currentTrip.points.length > 0
                ? currentTrip.points[currentTrip.points.length - 1].lng
                : -70.6693,
            timestamp: new Date()
        };

        currentTrip.sosEvents.push(sosEvent);
        currentTrip.status = 'incidente';

        // Agregar marcador SOS en el mapa
        if (tripMap) {
            L.marker([sosEvent.lat, sosEvent.lng], {
                icon: L.divIcon({
                    className: 'custom-marker',
                    html: '<div style="background: #EF4444; width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-size: 24px;">⚠️</div>'
                })
            }).addTo(tripMap);
        }

        alert('✅ Alerta SOS enviada a la institución\n\nTu ubicación ha sido registrada.');
    }
}

function endTrip() {
    if (!currentTrip) return;

    if (confirm('¿Has llegado al campus?\n\nSe guardará tu trayecto en el historial.')) {
        finalizarTrayecto();
    }
}

function scanQR() {
    alert('📷 Escáner QR\n\n(Simulado para prototipo)\n\nEn la versión real, aquí se activaría la cámara para escanear el código QR del campus.');

    // Simular escaneo exitoso
    setTimeout(() => {
        if (confirm('✅ Código QR escaneado correctamente\n\n¿Finalizar trayecto?')) {
            finalizarTrayecto();
        }
    }, 1000);
}

function finalizarTrayecto() {
    if (!currentTrip) return;

    currentTrip.endTime = new Date();

    // Si no hay eventos SOS, marcar como completado
    if (currentTrip.sosEvents.length === 0) {
        currentTrip.status = 'completado';
    }

    // Guardar en historial
    tripHistory.unshift(currentTrip);
    saveTripHistory();

    // Limpiar
    clearInterval(tripTimer);
    currentTrip = null;
    tripStartTime = null;
    routePoints = [];

    if (routePolyline && tripMap) {
        tripMap.removeLayer(routePolyline);
        routePolyline = null;
    }

    // Volver a inicio
    showScreen('main-screen');
    switchTab('historial');

    alert('✅ Trayecto finalizado y guardado en el historial');
}

// Historial
function updateHistoryTab() {
    // Actualizar estadísticas
    document.getElementById('total-trips').textContent = tripHistory.length;

    const totalDistance = tripHistory.reduce((sum, trip) => {
        return sum + (trip.points.length * 50); // 50m por punto
    }, 0);
    document.getElementById('total-distance').textContent =
        (totalDistance / 1000).toFixed(1) + ' km';

    const totalSOS = tripHistory.reduce((sum, trip) => {
        return sum + trip.sosEvents.length;
    }, 0);
    document.getElementById('total-sos').textContent = totalSOS;

    // Actualizar lista de viajes
    const tripsList = document.getElementById('trips-list');

    if (tripHistory.length === 0) {
        tripsList.innerHTML = `
            <div class="empty-state">
                <div class="empty-icon">🕐</div>
                <h3>No hay trayectos registrados</h3>
                <p>Tus viajes al campus aparecerán aquí</p>
            </div>
        `;
        return;
    }

    tripsList.innerHTML = tripHistory.map(trip => {
        const duration = trip.endTime
            ? Math.floor((new Date(trip.endTime) - new Date(trip.startTime)) / 1000)
            : 0;
        const minutes = Math.floor(duration / 60);
        const seconds = duration % 60;
        const distance = trip.points.length * 50;

        return `
            <div class="trip-card" onclick="showTripDetail('${trip.id}')">
                <div class="trip-card-header">
                    <div class="trip-status-icon ${trip.status}">
                        ${trip.status === 'completado' ? '✓' : '⚠️'}
                    </div>
                    <div class="trip-info">
                        <h4>${formatDate(trip.startTime)}</h4>
                        <div class="trip-meta">
                            <span>⏱️ ${minutes}:${String(seconds).padStart(2, '0')}</span>
                            <span>📍 ${distance < 1000 ? distance + ' m' : (distance / 1000).toFixed(2) + ' km'}</span>
                            ${trip.sosEvents.length > 0 ? '<span>🚨 ' + trip.sosEvents.length + ' SOS</span>' : ''}
                        </div>
                        <div class="trip-status ${trip.status}">
                            ${trip.status === 'completado' ? 'Completado' : 'Incidente'}
                        </div>
                    </div>
                </div>
            </div>
        `;
    }).join('');
}

function showTripDetail(tripId) {
    const trip = tripHistory.find(t => t.id == tripId);
    if (!trip) return;

    const duration = trip.endTime
        ? Math.floor((new Date(trip.endTime) - new Date(trip.startTime)) / 1000)
        : 0;
    const minutes = Math.floor(duration / 60);
    const seconds = duration % 60;
    const distance = trip.points.length * 50;

    const content = `
        <div style="padding: 20px;">
            <div style="background: ${trip.status === 'completado' ? '#10B981' : '#EF4444'}; color: white; padding: 12px; border-radius: 8px; margin-bottom: 16px; display: flex; justify-content: space-between; align-items: center;">
                <strong>${trip.status === 'completado' ? '✓ Completado' : '⚠️ Incidente'}</strong>
                <button onclick="shareTrip('${trip.id}')" style="background: rgba(255,255,255,0.2); border: none; color: white; padding: 8px 16px; border-radius: 6px; cursor: pointer; font-size: 14px;">
                    📤 Compartir
                </button>
            </div>
            
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 12px; margin-bottom: 16px;">
                <div style="background: #F3F4F6; padding: 16px; border-radius: 8px; text-align: center;">
                    <div style="font-size: 12px; color: #6B7280; margin-bottom: 4px;">Duración</div>
                    <div style="font-size: 20px; font-weight: 700;">${minutes}:${String(seconds).padStart(2, '0')}</div>
                </div>
                <div style="background: #F3F4F6; padding: 16px; border-radius: 8px; text-align: center;">
                    <div style="font-size: 12px; color: #6B7280; margin-bottom: 4px;">Distancia</div>
                    <div style="font-size: 20px; font-weight: 700;">${distance < 1000 ? distance + ' m' : (distance / 1000).toFixed(2) + ' km'}</div>
                </div>
            </div>
            
            <div style="background: #F3F4F6; padding: 16px; border-radius: 8px; margin-bottom: 16px;">
                <div style="margin-bottom: 8px;"><strong>📅 Inicio:</strong> ${formatDateTime(trip.startTime)}</div>
                <div><strong>📅 Fin:</strong> ${formatDateTime(trip.endTime)}</div>
            </div>
            
            <div style="background: #F3F4F6; padding: 16px; border-radius: 8px; margin-bottom: 16px;">
                <div><strong>📍 Puntos GPS:</strong> ${trip.points.length}</div>
                <div><strong>⚠️ Eventos SOS:</strong> ${trip.sosEvents.length}</div>
            </div>
            
            ${trip.sosEvents.length > 0 ? `
                <div style="background: #FEE2E2; padding: 16px; border-radius: 8px;">
                    <strong style="color: #EF4444;">🚨 Eventos de Emergencia</strong>
                    ${trip.sosEvents.map(event => `
                        <div style="margin-top: 8px; padding: 8px; background: white; border-radius: 4px;">
                            <div style="font-size: 12px;">${formatDateTime(event.timestamp)}</div>
                            <div style="font-size: 11px; color: #6B7280;">Lat: ${event.lat.toFixed(6)}, Lng: ${event.lng.toFixed(6)}</div>
                        </div>
                    `).join('')}
                </div>
            ` : ''}
        </div>
    `;

    document.getElementById('trip-detail-content').innerHTML = content;
    document.getElementById('trip-detail-modal').classList.add('active');
}

function closeModal() {
    document.getElementById('trip-detail-modal').classList.remove('active');
}

// Perfil
function updateUserProfile() {
    if (!currentUser) return;

    const initials = currentUser.name.substring(0, 2).toUpperCase();
    document.getElementById('user-avatar').textContent = initials;
    document.getElementById('user-name').textContent = currentUser.name;
    document.getElementById('user-email').textContent = currentUser.email;
}

// Utilidades
function formatDate(date) {
    const d = new Date(date);
    const options = { day: '2-digit', month: 'short', year: 'numeric', hour: '2-digit', minute: '2-digit' };
    return d.toLocaleDateString('es-ES', options);
}

function formatDateTime(date) {
    const d = new Date(date);
    const options = { day: '2-digit', month: 'short', year: 'numeric', hour: '2-digit', minute: '2-digit', second: '2-digit' };
    return d.toLocaleDateString('es-ES', options);
}

// Persistencia
function saveUserData() {
    localStorage.setItem('tribugo_user', JSON.stringify(currentUser));
}

function loadUserData() {
    const saved = localStorage.getItem('tribugo_user');
    if (saved) {
        currentUser = JSON.parse(saved);
        showScreen('main-screen');
        updateUserProfile();
        loadTripHistory();
    }
}

function saveTripHistory() {
    localStorage.setItem('tribugo_trips', JSON.stringify(tripHistory));
}

function loadTripHistory() {
    const saved = localStorage.getItem('tribugo_trips');
    if (saved) {
        tripHistory = JSON.parse(saved);
        updateHistoryTab();
    }
}

// Cerrar modal al hacer click fuera
document.addEventListener('click', (e) => {
    const modal = document.getElementById('trip-detail-modal');
    if (e.target === modal) {
        closeModal();
    }
});

// ========================================
// NUEVAS FUNCIONALIDADES AVANZADAS
// ========================================

// Sistema de Notificaciones Toast
function showToast(message, type = 'info', duration = 3000) {
    if (!notifications) return;

    const toast = document.createElement('div');
    toast.className = `toast toast-${type}`;
    toast.innerHTML = `
        <span class="toast-icon">${getToastIcon(type)}</span>
        <span class="toast-message">${message}</span>
    `;

    document.body.appendChild(toast);

    setTimeout(() => toast.classList.add('show'), 10);

    setTimeout(() => {
        toast.classList.remove('show');
        setTimeout(() => toast.remove(), 300);
    }, duration);
}

function getToastIcon(type) {
    const icons = {
        success: '✅',
        error: '❌',
        warning: '⚠️',
        info: 'ℹ️',
        sos: '🚨'
    };
    return icons[type] || 'ℹ️';
}

// GPS Real del Navegador
function requestRealGPS() {
    if (!navigator.geolocation) {
        showToast('Tu navegador no soporta geolocalización', 'error');
        return false;
    }

    showToast('Solicitando acceso a tu ubicación...', 'info');

    navigator.geolocation.getCurrentPosition(
        (position) => {
            useRealGPS = true;
            showToast('GPS real activado ✓', 'success');

            // Actualizar mapa a ubicación real
            if (map) {
                const lat = position.coords.latitude;
                const lng = position.coords.longitude;
                map.setView([lat, lng], 15);

                if (currentMarker) {
                    map.removeLayer(currentMarker);
                }

                currentMarker = L.marker([lat, lng], {
                    icon: L.divIcon({
                        className: 'pulse-marker',
                        html: '<div class="pulse-dot"></div>'
                    })
                }).addTo(map);
            }
        },
        (error) => {
            showToast('No se pudo acceder al GPS: ' + error.message, 'error');
            useRealGPS = false;
        },
        {
            enableHighAccuracy: true,
            timeout: 5000,
            maximumAge: 0
        }
    );
}

// Tracking GPS Real Continuo
function startRealGPSTracking() {
    if (!navigator.geolocation) return;

    watchId = navigator.geolocation.watchPosition(
        (position) => {
            const lat = position.coords.latitude;
            const lng = position.coords.longitude;

            // Actualizar marcador en el mapa
            if (tripMap && currentMarker) {
                currentMarker.setLatLng([lat, lng]);
                tripMap.panTo([lat, lng]);
            }

            // Agregar punto a la ruta
            if (currentTrip && currentTrip.status === 'en_curso') {
                const newPoint = {
                    lat: lat,
                    lng: lng,
                    timestamp: new Date(),
                    accuracy: position.coords.accuracy
                };

                currentTrip.points.push(newPoint);
                routePoints.push([lat, lng]);

                // Actualizar polyline
                if (tripMap) {
                    if (routePolyline) {
                        tripMap.removeLayer(routePolyline);
                    }
                    routePolyline = L.polyline(routePoints, {
                        color: '#007AFF',
                        weight: 4
                    }).addTo(tripMap);
                }
            }
        },
        (error) => {
            console.error('GPS Error:', error);
        },
        {
            enableHighAccuracy: true,
            maximumAge: 5000,
            timeout: 10000
        }
    );
}

function stopRealGPSTracking() {
    if (watchId) {
        navigator.geolocation.clearWatch(watchId);
        watchId = null;
    }
}

// Modo Oscuro
function toggleDarkMode() {
    darkMode = !darkMode;
    document.body.classList.toggle('dark-mode', darkMode);
    localStorage.setItem('tribugo_darkmode', darkMode);
    showToast(darkMode ? 'Modo oscuro activado' : 'Modo claro activado', 'info');
}

function loadDarkMode() {
    const saved = localStorage.getItem('tribugo_darkmode');
    if (saved === 'true') {
        darkMode = true;
        document.body.classList.add('dark-mode');
    }
}

// Compartir Viaje
function shareTrip(tripId) {
    const trip = tripHistory.find(t => t.id == tripId);
    if (!trip) return;

    const duration = trip.endTime
        ? Math.floor((new Date(trip.endTime) - new Date(trip.startTime)) / 1000)
        : 0;
    const minutes = Math.floor(duration / 60);
    const distance = trip.points.length * 50;

    const shareText = `🚗 Viaje TribuGO\n⏱️ Duración: ${minutes} min\n📍 Distancia: ${(distance / 1000).toFixed(2)} km\n${trip.status === 'completado' ? '✅ Completado' : '⚠️ Incidente'}`;

    if (navigator.share) {
        navigator.share({
            title: 'Mi viaje en TribuGO',
            text: shareText,
            url: window.location.href
        }).then(() => {
            showToast('Viaje compartido exitosamente', 'success');
        }).catch(err => {
            copyToClipboard(shareText);
        });
    } else {
        copyToClipboard(shareText);
    }
}

function copyToClipboard(text) {
    navigator.clipboard.writeText(text).then(() => {
        showToast('Información copiada al portapapeles', 'success');
    }).catch(() => {
        showToast('No se pudo copiar', 'error');
    });
}

// Estadísticas Avanzadas
function calculateAdvancedStats() {
    if (tripHistory.length === 0) return null;

    const totalDuration = tripHistory.reduce((sum, trip) => {
        if (!trip.endTime) return sum;
        return sum + (new Date(trip.endTime) - new Date(trip.startTime));
    }, 0);

    const totalDistance = tripHistory.reduce((sum, trip) => {
        return sum + (trip.points.length * 50);
    }, 0);

    const avgSpeed = totalDistance / (totalDuration / 1000); // m/s
    const avgDuration = totalDuration / tripHistory.length;

    const completedTrips = tripHistory.filter(t => t.status === 'completado').length;
    const incidentTrips = tripHistory.filter(t => t.status === 'incidente').length;

    return {
        totalTrips: tripHistory.length,
        totalDistance: totalDistance,
        totalDuration: totalDuration,
        avgSpeed: avgSpeed * 3.6, // km/h
        avgDuration: avgDuration,
        completedTrips: completedTrips,
        incidentTrips: incidentTrips,
        successRate: (completedTrips / tripHistory.length) * 100
    };
}

// Exportar Datos
function exportTripData() {
    const data = {
        user: currentUser,
        trips: tripHistory,
        exportDate: new Date(),
        version: '1.0.0'
    };

    const blob = new Blob([JSON.stringify(data, null, 2)], { type: 'application/json' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `tribugo-data-${Date.now()}.json`;
    a.click();
    URL.revokeObjectURL(url);

    showToast('Datos exportados exitosamente', 'success');
}

// Importar Datos
function importTripData() {
    const input = document.createElement('input');
    input.type = 'file';
    input.accept = 'application/json';

    input.onchange = (e) => {
        const file = e.target.files[0];
        const reader = new FileReader();

        reader.onload = (event) => {
            try {
                const data = JSON.parse(event.target.result);

                if (data.trips && Array.isArray(data.trips)) {
                    tripHistory = data.trips;
                    saveTripHistory();
                    updateHistoryTab();
                    showToast('Datos importados exitosamente', 'success');
                } else {
                    showToast('Archivo inválido', 'error');
                }
            } catch (error) {
                showToast('Error al leer el archivo', 'error');
            }
        };

        reader.readAsText(file);
    };

    input.click();
}

// Limpiar Historial
function clearHistory() {
    if (confirm('⚠️ ¿Estás seguro de eliminar todo el historial?\n\nEsta acción no se puede deshacer.')) {
        tripHistory = [];
        saveTripHistory();
        updateHistoryTab();
        showToast('Historial eliminado', 'success');
    }
}

// Vibración (para móviles)
function vibrate(pattern = [200]) {
    if (navigator.vibrate) {
        navigator.vibrate(pattern);
    }
}

// Sonido de Alerta SOS
function playSOSSound() {
    // Crear un beep simple usando Web Audio API
    const audioContext = new (window.AudioContext || window.webkitAudioContext)();
    const oscillator = audioContext.createOscillator();
    const gainNode = audioContext.createGain();

    oscillator.connect(gainNode);
    gainNode.connect(audioContext.destination);

    oscillator.frequency.value = 800;
    oscillator.type = 'sine';

    gainNode.gain.setValueAtTime(0.3, audioContext.currentTime);
    gainNode.gain.exponentialRampToValueAtTime(0.01, audioContext.currentTime + 0.5);

    oscillator.start(audioContext.currentTime);
    oscillator.stop(audioContext.currentTime + 0.5);
}

// Animación de Confetti (para viajes completados)
function showConfetti() {
    const duration = 3 * 1000;
    const animationEnd = Date.now() + duration;
    const defaults = { startVelocity: 30, spread: 360, ticks: 60, zIndex: 0 };

    function randomInRange(min, max) {
        return Math.random() * (max - min) + min;
    }

    const interval = setInterval(function () {
        const timeLeft = animationEnd - Date.now();

        if (timeLeft <= 0) {
            return clearInterval(interval);
        }

        const particleCount = 50 * (timeLeft / duration);

        // Crear partículas simples con CSS
        for (let i = 0; i < particleCount; i++) {
            createConfettiParticle();
        }
    }, 250);
}

function createConfettiParticle() {
    const particle = document.createElement('div');
    particle.className = 'confetti-particle';
    particle.style.left = Math.random() * 100 + '%';
    particle.style.backgroundColor = ['#007AFF', '#10B981', '#F59E0B', '#EF4444'][Math.floor(Math.random() * 4)];

    document.body.appendChild(particle);

    setTimeout(() => particle.remove(), 3000);
}

// Actualizar funciones existentes con las mejoras
const originalStartTrip = startTrip;
startTrip = function () {
    if (useRealGPS) {
        startRealGPSTracking();
    }
    originalStartTrip();
    showToast('Trayecto iniciado - Viaja seguro', 'success');
    vibrate([100, 50, 100]);
};

const originalActivateSOS = activateSOS;
activateSOS = function () {
    playSOSSound();
    vibrate([200, 100, 200, 100, 200]);
    originalActivateSOS();
};

const originalFinalizarTrayecto = finalizarTrayecto;
finalizarTrayecto = function () {
    stopRealGPSTracking();

    const wasIncident = currentTrip && currentTrip.sosEvents.length > 0;

    originalFinalizarTrayecto();

    if (!wasIncident) {
        showConfetti();
        showToast('¡Viaje completado exitosamente! 🎉', 'success', 4000);
    } else {
        showToast('Viaje finalizado - Incidente registrado', 'warning', 4000);
    }
};

// Cargar configuraciones al iniciar
document.addEventListener('DOMContentLoaded', () => {
    loadDarkMode();

    // Agregar botón de GPS real en la pantalla de inicio
    const bottomCard = document.querySelector('.bottom-card .card-content');
    if (bottomCard) {
        const gpsButton = document.createElement('button');
        gpsButton.className = 'gps-toggle-button';
        gpsButton.innerHTML = '<span class="icon">📡</span> Usar GPS Real';
        gpsButton.onclick = requestRealGPS;
        bottomCard.insertBefore(gpsButton, bottomCard.querySelector('.primary-button'));
    }
});

