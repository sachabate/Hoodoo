import Foundation

struct Todo: Identifiable {
    let id: UUID
    var label: String
    var isComplete: Bool
    var description: String
    var deadline: Date

    static var emptyTodo: Todo {
        Todo()
    }

    init(
        id: UUID = UUID(),
        label: String = "",
        isComplete: Bool = false,
        description: String = "",
        deadline: Date = Date()
    ) {
        self.id = id
        self.label = label
        self.isComplete = isComplete
        self.description = description
        self.deadline = deadline
    }
}

extension Todo {
    static let sampleData: [Todo] =
    [
        Todo(
            label: "Buy milk",
            isComplete: true,
            description: "I hope it's chocolate!",
            deadline: Date().addDays(3)
        ),
        Todo(
            label: "Walk dog",
            isComplete: false,
            description: "It's a walk in the park.",
            deadline: Date().addDays(1)
        ),
        Todo(
            label: "Clean kitchen",
            isComplete: false,
            description: "How hard can it be?",
            deadline: Date().addDays(7)
        )
    ]
}
