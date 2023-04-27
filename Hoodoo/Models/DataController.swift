import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Hoodoo")

    init() {
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Failed to load core data: \(error.localizedDescription)")
            }
        }
    }
}
