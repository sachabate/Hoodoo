import CoreData
import SwiftUI

public class StorageProvider: ObservableObject {
    private let model: NSManagedObjectModel
    private let coordinator: NSPersistentStoreCoordinator

    let privateContext: NSManagedObjectContext
    let viewContext: NSManagedObjectContext

    public static let shared = StorageProvider()
    public static var preview: StorageProvider {
        let provider = StorageProvider(inMemory: true)
        let context = provider.viewContext

        return provider
    }

    init(inMemory: Bool = false) {
        let modelName = "Hoodoo"
        let storeName = "\(modelName).sqlite"

        let url = Bundle.main.url(forResource: modelName, withExtension: "momd")!
        model = NSManagedObjectModel(contentsOf: url)!

        let storeUrl = inMemory ? URL(fileURLWithPath: "/dev/null/") : {
            return FileManager.default.urls(
                for: .documentDirectory,
                in: .userDomainMask
            )[0]
                .appendingPathComponent(storeName)
        }()

        coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)

        do {
            try _ = coordinator.addPersistentStore(
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
            forName: UIApplication.willResignActiveNotification,
            object: nil,
            queue: nil
        ) { _ in
            self.saveChanges()
            print("Saved changes (resigned)")
        }

        NotificationCenter.default.addObserver(
            forName: UIApplication.willTerminateNotification,
            object: nil,
            queue: nil
        ) { _ in
            self.saveChanges()
            print("Saved changes (terminated)")
        }
    }
}

extension StorageProvider {
    func saveChanges() {
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

    func savePrivateContext() {
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
