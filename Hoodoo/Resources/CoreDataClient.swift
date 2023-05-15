import CoreData
import Dependencies
import Foundation

public struct CoreDataClient: DependencyKey {
    var provider: StorageProvider
    var viewContext: NSManagedObjectContext
    var privateContext: NSManagedObjectContext
    var todos: [Todo]
}

extension DependencyValues {
    var coreData: CoreDataClient {
        get { self[CoreDataClient.self] }
        set { self[CoreDataClient.self] = newValue }
    }
}
