import Foundation

struct Todo: Identifiable {
    let id: UUID
    var label: String
    var isComplete: Bool

    static var emptyTodo: Todo {
        Todo(label: "", isComplete: false)
    }

    init(id: UUID = UUID(), label: String, isComplete: Bool) {
        self.id = id
        self.label = label
        self.isComplete = isComplete
    }
}

extension Todo {
    static let sampleData: [Todo] =
    [
        Todo(label: "Buy milk", isComplete: true),
        Todo(label: "Walk dog", isComplete: false),
        Todo(label: "Clean kitchen", isComplete: false)
    ]
}
