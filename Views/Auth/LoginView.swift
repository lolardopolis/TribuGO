//
//  LoginView.swift
//  TribuGO
//
//  Pantalla de autenticación institucional
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false
    
    var body: some View {
        ZStack {
            // Fondo con gradiente institucional
            LinearGradient(
                colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.6)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                
                // Logo y título
                VStack(spacing: 16) {
                    Image(systemName: "shield.checkered")
                        .font(.system(size: 80))
                        .foregroundColor(.white)
                    
                    Text("TribuGO")
                        .font(.system(size: 42, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text("Sistema de Seguridad y Trazabilidad")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom, 40)
                
                // Formulario de login
                VStack(spacing: 20) {
                    // Campo de email
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Correo Institucional")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                        
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.white.opacity(0.7))
                            
                            TextField("estudiante@universidad.edu", text: $email)
                                .textContentType(.emailAddress)
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(0.3), lineWidth: 1)
                        )
                    }
                    
                    // Campo de contraseña
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Contraseña")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                        
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundColor(.white.opacity(0.7))
                            
                            if showPassword {
                                TextField("Contraseña", text: $password)
                                    .foregroundColor(.white)
                            } else {
                                SecureField("Contraseña", text: $password)
                                    .foregroundColor(.white)
                            }
                            
                            Button(action: { showPassword.toggle() }) {
                                Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.white.opacity(0.7))
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(0.3), lineWidth: 1)
                        )
                    }
                    
                    // Mensaje de error
                    if let error = authViewModel.errorMessage {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                            Text(error)
                        }
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(8)
                    }
                    
                    // Botón de login
                    Button(action: {
                        authViewModel.login(email: email, password: password)
                    }) {
                        HStack {
                            Image(systemName: "arrow.right.circle.fill")
                            Text("Iniciar Sesión")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.blue)
                        .cornerRadius(12)
                    }
                    .padding(.top, 10)
                    
                    // Nota informativa
                    Text("Para el prototipo, cualquier correo institucional es válido")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                        .padding(.top, 8)
                }
                .padding(.horizontal, 30)
                
                Spacer()
                
                // Footer
                VStack(spacing: 4) {
                    Text("Versión 1.0.0 (Prototipo)")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.6))
                    
                    Text("Tu seguridad es nuestra prioridad")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
}
