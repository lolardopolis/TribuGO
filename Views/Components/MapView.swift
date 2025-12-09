//
//  MapView.swift
//  TribuGO
//
//  Vista de mapa con ruta y marcadores
//

import SwiftUI
import MapKit

struct MapView: View {
    let locationPoints: [LocationPoint]
    let currentLocation: CLLocation?
    let sosEvents: [SOSEvent]
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    var body: some View {
        Map(position: .constant(.region(region))) {
            // Ubicación actual
            if let current = currentLocation {
                Annotation("Tu ubicación", coordinate: current.coordinate) {
                    ZStack {
                        Circle()
                            .fill(Color.blue.opacity(0.3))
                            .frame(width: 40, height: 40)
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 16, height: 16)
                    }
                }
            }
            
            // Ruta recorrida
            if locationPoints.count > 1 {
                MapPolyline(coordinates: locationPoints.map { $0.coordinate })
                    .stroke(Color.blue, lineWidth: 4)
            }
            
            // Punto de inicio
            if let first = locationPoints.first {
                Annotation("Inicio", coordinate: first.coordinate) {
                    ZStack {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 30, height: 30)
                        Image(systemName: "flag.fill")
                            .foregroundColor(.white)
                            .font(.caption)
                    }
                }
            }
            
            // Eventos SOS
            ForEach(sosEvents) { event in
                Annotation("SOS", coordinate: event.coordinate) {
                    ZStack {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 40, height: 40)
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.white)
                            .font(.title3)
                    }
                }
            }
        }
        .mapStyle(.standard(elevation: .realistic))
        .onAppear {
            updateRegion()
        }
        .onChange(of: currentLocation) { _, _ in
            updateRegion()
        }
    }
    
    private func updateRegion() {
        if let current = currentLocation {
            region = MKCoordinateRegion(
                center: current.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        } else if let first = locationPoints.first {
            region = MKCoordinateRegion(
                center: first.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        }
    }
}

#Preview {
    MapView(
        locationPoints: [
            LocationPoint(latitude: -33.4489, longitude: -70.6693),
            LocationPoint(latitude: -33.4500, longitude: -70.6700)
        ],
        currentLocation: CLLocation(latitude: -33.4500, longitude: -70.6700),
        sosEvents: []
    )
}
