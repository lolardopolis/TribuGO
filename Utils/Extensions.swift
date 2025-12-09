//
//  Extensions.swift
//  TribuGO
//
//  Extensiones útiles para la aplicación
//

import Foundation
import SwiftUI

// MARK: - Date Extensions
extension Date {
    /// Formatea la fecha en formato corto
    func shortFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
    
    /// Formatea la fecha en formato largo
    func longFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        return formatter.string(from: self)
    }
    
    /// Obtiene el tiempo relativo (ej: "hace 5 minutos")
    func relativeFormat() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}

// MARK: - String Extensions
extension String {
    /// Valida si es un email válido
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    /// Obtiene las iniciales de un nombre
    var initials: String {
        let components = self.components(separatedBy: " ")
        let initials = components.compactMap { $0.first }.map { String($0) }
        return initials.joined().uppercased()
    }
}

// MARK: - Double Extensions
extension Double {
    /// Formatea metros a kilómetros o metros según la magnitud
    func formatDistance() -> String {
        if self < 1000 {
            return String(format: "%.0f m", self)
        } else {
            return String(format: "%.2f km", self / 1000)
        }
    }
}

// MARK: - View Extensions
extension View {
    /// Aplica un modificador condicional
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    /// Oculta el teclado
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// MARK: - TimeInterval Extensions
extension TimeInterval {
    /// Formatea el intervalo de tiempo en formato HH:MM:SS
    func formatDuration() -> String {
        let hours = Int(self) / 3600
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
}

// MARK: - Array Extensions
extension Array where Element == LocationPoint {
    /// Calcula la distancia total de una ruta
    var totalDistance: Double {
        guard count > 1 else { return 0 }
        
        var distance: Double = 0
        for i in 0..<(count - 1) {
            let start = CLLocation(latitude: self[i].latitude, longitude: self[i].longitude)
            let end = CLLocation(latitude: self[i + 1].latitude, longitude: self[i + 1].longitude)
            distance += start.distance(from: end)
        }
        return distance
    }
}

import CoreLocation

// MARK: - CLLocationCoordinate2D Extensions
extension CLLocationCoordinate2D {
    /// Verifica si las coordenadas son válidas
    var isValid: Bool {
        return latitude >= -90 && latitude <= 90 && longitude >= -180 && longitude <= 180
    }
}
