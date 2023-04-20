//
//  Todo.swift
//  Hoodoo
//
//  Created by Alex Bate on 2023-04-20.
//

import Foundation

struct Todo: Identifiable {
    let id: UUID
    var label: String
    var isComplete: Bool
    
    init(id: UUID = UUID(), label: String, isComplete: Bool) {
        self.id = id
        self.label = label
        self.isComplete = isComplete
    }
}

extension Todo {
    static var sampleData: [Todo] =
    [
        Todo(label: "Buy milk", isComplete: true),
        Todo(label: "Walk dog", isComplete: false),
        Todo(label: "Clean kitchen", isComplete: false)
    ]
}
