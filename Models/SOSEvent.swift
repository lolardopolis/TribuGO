//
//  SOSEvent.swift
//  TribuGO
//
//  Modelo de datos para eventos SOS
//

import Foundation
import CoreLocation

struct SOSEvent: Identifiable, Codable, Equatable {
    let id: UUID
    let tripId: UUID
    let latitude: Double
    let longitude: Double
    let timestamp: Date
    var notes: String?
    
    init(
        id: UUID = UUID(),
        tripId: UUID,
        latitude: Double,
        longitude: Double,
        timestamp: Date = Date(),
        notes: String? = nil
    ) {
        self.id = id
        self.tripId = tripId
        self.latitude = latitude
        self.longitude = longitude
        self.timestamp = timestamp
        self.notes = notes
    }
    
    init(tripId: UUID, coordinate: CLLocationCoordinate2D, timestamp: Date = Date(), notes: String? = nil) {
        self.id = UUID()
        self.tripId = tripId
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
        self.timestamp = timestamp
        self.notes = notes
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter.string(from: timestamp)
    }
}
