//
//  ProfileView.swift
//  TribuGO
//
//  Vista de perfil de usuario
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showLogoutAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                // Información del usuario
                Section {
                    HStack(spacing: 16) {
                        // Avatar
                        ZStack {
                            Circle()
                                .fill(LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
                                .frame(width: 70, height: 70)
                            
                            Text(getInitials())
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            if let name = authViewModel.currentUser?.name {
                                Text(name)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                            
                            Text(authViewModel.currentUser?.email ?? "")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Text("Miembro verificado")
                                .font(.caption)
                                .foregroundColor(.green)
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                // Configuración
                Section("Configuración") {
                    NavigationLink(destination: Text("Notificaciones")) {
                        Label("Notificaciones", systemImage: "bell.fill")
                    }
                    
                    NavigationLink(destination: Text("Privacidad")) {
                        Label("Privacidad", systemImage: "lock.fill")
                    }
                    
                    NavigationLink(destination: Text("Permisos")) {
                        Label("Permisos de ubicación", systemImage: "location.fill")
                    }
                }
                
                // Seguridad
                Section("Seguridad") {
                    NavigationLink(destination: Text("Contactos de emergencia")) {
                        Label("Contactos de emergencia", systemImage: "person.2.fill")
                    }
                    
                    NavigationLink(destination: Text("Configuración SOS")) {
                        Label("Configuración SOS", systemImage: "exclamationmark.triangle.fill")
                            .foregroundColor(.red)
                    }
                }
                
                // Información
                Section("Información") {
                    NavigationLink(destination: Text("Acerca de TribuGO")) {
                        Label("Acerca de TribuGO", systemImage: "info.circle.fill")
                    }
                    
                    NavigationLink(destination: Text("Términos y condiciones")) {
                        Label("Términos y condiciones", systemImage: "doc.text.fill")
                    }
                    
                    NavigationLink(destination: Text("Política de privacidad")) {
                        Label("Política de privacidad", systemImage: "hand.raised.fill")
                    }
                    
                    HStack {
                        Label("Versión", systemImage: "number")
                        Spacer()
                        Text("1.0.0 (Prototipo)")
                            .foregroundColor(.secondary)
                    }
                }
                
                // Cerrar sesión
                Section {
                    Button(action: { showLogoutAlert = true }) {
                        HStack {
                            Spacer()
                            Label("Cerrar Sesión", systemImage: "rectangle.portrait.and.arrow.right")
                                .foregroundColor(.red)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Perfil")
            .alert("Cerrar Sesión", isPresented: $showLogoutAlert) {
                Button("Cancelar", role: .cancel) { }
                Button("Cerrar Sesión", role: .destructive) {
                    authViewModel.logout()
                }
            } message: {
                Text("¿Estás seguro que deseas cerrar sesión?")
            }
        }
    }
    
    private func getInitials() -> String {
        guard let email = authViewModel.currentUser?.email else { return "?" }
        let username = email.split(separator: "@").first ?? ""
        return String(username.prefix(2)).uppercased()
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}
