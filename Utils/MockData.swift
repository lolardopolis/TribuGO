//
//  MockData.swift
//  TribuGO
//
//  Datos de prueba para desarrollo y previews
//

import Foundation
import CoreLocation

struct MockData {
    // MARK: - Users
    static let sampleUser = User(
        email: "estudiante@universidad.edu",
        name: "Juan Pérez"
    )
    
    static let sampleUsers = [
        User(email: "maria.gonzalez@universidad.edu", name: "María González"),
        User(email: "carlos.rodriguez@universidad.edu", name: "Carlos Rodríguez"),
        User(email: "ana.martinez@universidad.edu", name: "Ana Martínez")
    ]
    
    // MARK: - Location Points
    static let sampleRoute: [LocationPoint] = [
        LocationPoint(latitude: -33.4489, longitude: -70.6693, timestamp: Date().addingTimeInterval(-1800)),
        LocationPoint(latitude: -33.4495, longitude: -70.6700, timestamp: Date().addingTimeInterval(-1680)),
        LocationPoint(latitude: -33.4502, longitude: -70.6708, timestamp: Date().addingTimeInterval(-1560)),
        LocationPoint(latitude: -33.4510, longitude: -70.6715, timestamp: Date().addingTimeInterval(-1440)),
        LocationPoint(latitude: -33.4518, longitude: -70.6722, timestamp: Date().addingTimeInterval(-1320)),
        LocationPoint(latitude: -33.4525, longitude: -70.6730, timestamp: Date().addingTimeInterval(-1200)),
        LocationPoint(latitude: -33.4532, longitude: -70.6738, timestamp: Date().addingTimeInterval(-1080)),
        LocationPoint(latitude: -33.4540, longitude: -70.6745, timestamp: Date().addingTimeInterval(-960)),
        LocationPoint(latitude: -33.4548, longitude: -70.6752, timestamp: Date().addingTimeInterval(-840)),
        LocationPoint(latitude: -33.4555, longitude: -70.6760, timestamp: Date().addingTimeInterval(-720))
    ]
    
    static let shortRoute: [LocationPoint] = [
        LocationPoint(latitude: -33.4489, longitude: -70.6693, timestamp: Date().addingTimeInterval(-300)),
        LocationPoint(latitude: -33.4495, longitude: -70.6700, timestamp: Date().addingTimeInterval(-240)),
        LocationPoint(latitude: -33.4502, longitude: -70.6708, timestamp: Date().addingTimeInterval(-180))
    ]
    
    // MARK: - SOS Events
    static let sampleSOSEvent = SOSEvent(
        tripId: UUID(),
        latitude: -33.4510,
        longitude: -70.6715,
        timestamp: Date().addingTimeInterval(-900),
        notes: "Situación de emergencia reportada"
    )
    
    static let sampleSOSEvents = [
        SOSEvent(
            tripId: UUID(),
            latitude: -33.4510,
            longitude: -70.6715,
            timestamp: Date().addingTimeInterval(-900)
        )
    ]
    
    // MARK: - Trips
    static let completedTrip = Trip(
        userId: sampleUser.id,
        startTime: Date().addingTimeInterval(-1800),
        endTime: Date().addingTimeInterval(-720),
        status: .completado,
        points: sampleRoute,
        sosEvents: []
    )
    
    static let incidentTrip = Trip(
        userId: sampleUser.id,
        startTime: Date().addingTimeInterval(-3600),
        endTime: Date().addingTimeInterval(-2400),
        status: .incidente,
        points: sampleRoute,
        sosEvents: sampleSOSEvents
    )
    
    static let activeTrip = Trip(
        userId: sampleUser.id,
        startTime: Date().addingTimeInterval(-600),
        endTime: nil,
        status: .enCurso,
        points: shortRoute,
        sosEvents: []
    )
    
