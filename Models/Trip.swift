//
//  Trip.swift
//  TribuGO
//
//  Modelo de datos para trayecto
//

import Foundation
import CoreLocation

// Punto de ubicación en la ruta
struct LocationPoint: Identifiable, Codable, Equatable {
    let id: UUID
    let latitude: Double
    let longitude: Double
    let timestamp: Date
    
    init(id: UUID = UUID(), latitude: Double, longitude: Double, timestamp: Date = Date()) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.timestamp = timestamp
    }
    
    init(coordinate: CLLocationCoordinate2D, timestamp: Date = Date()) {
        self.id = UUID()
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
        self.timestamp = timestamp
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

// Estado del trayecto
enum TripStatus: String, Codable {
    case enCurso = "en_curso"
    case completado = "completado"
    case incidente = "incidente"
    
    var displayName: String {
        switch self {
        case .enCurso: return "En curso"
        case .completado: return "Completado"
        case .incidente: return "Incidente"
        }
    }
    
    var icon: String {
        switch self {
        case .enCurso: return "location.fill"
        case .completado: return "checkmark.circle.fill"
        case .incidente: return "exclamationmark.triangle.fill"
        }
    }
}

// Modelo principal de trayecto
struct Trip: Identifiable, Codable {
    let id: UUID
    let userId: UUID
    let startTime: Date
    var endTime: Date?
    var status: TripStatus
    var points: [LocationPoint]
    var sosEvents: [SOSEvent]
    
    init(
        id: UUID = UUID(),
        userId: UUID,
        startTime: Date = Date(),
        endTime: Date? = nil,
        status: TripStatus = .enCurso,
        points: [LocationPoint] = [],
        sosEvents: [SOSEvent] = []
    ) {
        self.id = id
        self.userId = userId
        self.startTime = startTime
        self.endTime = endTime
        self.status = status
        self.points = points
        self.sosEvents = sosEvents
    }
    
    // Duración del trayecto
    var duration: TimeInterval {
        let end = endTime ?? Date()
        return end.timeIntervalSince(startTime)
    }
    
    // Duración formateada
    var formattedDuration: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: duration) ?? "0s"
    }
    
    // Distancia aproximada (suma de segmentos)
    var estimatedDistance: Double {
        guard points.count > 1 else { return 0 }
        
        var distance: Double = 0
        for i in 0..<(points.count - 1) {
            let start = CLLocation(latitude: points[i].latitude, longitude: points[i].longitude)
            let end = CLLocation(latitude: points[i + 1].latitude, longitude: points[i + 1].longitude)
            distance += start.distance(from: end)
        }
        return distance
    }
    
    // Distancia formateada
    var formattedDistance: String {
        let km = estimatedDistance / 1000
        if km < 1 {
            return String(format: "%.0f m", estimatedDistance)
        } else {
            return String(format: "%.2f km", km)
        }
    }
    
    // Tiene incidentes SOS
    var hasSOSEvents: Bool {
        !sosEvents.isEmpty
    }
}
