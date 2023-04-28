import CoreData
import SwiftUI

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

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(DataController.saveChanges),
            name: UIApplication.willResignActiveNotification,
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(DataController.saveChanges),
            name: UIApplication.willTerminateNotification,
            object: nil)
    }
}

extension DataController {
    @objc func saveChanges() {
        viewContext.perform {
            do {
                if self.viewContext.hasChanges {
                    try self.viewContext.save()
                }
            } catch {
                print("Failed to save changes from view context.")
            }

            self.savePrivateContext()
        }
    }

    @objc func savePrivateContext() {
        privateContext.perform {
            do {
                if self.privateContext.hasChanges {
                    try self.privateContext.save()
                }
            } catch {
                print("Failed to save changes from private context.")
            }
        }
    }
}
