//
//  TribuGOApp.swift
//  TribuGO
//
//  Sistema de Seguridad y Trazabilidad Integral de Trayectos
//

import SwiftUI

@main
struct TribuGOApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            if authViewModel.isAuthenticated {
                MainTabView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(authViewModel)
            } else {
                LoginView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(authViewModel)
            }
        }
    }
}
