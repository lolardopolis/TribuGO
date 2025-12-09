//
//  PersistenceController.swift
//  TribuGO
//
//  Controlador de persistencia con Core Data
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "TribuGO")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                // En producción, manejar el error apropiadamente
                fatalError("Error al cargar Core Data: \(error.localizedDescription)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    // Preview helper
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        // Crear datos de ejemplo para previews
        // (Aquí se pueden agregar entidades de ejemplo si se usa Core Data)
        
        return controller
    }()
    
    // Guardar contexto
    func save() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // En producción, manejar el error apropiadamente
                print("Error al guardar: \(error.localizedDescription)")
            }
        }
    }
}
