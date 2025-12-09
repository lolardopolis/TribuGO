//
//  LocationManager.swift
//  TribuGO
//
//  Gestor de ubicación GPS con tracking en tiempo real
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var currentLocation: CLLocation?
    @Published var isTracking = false
    @Published var errorMessage: String?
    
    // Puntos de la ruta actual
    @Published var routePoints: [LocationPoint] = []
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10 // Actualizar cada 10 metros
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        
        authorizationStatus = locationManager.authorizationStatus
    }
    
    // Solicitar permisos
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    // Iniciar tracking
    func startTracking() {
        guard authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways else {
            errorMessage = "Necesitas otorgar permisos de ubicación"
            requestPermission()
            return
        }
        
        routePoints.removeAll()
        locationManager.startUpdatingLocation()
        isTracking = true
        errorMessage = nil
    }
    
    // Detener tracking
    func stopTracking() {
        locationManager.stopUpdatingLocation()
        isTracking = false
    }
    
    // Obtener ubicación actual una vez
    func getCurrentLocation() {
        locationManager.requestLocation()
    }
    
    // Limpiar ruta
    func clearRoute() {
        routePoints.removeAll()
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        DispatchQueue.main.async {
            self.currentLocation = location
            
            // Si estamos tracking, agregar punto a la ruta
            if self.isTracking {
                let point = LocationPoint(
                    latitude: location.coordinate.latitude,
                    longitude: location.coordinate.longitude,
                    timestamp: location.timestamp
                )
                self.routePoints.append(point)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.errorMessage = "Error al obtener ubicación: \(error.localizedDescription)"
        }
    }
}
