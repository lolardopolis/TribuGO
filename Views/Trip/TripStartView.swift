//
//  TripStartView.swift
//  TribuGO
//
//  Pantalla de inicio de trayecto
//

import SwiftUI
import MapKit

struct TripStartView: View {
    @EnvironmentObject var tripViewModel: TripViewModel
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showingActiveTripView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Mapa de fondo
                if let location = locationManager.currentLocation {
                    Map(position: .constant(.region(MKCoordinateRegion(
                        center: location.coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    ))))
                    .ignoresSafeArea()
                } else {
                    Color.gray.opacity(0.2)
                        .ignoresSafeArea()
                }
                
                // Overlay con controles
                VStack {
                    Spacer()
                    
                    // Card principal
                    VStack(spacing: 24) {
                        // Icono y título
                        VStack(spacing: 12) {
                            Image(systemName: "location.circle.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.blue)
                            
                            Text("¿Listo para viajar?")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text("Inicia tu trayecto al campus para que podamos monitorear tu seguridad")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        
                        // Botón de inicio
                        Button(action: startTrip) {
                            HStack {
                                Image(systemName: "play.circle.fill")
                                    .font(.title3)
                                Text("Iniciar Trayecto al Campus")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                        }
                        .padding(.horizontal)
                        
                        // Estado de permisos
                        if locationManager.authorizationStatus == .notDetermined {
                            HStack {
                                Image(systemName: "info.circle.fill")
                                    .foregroundColor(.orange)
                                Text("Necesitamos acceso a tu ubicación")
                                    .font(.caption)
                            }
                            .padding()
                            .background(Color.orange.opacity(0.1))
                            .cornerRadius(8)
                            .padding(.horizontal)
                        } else if locationManager.authorizationStatus == .denied {
                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.red)
                                Text("Permisos de ubicación denegados")
                                    .font(.caption)
                            }
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(8)
                            .padding(.horizontal)
                        }
                        
                        // Información adicional
                        VStack(spacing: 8) {
                            InfoRow(icon: "shield.checkered", text: "Monitoreo GPS en tiempo real")
                            InfoRow(icon: "bell.badge.fill", text: "Botón SOS de emergencia")
                            InfoRow(icon: "clock.fill", text: "Registro completo de tu trayecto")
                        }
                        .padding()
                        .background(Color.blue.opacity(0.05))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 30)
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(30, corners: [.topLeft, .topRight])
                    .shadow(radius: 10)
                }
                .ignoresSafeArea(edges: .bottom)
            }
            .navigationTitle("TribuGO")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if let user = authViewModel.currentUser {
                        HStack {
                            Image(systemName: "person.circle.fill")
                            Text(user.email.split(separator: "@").first.map(String.init) ?? "")
                                .font(.caption)
                        }
                        .foregroundColor(.blue)
                    }
                }
            }
            .navigationDestination(isPresented: $showingActiveTripView) {
                ActiveTripView()
                    .environmentObject(tripViewModel)
                    .environmentObject(locationManager)
            }
        }
        .onAppear {
            if locationManager.authorizationStatus == .notDetermined {
                locationManager.requestPermission()
            }
            locationManager.getCurrentLocation()
        }
    }
    
    private func startTrip() {
        guard let userId = authViewModel.currentUser?.id else { return }
        
        // Verificar permisos
        if locationManager.authorizationStatus != .authorizedWhenInUse &&
           locationManager.authorizationStatus != .authorizedAlways {
            locationManager.requestPermission()
            return
        }
        
        // Obtener ubicación actual
        guard let location = locationManager.currentLocation else {
            locationManager.getCurrentLocation()
            return
        }
        
        // Iniciar trayecto
        tripViewModel.startTrip(userId: userId, initialLocation: location.coordinate)
        locationManager.startTracking()
        showingActiveTripView = true
    }
}

// Vista auxiliar para filas de información
struct InfoRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 24)
            Text(text)
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
        }
    }
}

// Extensión para esquinas redondeadas específicas
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    TripStartView()
        .environmentObject(TripViewModel())
        .environmentObject(LocationManager())
        .environmentObject(AuthViewModel())
}
