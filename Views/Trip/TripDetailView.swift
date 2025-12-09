//
//  TripDetailView.swift
//  TribuGO
//
//  Vista de detalle de un trayecto específico
//

import SwiftUI
import MapKit

struct TripDetailView: View {
    let trip: Trip
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Mapa con la ruta completa
                MapView(
                    locationPoints: trip.points,
                    currentLocation: trip.points.last.map { 
                        CLLocation(latitude: $0.latitude, longitude: $0.longitude)
                    },
                    sosEvents: trip.sosEvents
                )
                .frame(height: 300)
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Información del trayecto
                VStack(spacing: 16) {
                    // Estado
                    HStack {
                        Image(systemName: trip.status.icon)
                            .foregroundColor(statusColor)
                        Text(trip.status.displayName)
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding()
                    .background(statusColor.opacity(0.1))
                    .cornerRadius(12)
                    
                    // Estadísticas principales
                    HStack(spacing: 12) {
                        DetailStatCard(
                            icon: "clock.fill",
                            title: "Duración",
                            value: trip.formattedDuration
                        )
                        
                        DetailStatCard(
                            icon: "map.fill",
                            title: "Distancia",
                            value: trip.formattedDistance
                        )
                    }
                    
                    HStack(spacing: 12) {
                        DetailStatCard(
                            icon: "location.fill",
                            title: "Puntos GPS",
                            value: "\(trip.points.count)"
                        )
                        
                        DetailStatCard(
                            icon: "exclamationmark.triangle.fill",
                            title: "Eventos SOS",
                            value: "\(trip.sosEvents.count)",
                            color: trip.hasSOSEvents ? .red : .gray
                        )
                    }
                    
                    // Fechas
                    VStack(spacing: 12) {
                        DetailRow(
                            icon: "calendar",
                            title: "Inicio",
                            value: formatDateTime(trip.startTime)
                        )
                        
                        if let endTime = trip.endTime {
                            DetailRow(
                                icon: "calendar.badge.checkmark",
                                title: "Fin",
                                value: formatDateTime(endTime)
                            )
                        }
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    
                    // Eventos SOS (si existen)
                    if !trip.sosEvents.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.red)
                                Text("Eventos de Emergencia")
                                    .font(.headline)
                            }
                            
                            ForEach(trip.sosEvents) { event in
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(event.formattedTime)
                                            .font(.subheadline)
                                        Text("Lat: \(event.latitude, specifier: "%.6f"), Lng: \(event.longitude, specifier: "%.6f")")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                }
                                .padding()
                                .background(Color.red.opacity(0.1))
                                .cornerRadius(8)
                            }
                        }
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                    }
                    
                    // Información adicional
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Información del Trayecto")
                            .font(.headline)
                        
                        Text("ID: \(trip.id.uuidString)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        if trip.points.count > 0 {
                            Text("Frecuencia de tracking: ~\(calculateTrackingFrequency()) segundos")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle("Detalle del Trayecto")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var statusColor: Color {
        switch trip.status {
        case .completado: return .green
        case .incidente: return .red
        case .enCurso: return .blue
        }
    }
    
    private func formatDateTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter.string(from: date)
    }
    
    private func calculateTrackingFrequency() -> Int {
        guard trip.points.count > 1 else { return 0 }
        let totalTime = trip.duration
        let intervals = Double(trip.points.count - 1)
        return Int(totalTime / intervals)
    }
}

// Card de estadística detallada
struct DetailStatCard: View {
    let icon: String
    let title: String
    let value: String
    var color: Color = .blue
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.headline)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
    }
}

// Fila de detalle
struct DetailRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 24)
            
            Text(title)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(value)
                .fontWeight(.medium)
        }
    }
}

#Preview {
    NavigationStack {
        TripDetailView(trip: Trip(
            userId: UUID(),
            startTime: Date().addingTimeInterval(-3600),
            endTime: Date(),
            status: .completado,
            points: [
                LocationPoint(latitude: -33.4489, longitude: -70.6693),
                LocationPoint(latitude: -33.4500, longitude: -70.6700)
            ]
        ))
    }
}
