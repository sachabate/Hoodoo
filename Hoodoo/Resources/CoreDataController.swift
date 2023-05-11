import CoreData
import Dependencies
import Foundation

public struct CoreDataController: DependencyKey {
    var provider: StorageProvider
    var viewContext: NSManagedObjectContext
    var privateContext: NSManagedObjectContext
}

extension DependencyValues {
    var coreData: CoreDataController {
        get { self[CoreDataController.self] }
        set { self[CoreDataController.self] = newValue }
    }
}
