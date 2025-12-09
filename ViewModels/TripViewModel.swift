//
//  TripViewModel.swift
//  TribuGO
//
//  ViewModel para gestión de trayectos
//

import Foundation
import CoreLocation
import SwiftUI

class TripViewModel: ObservableObject {
    @Published var currentTrip: Trip?
    @Published var tripHistory: [Trip] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let tripsKey = "TribuGO_Trips"
    private let currentTripKey = "TribuGO_CurrentTrip"
    
    init() {
        loadTrips()
        loadCurrentTrip()
    }
    
    // MARK: - Gestión de trayecto actual
    
    // Iniciar nuevo trayecto
    func startTrip(userId: UUID, initialLocation: CLLocationCoordinate2D) {
        let initialPoint = LocationPoint(coordinate: initialLocation)
        let trip = Trip(
            userId: userId,
            startTime: Date(),
            status: .enCurso,
            points: [initialPoint]
        )
        
        currentTrip = trip
        saveCurrentTrip()
    }
    
    // Agregar punto a la ruta
    func addLocationPoint(_ point: LocationPoint) {
        guard var trip = currentTrip else { return }
        trip.points.append(point)
        currentTrip = trip
        saveCurrentTrip()
    }
    
    // Registrar evento SOS
    func registerSOSEvent(location: CLLocationCoordinate2D) {
        guard var trip = currentTrip else { return }
        
        let sosEvent = SOSEvent(
            tripId: trip.id,
            coordinate: location,
            timestamp: Date()
        )
        
        trip.sosEvents.append(sosEvent)
        trip.status = .incidente
        currentTrip = trip
        saveCurrentTrip()
    }
    
    // Finalizar trayecto
    func endTrip() {
        guard var trip = currentTrip else { return }
        
        trip.endTime = Date()
        
        // Si no hay eventos SOS, marcar como completado
        if trip.sosEvents.isEmpty {
            trip.status = .completado
        }
        
        // Guardar en historial
        tripHistory.insert(trip, at: 0)
        saveTrips()
        
        // Limpiar trayecto actual
        currentTrip = nil
        UserDefaults.standard.removeObject(forKey: currentTripKey)
    }
    
    // Cancelar trayecto
    func cancelTrip() {
        currentTrip = nil
        UserDefaults.standard.removeObject(forKey: currentTripKey)
    }
    
    // MARK: - Persistencia
    
    private func saveCurrentTrip() {
        guard let trip = currentTrip,
              let encoded = try? JSONEncoder().encode(trip) else { return }
        UserDefaults.standard.set(encoded, forKey: currentTripKey)
    }
    
    private func loadCurrentTrip() {
        guard let data = UserDefaults.standard.data(forKey: currentTripKey),
              let trip = try? JSONDecoder().decode(Trip.self, from: data) else { return }
        currentTrip = trip
    }
    
    private func saveTrips() {
        guard let encoded = try? JSONEncoder().encode(tripHistory) else { return }
        UserDefaults.standard.set(encoded, forKey: tripsKey)
    }
    
    private func loadTrips() {
        guard let data = UserDefaults.standard.data(forKey: tripsKey),
              let trips = try? JSONDecoder().decode([Trip].self, from: data) else { return }
        tripHistory = trips
    }
    
    // MARK: - Utilidades
    
    // Obtener trayecto por ID
    func getTrip(id: UUID) -> Trip? {
        tripHistory.first { $0.id == id }
    }
    
    // Estadísticas
    var totalTrips: Int {
        tripHistory.count
    }
    
    var totalDistance: Double {
        tripHistory.reduce(0) { $0 + $1.estimatedDistance }
    }
    
    var totalSOSEvents: Int {
        tripHistory.reduce(0) { $0 + $1.sosEvents.count }
    }
}
