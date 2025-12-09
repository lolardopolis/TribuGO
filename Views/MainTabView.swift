//
//  MainTabView.swift
//  TribuGO
//
//  Vista principal con tabs de navegación
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var tripViewModel = TripViewModel()
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        TabView {
            // Tab de inicio de trayecto
            TripStartView()
                .environmentObject(tripViewModel)
                .environmentObject(locationManager)
                .tabItem {
                    Label("Inicio", systemImage: "house.fill")
                }
            
            // Tab de historial
            HistoryView()
                .environmentObject(tripViewModel)
                .tabItem {
                    Label("Historial", systemImage: "clock.fill")
                }
            
            // Tab de perfil
            ProfileView()
                .tabItem {
                    Label("Perfil", systemImage: "person.fill")
                }
        }
        .accentColor(.blue)
    }
}

#Preview {
    MainTabView()
        .environmentObject(AuthViewModel())
}
