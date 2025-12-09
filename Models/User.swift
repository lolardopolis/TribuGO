//
//  User.swift
//  TribuGO
//
//  Modelo de datos para usuario
//

import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    let email: String
    var name: String?
    let createdAt: Date
    
    init(id: UUID = UUID(), email: String, name: String? = nil, createdAt: Date = Date()) {
        self.id = id
        self.email = email
        self.name = name
        self.createdAt = createdAt
    }
}
