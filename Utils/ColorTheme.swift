//
//  ColorTheme.swift
//  TribuGO
//
//  Tema de colores de la aplicación
//

import SwiftUI

extension Color {
    // Colores principales de TribuGO
    static let tribuPrimary = Color.blue
    static let tribuSecondary = Color.purple
    static let tribuAccent = Color.cyan
    
    // Colores de estado
    static let tribuSuccess = Color.green
    static let tribuWarning = Color.orange
    static let tribuDanger = Color.red
    
    // Colores de fondo
    static let tribuBackground = Color(UIColor.systemBackground)
    static let tribuSecondaryBackground = Color(UIColor.secondarySystemBackground)
    
    // Gradientes
    static let tribuGradient = LinearGradient(
        colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.6)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let sosGradient = LinearGradient(
        colors: [Color.red, Color.orange],
        startPoint: .leading,
        endPoint: .trailing
    )
}

// Extensión para crear colores desde hex
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
