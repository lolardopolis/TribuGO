//
//  AuthViewModel.swift
//  TribuGO
//
//  ViewModel para autenticación de usuario
//

import Foundation
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    @Published var errorMessage: String?
    
    private let userDefaultsKey = "TribuGO_CurrentUser"
    
    init() {
        loadSavedUser()
    }
    
    // Cargar usuario guardado
    private func loadSavedUser() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            self.currentUser = user
            self.isAuthenticated = true
        }
    }
    
    // Login simulado (para prototipo)
    func login(email: String, password: String) {
        // Validación básica
        guard !email.isEmpty else {
            errorMessage = "Por favor ingresa tu correo institucional"
            return
        }
        
        guard email.contains("@") else {
            errorMessage = "Ingresa un correo válido"
            return
        }
        
        guard !password.isEmpty else {
            errorMessage = "Por favor ingresa tu contraseña"
            return
        }
        
        // Simulación: cualquier email institucional es válido
        // En producción, aquí iría la llamada al servidor SSO
        let user = User(email: email.lowercased())
        
        // Guardar usuario
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
        
        withAnimation {
            self.currentUser = user
            self.isAuthenticated = true
            self.errorMessage = nil
        }
    }
    
    // Logout
    func logout() {
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
        
        withAnimation {
            self.currentUser = nil
            self.isAuthenticated = false
            self.errorMessage = nil
        }
    }
    
    // Actualizar perfil
    func updateProfile(name: String) {
        guard var user = currentUser else { return }
        user.name = name
        
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
        
        self.currentUser = user
    }
}
