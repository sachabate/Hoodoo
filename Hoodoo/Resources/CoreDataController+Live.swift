import CoreData
import Foundation

extension CoreDataController {
    public static var liveValue: CoreDataController {
        return Self(
            provider: StorageProvider.shared,
            viewContext: StorageProvider.shared.viewContext,
            privateContext: StorageProvider.shared.privateContext
        )
    }
}
