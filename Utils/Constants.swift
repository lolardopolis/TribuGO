//
//  Constants.swift
//  TribuGO
//
//  Constantes de la aplicación
//

import Foundation
import CoreLocation

struct AppConstants {
    // MARK: - App Info
    static let appName = "TribuGO"
    static let appVersion = "1.0.0"
    static let appBuild = "1"
    static let appStage = "Prototipo"
    
    // MARK: - GPS Tracking
    struct Tracking {
        /// Intervalo de actualización de ubicación (segundos)
        static let updateInterval: TimeInterval = 5.0
        
        /// Distancia mínima para actualizar (metros)
        static let minimumDistance: CLLocationDistance = 10.0
        
        /// Precisión deseada para GPS
        static let desiredAccuracy = kCLLocationAccuracyBest
        
        /// Precisión para ahorro de batería
        static let batterySavingAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    // MARK: - Storage Keys
    struct StorageKeys {
        static let currentUser = "TribuGO_CurrentUser"
        static let currentTrip = "TribuGO_CurrentTrip"
        static let tripHistory = "TribuGO_Trips"
        static let userPreferences = "TribuGO_Preferences"
    }
    
    // MARK: - UI Constants
    struct UI {
        /// Radio de esquinas por defecto
        static let cornerRadius: CGFloat = 12.0
        
        /// Padding estándar
        static let standardPadding: CGFloat = 16.0
        
        /// Duración de animaciones
        static let animationDuration: Double = 0.3
        
        /// Tamaño del botón SOS
        static let sosButtonSize: CGFloat = 60.0
    }
    
    // MARK: - Map Settings
    struct Map {
        /// Span por defecto del mapa (zoom)
        static let defaultSpan = 0.01
        
        /// Span amplio para vista general
        static let wideSpan = 0.05
        
        /// Grosor de la línea de ruta
        static let routeLineWidth: CGFloat = 4.0
    }
    
    // MARK: - Validation
    struct Validation {
        /// Dominios de email institucional aceptados (para producción)
        static let allowedEmailDomains = [
            "universidad.edu",
            "estudiantes.edu",
            "campus.edu"
        ]
        
        /// Longitud mínima de contraseña
        static let minimumPasswordLength = 6
    }
    
    // MARK: - API (para futuro)
    struct API {
        #if DEBUG
        static let baseURL = "https://api-dev.tribugo.com"
        #else
        static let baseURL = "https://api.tribugo.com"
        #endif
        
        static let timeout: TimeInterval = 30.0
    }
    
    // MARK: - Features Flags
    struct Features {
        /// Habilitar tracking en background
        static let backgroundTracking = true
        
        /// Habilitar escáner QR real (vs simulado)
        static let realQRScanner = false
        
        /// Habilitar notificaciones push
        static let pushNotifications = false
        
        /// Habilitar modo debug
        #if DEBUG
        static let debugMode = true
        #else
        static let debugMode = false
        #endif
    }
    
    // MARK: - Messages
    struct Messages {
        // Mensajes de éxito
        static let tripStarted = "Trayecto iniciado correctamente"
        static let tripEnded = "Trayecto finalizado y guardado"
        static let sosActivated = "Alerta SOS enviada a la institución"
        
        // Mensajes de error
        static let locationPermissionDenied = "Necesitas otorgar permisos de ubicación para usar TribuGO"
        static let locationUnavailable = "No se pudo obtener tu ubicación actual"
        static let noActiveTrip = "No hay un trayecto activo"
        
        // Mensajes informativos
        static let loginWelcome = "Bienvenido a TribuGO"
        static let noTripsYet = "Aún no has realizado ningún trayecto"
    }
}

// MARK: - Notification Names
extension Notification.Name {
    static let tripStarted = Notification.Name("TribuGO.tripStarted")
    static let tripEnded = Notification.Name("TribuGO.tripEnded")
    static let sosActivated = Notification.Name("TribuGO.sosActivated")
    static let locationUpdated = Notification.Name("TribuGO.locationUpdated")
}
