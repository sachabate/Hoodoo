import Foundation
import CoreData

class Todo: NSManagedObject, Identifiable {
    @NSManaged var id: UUID
    @NSManaged var label: String
    @NSManaged var isComplete: Bool
    @NSManaged var desc: String
    @NSManaged var deadline: Date
    @NSManaged var customOrder: Int16
}

extension Todo {
    static let sampleData: [Todo] =
    [
//        {
//            let todo = Todo()
//            todo.label = "Buy milk"
//            todo.isComplete = true
//            todo.desc = "I hope it's chocolate!"
//            todo.deadline = Date().addDays(3)
//            return todo
//        }(),
//        {
//            let todo = Todo()
//            todo.label = "Walk dog"
//            todo.isComplete = false
//            todo.desc = "It's a walk in the park."
//            todo.deadline = Date().addDays(1)
//            return todo
//        }(),
//        {
//            let todo = Todo()
//            todo.label = "Clean kitchen"
//            todo.isComplete = false
//            todo.desc = "How hard can it be?"
//            todo.deadline = Date().addDays(7)
//            return todo
//        }()
    ]
}
