//
//  HistoryView.swift
//  TribuGO
//
//  Vista de historial de trayectos
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var tripViewModel: TripViewModel
    @State private var selectedTrip: Trip?
    
    var body: some View {
        NavigationStack {
            ZStack {
                if tripViewModel.tripHistory.isEmpty {
                    // Estado vacío
                    VStack(spacing: 20) {
                        Image(systemName: "clock.badge.questionmark")
                            .font(.system(size: 80))
                            .foregroundColor(.gray.opacity(0.5))
                        
                        Text("No hay trayectos registrados")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("Tus viajes al campus aparecerán aquí")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                } else {
                    List {
                        // Resumen estadístico
                        Section {
                            VStack(spacing: 16) {
                                HStack(spacing: 20) {
                                    StatCard(
                                        icon: "car.fill",
                                        value: "\(tripViewModel.totalTrips)",
                                        label: "Viajes"
                                    )
                                    
                                    StatCard(
                                        icon: "map.fill",
                                        value: formatDistance(tripViewModel.totalDistance),
                                        label: "Distancia"
                                    )
                                    
                                    StatCard(
                                        icon: "exclamationmark.triangle.fill",
                                        value: "\(tripViewModel.totalSOSEvents)",
                                        label: "SOS",
                                        color: tripViewModel.totalSOSEvents > 0 ? .red : .gray
                                    )
                                }
                            }
                            .padding(.vertical, 8)
                        }
                        .listRowBackground(Color.clear)
                        
                        // Lista de trayectos
                        Section("Trayectos recientes") {
                            ForEach(tripViewModel.tripHistory) { trip in
                                NavigationLink(destination: TripDetailView(trip: trip)) {
                                    TripRowView(trip: trip)
                                }
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Historial")
            .toolbar {
                if !tripViewModel.tripHistory.isEmpty {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Button(action: {}) {
                                Label("Exportar datos", systemImage: "square.and.arrow.up")
                            }
                            Button(role: .destructive, action: {}) {
                                Label("Limpiar historial", systemImage: "trash")
                            }
                        } label: {
                            Image(systemName: "ellipsis.circle")
                        }
                    }
                }
            }
        }
    }
    
    private func formatDistance(_ meters: Double) -> String {
        let km = meters / 1000
        if km < 1 {
            return String(format: "%.0fm", meters)
        } else {
            return String(format: "%.1fkm", km)
        }
    }
}

// Vista de fila de trayecto
struct TripRowView: View {
    let trip: Trip
    
    var body: some View {
        HStack(spacing: 12) {
            // Icono de estado
            ZStack {
                Circle()
                    .fill(statusColor.opacity(0.2))
                    .frame(width: 50, height: 50)
                
                Image(systemName: trip.status.icon)
                    .foregroundColor(statusColor)
                    .font(.title3)
            }
            
            // Información del viaje
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(formatDate(trip.startTime))
                        .font(.headline)
                    
                    if trip.hasSOSEvents {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                
                HStack(spacing: 12) {
                    Label(trip.formattedDuration, systemImage: "clock")
                    Label(trip.formattedDistance, systemImage: "map")
                }
                .font(.caption)
                .foregroundColor(.secondary)
                
                Text(trip.status.displayName)
                    .font(.caption)
                    .foregroundColor(statusColor)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray.opacity(0.5))
                .font(.caption)
        }
        .padding(.vertical, 4)
    }
    
    private var statusColor: Color {
        switch trip.status {
        case .completado: return .green
        case .incidente: return .red
        case .enCurso: return .blue
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

// Card de estadística
struct StatCard: View {
    let icon: String
    let value: String
    let label: String
    var color: Color = .blue
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
            
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    HistoryView()
        .environmentObject(TripViewModel())
}