    static let sampleTrips: [Trip] = [
        // Viaje de hoy - completado
        Trip(
            userId: sampleUser.id,
            startTime: Date().addingTimeInterval(-7200),
            endTime: Date().addingTimeInterval(-5400),
            status: .completado,
            points: sampleRoute,
            sosEvents: []
        ),
        
        // Viaje de ayer - con incidente
        Trip(
            userId: sampleUser.id,
            startTime: Date().addingTimeInterval(-93600),
            endTime: Date().addingTimeInterval(-91800),
            status: .incidente,
            points: sampleRoute,
            sosEvents: [
                SOSEvent(
                    tripId: UUID(),
                    latitude: -33.4518,
                    longitude: -70.6722,
                    timestamp: Date().addingTimeInterval(-92400)
                )
            ]
        ),
        
        // Viaje de hace 2 días - completado
        Trip(
            userId: sampleUser.id,
            startTime: Date().addingTimeInterval(-180000),
            endTime: Date().addingTimeInterval(-178200),
            status: .completado,
            points: sampleRoute,
            sosEvents: []
        ),
        
        // Viaje de hace 3 días - completado
        Trip(
            userId: sampleUser.id,
            startTime: Date().addingTimeInterval(-266400),
            endTime: Date().addingTimeInterval(-264600),
            status: .completado,
            points: shortRoute,
            sosEvents: []
        ),
        
        // Viaje de hace 1 semana - completado
        Trip(
            userId: sampleUser.id,
            startTime: Date().addingTimeInterval(-604800),
            endTime: Date().addingTimeInterval(-603000),
            status: .completado,
            points: sampleRoute,
            sosEvents: []
        )
    ]
    
    // MARK: - Coordenadas de referencia (Santiago, Chile)
    static let campusLocation = CLLocationCoordinate2D(
        latitude: -33.4555,
        longitude: -70.6760
    )
    
    static let homeLocation = CLLocationCoordinate2D(
        latitude: -33.4489,
        longitude: -70.6693
    )
    
    static let emergencyLocation = CLLocationCoordinate2D(
        latitude: -33.4518,
        longitude: -70.6722
    )
    
    // MARK: - Helper Methods
    
    /// Genera una ruta aleatoria entre dos puntos
    static func generateRoute(
        from start: CLLocationCoordinate2D,
        to end: CLLocationCoordinate2D,
        points: Int = 10
    ) -> [LocationPoint] {
        var route: [LocationPoint] = []
        let latStep = (end.latitude - start.latitude) / Double(points)
        let lngStep = (end.longitude - start.longitude) / Double(points)
        
        for i in 0...points {
            let lat = start.latitude + (latStep * Double(i))
            let lng = start.longitude + (lngStep * Double(i))
            let timestamp = Date().addingTimeInterval(-Double(points - i) * 60)
            
            route.append(LocationPoint(
                latitude: lat,
                longitude: lng,
                timestamp: timestamp
            ))
        }
        
        return route
    }
    
    /// Genera un viaje aleatorio
    static func generateRandomTrip(userId: UUID) -> Trip {
        let statuses: [TripStatus] = [.completado, .completado, .completado, .incidente]
        let status = statuses.randomElement() ?? .completado
        
        let startTime = Date().addingTimeInterval(-Double.random(in: 3600...86400))
        let duration = Double.random(in: 600...3600)
        let endTime = startTime.addingTimeInterval(duration)
        
        let route = generateRoute(
            from: homeLocation,
            to: campusLocation,
            points: Int.random(in: 5...15)
        )
        
        var sosEvents: [SOSEvent] = []
        if status == .incidente {
            let randomPoint = route.randomElement()!
            sosEvents.append(SOSEvent(
                tripId: UUID(),
                latitude: randomPoint.latitude,
                longitude: randomPoint.longitude,
                timestamp: randomPoint.timestamp
            ))
        }
        
        return Trip(
            userId: userId,
            startTime: startTime,
            endTime: endTime,
            status: status,
            points: route,
            sosEvents: sosEvents
        )
    }
    
    /// Genera múltiples viajes aleatorios
    static func generateRandomTrips(count: Int, userId: UUID) -> [Trip] {
        return (0..<count).map { _ in generateRandomTrip(userId: userId) }
    }
}

// MARK: - Preview Helpers
#if DEBUG
extension TripViewModel {
    static var preview: TripViewModel {
        let viewModel = TripViewModel()
        viewModel.tripHistory = MockData.sampleTrips
        return viewModel
    }
    
    static var previewWithActiveTrip: TripViewModel {
        let viewModel = TripViewModel()
        viewModel.currentTrip = MockData.activeTrip
        viewModel.tripHistory = MockData.sampleTrips
        return viewModel
    }
}

extension AuthViewModel {
    static var preview: AuthViewModel {
        let viewModel = AuthViewModel()
        viewModel.currentUser = MockData.sampleUser
        viewModel.isAuthenticated = true
        return viewModel
    }
}

extension LocationManager {
    static var preview: LocationManager {
        let manager = LocationManager()
        manager.currentLocation = CLLocation(
            latitude: MockData.homeLocation.latitude,
            longitude: MockData.homeLocation.longitude
        )
        manager.routePoints = MockData.shortRoute
        manager.isTracking = true
        return manager
    }
}
#endif
