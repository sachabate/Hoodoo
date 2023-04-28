import Foundation
import CoreData

class DataController: ObservableObject {
    private let model: NSManagedObjectModel
    private let coordinator: NSPersistentStoreCoordinator

    let privateContext: NSManagedObjectContext
    let viewContext: NSManagedObjectContext

    init() {
        let modelName = "Hoodoo"
        let storeName = "\(modelName).sqlite"

        let url = Bundle.main.url(forResource: modelName, withExtension: "momd")!
        model = NSManagedObjectModel(contentsOf: url)!

        let storeUrl = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )[0]
            .appendingPathComponent(storeName)

        coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)

        do {
            try coordinator.addPersistentStore(
                type: NSPersistentStore.StoreType.sqlite,
                at: storeUrl,
                options: [
                    NSInferMappingModelAutomaticallyOption: true,
                    NSMigratePersistentStoresAutomaticallyOption: true
                ]
            )
        } catch {
            fatalError("Unable to load persistent store.")
        }

        privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.persistentStoreCoordinator = coordinator

        viewContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        viewContext.parent = privateContext
    }
}
