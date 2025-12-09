//
//  ActiveTripView.swift
//  TribuGO
//
//  Vista de trayecto en curso con mapa y botón SOS
//

import SwiftUI
import MapKit

struct ActiveTripView: View {
    @EnvironmentObject var tripViewModel: TripViewModel
    @EnvironmentObject var locationManager: LocationManager
    @Environment(\.dismiss) var dismiss
    
    @State private var showSOSAlert = false
    @State private var showEndTripAlert = false
    @State private var showQRScanner = false
    @State private var elapsedTime: TimeInterval = 0
    @State private var timer: Timer?
    
    var body: some View {
        ZStack {
            // Mapa con ruta
            MapView(
                locationPoints: locationManager.routePoints,
                currentLocation: locationManager.currentLocation,
                sosEvents: tripViewModel.currentTrip?.sosEvents ?? []
            )
            .ignoresSafeArea()
            
            // Overlay superior con información
            VStack {
                // Card de información del viaje
                VStack(spacing: 12) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Trayecto en curso")
                                .font(.headline)
                            Text("Estás siendo monitoreado")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        // Indicador de tracking activo
                        HStack(spacing: 4) {
                            Circle()
                                .fill(Color.green)
                                .frame(width: 8, height: 8)
                            Text("GPS Activo")
                                .font(.caption)
                                .foregroundColor(.green)
                        }
                    }
                    
                    Divider()
                    
                    // Estadísticas del viaje
                    HStack(spacing: 20) {
                        StatItem(
                            icon: "clock.fill",
                            value: formatTime(elapsedTime),
                            label: "Tiempo"
                        )
                        
                        StatItem(
                            icon: "location.fill",
                            value: "\(locationManager.routePoints.count)",
                            label: "Puntos"
                        )
                        
                        if let trip = tripViewModel.currentTrip {
                            StatItem(
                                icon: "map.fill",
                                value: trip.formattedDistance,
                                label: "Distancia"
                            )
                        }
                    }
                }
                .padding()
                .background(Color(UIColor.systemBackground))
                .cornerRadius(16)
                .shadow(radius: 5)
                .padding()
                
                Spacer()
                
                // Botones de acción
                VStack(spacing: 16) {
                    // Botón SOS
                    Button(action: { showSOSAlert = true }) {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.title2)
                            Text("EMERGENCIA SOS")
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                        .shadow(color: .red.opacity(0.3), radius: 10)
                    }
                    
                    HStack(spacing: 12) {
                        // Botón de finalizar
                        Button(action: { showEndTripAlert = true }) {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                Text("He llegado")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                        }
                        
                        // Botón de QR
                        Button(action: { showQRScanner = true }) {
                            HStack {
                                Image(systemName: "qrcode.viewfinder")
                                Text("Escanear QR")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                        }
                    }
                }
                .padding()
                .background(Color(UIColor.systemBackground).opacity(0.95))
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    // No permitir volver atrás durante un viaje activo
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.gray.opacity(0.3))
                }
                .disabled(true)
            }
        }
        .alert("🚨 Emergencia SOS", isPresented: $showSOSAlert) {
            Button("Cancelar", role: .cancel) { }
            Button("Activar SOS", role: .destructive) {
                activateSOS()
            }
        } message: {
            Text("Se registrará tu ubicación actual y se enviará una alerta a la institución. ¿Estás seguro?")
        }
        .alert("Finalizar Trayecto", isPresented: $showEndTripAlert) {
            Button("Cancelar", role: .cancel) { }
            Button("Finalizar") {
                endTrip()
            }
        } message: {
            Text("¿Has llegado al campus? Se guardará tu trayecto en el historial.")
        }
        .sheet(isPresented: $showQRScanner) {
            QRScannerView { code in
                // Simular escaneo exitoso
                showQRScanner = false
                endTrip()
            }
        }
        .onAppear {
            startTimer()
            // Sincronizar puntos del LocationManager con el Trip
            syncLocationPoints()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if let startTime = tripViewModel.currentTrip?.startTime {
                elapsedTime = Date().timeIntervalSince(startTime)
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func syncLocationPoints() {
        // Timer para sincronizar puntos cada 5 segundos
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            if let lastPoint = locationManager.routePoints.last {
                tripViewModel.addLocationPoint(lastPoint)
            }
        }
    }
    
    private func activateSOS() {
        guard let location = locationManager.currentLocation else { return }
        tripViewModel.registerSOSEvent(location: location.coordinate)
    }
    
    private func endTrip() {
        locationManager.stopTracking()
        tripViewModel.endTrip()
        stopTimer()
        dismiss()
    }
    
    private func formatTime(_ interval: TimeInterval) -> String {
        let hours = Int(interval) / 3600
        let minutes = Int(interval) / 60 % 60
        let seconds = Int(interval) % 60
        
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
}

// Vista de estadística individual
struct StatItem: View {
    let icon: String
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .foregroundColor(.blue)
            Text(value)
                .font(.headline)
            Text(label)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationStack {
        ActiveTripView()
            .environmentObject(TripViewModel())
            .environmentObject(LocationManager())
    }
}
