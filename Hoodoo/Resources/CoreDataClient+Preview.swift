import CoreData
import Foundation

extension CoreDataClient {
    public static var previewValue: CoreDataClient {
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
