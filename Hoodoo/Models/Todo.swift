import Foundation
import CoreData

class Todo: NSManagedObject, Identifiable {
    @NSManaged var id: UUID
    @NSManaged var label: String
    @NSManaged var isComplete: Bool
    @NSManaged var desc: String
    @NSManaged var deadline: Date
}

extension Todo {
    static let sampleData: [Todo] =
    [
//        Todo(
//            label: "Buy milk",
//            isComplete: true,
//            desc: "I hope it's chocolate!",
//            deadline: Date().addDays(3)
//        ),
//        Todo(
//            label: "Walk dog",
//            isComplete: false,
//            desc: "It's a walk in the park.",
//            deadline: Date().addDays(1)
//        ),
//        Todo(
//            label: "Clean kitchen",
//            isComplete: false,
//            desc: "How hard can it be?",
//            deadline: Date().addDays(7)
//        )
    ]
}
