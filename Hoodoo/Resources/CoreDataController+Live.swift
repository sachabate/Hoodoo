import CoreData
import Foundation

extension CoreDataController {
    public static var liveValue: CoreDataController {
        return Self(
            provider: StorageProvider.shared,
            viewContext: StorageProvider.shared.viewContext,
            privateContext: StorageProvider.shared.privateContext,
            todos: {
                let context = StorageProvider.shared.privateContext

                let fetchRequest = NSFetchRequest<Todo>(entityName: "Todo")
                fetchRequest.sortDescriptors = [
                    NSSortDescriptor(keyPath: \Todo.customOrder, ascending: true),
                    NSSortDescriptor(keyPath: \Todo.createdAt, ascending: false)
                ]

                do {
                    let todos = try context.fetch(fetchRequest)
                    return todos
                } catch {
                    print("Failed to fetch todos.")
                    return []
                }
            }()
        )
    }
}
