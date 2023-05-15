import CoreData
import Foundation

extension CoreDataController {
    public static var previewValue: CoreDataController {
        return Self(
            provider: StorageProvider.preview,
            viewContext: StorageProvider.preview.viewContext,
            privateContext: StorageProvider.preview.privateContext,
            todos: {
                return []
            }()
        )
    }
}
