//
//  QRScannerView.swift
//  TribuGO
//
//  Vista de escáner de código QR
//

import SwiftUI
import AVFoundation

struct QRScannerView: View {
    @Environment(\.dismiss) var dismiss
    let onCodeScanned: (String) -> Void
    
    @State private var isScanning = true
    @State private var scannedCode: String?
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Cámara (simulada para prototipo)
                Color.black
                    .ignoresSafeArea()
                
                // Overlay de escáner
                VStack {
                    Spacer()
                    
                    // Marco de escaneo
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.green, lineWidth: 4)
                            .frame(width: 250, height: 250)
                        
                        // Animación de línea de escaneo
                        if isScanning {
                            Rectangle()
                                .fill(Color.green.opacity(0.5))
                                .frame(width: 250, height: 2)
                                .offset(y: -125)
                        }
                    }
                    
                    Spacer()
                    
                    // Instrucciones
                    VStack(spacing: 12) {
                        Text("Escanea el código QR del campus")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text("Coloca el código dentro del marco")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                        
                        // Botón de simulación (solo para prototipo)
                        Button(action: simulateScan) {
                            Text("Simular Escaneo (Prototipo)")
                                .font(.caption)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding(.top, 20)
                    }
                    .padding(.bottom, 50)
                }
            }
            .navigationTitle("Escanear QR")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Toggle flash (simulado)
                    }) {
                        Image(systemName: "flashlight.off.fill")
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
    
    private func simulateScan() {
        // Simular escaneo exitoso
        let mockQRCode = "CAMPUS_QR_\(UUID().uuidString.prefix(8))"
        scannedCode = mockQRCode
        isScanning = false
        
        // Feedback háptico
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        // Llamar al callback después de un breve delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            onCodeScanned(mockQRCode)
        }
    }
}

// MARK: - QR Scanner Service (para implementación real)
// Esta clase se usaría en producción con AVFoundation

class QRScannerService: NSObject, ObservableObject {
    @Published var scannedCode: String?
    @Published var isAuthorized = false
    
    private var captureSession: AVCaptureSession?
    
    func requestPermission() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
            DispatchQueue.main.async {
                self?.isAuthorized = granted
            }
        }
    }
    
    func startScanning() {
        // Implementación real con AVCaptureSession
        // Por ahora es solo un placeholder
    }
    
    func stopScanning() {
        captureSession?.stopRunning()
    }
}

#Preview {
    QRScannerView { code in
        print("Código escaneado: \(code)")
    }
}
