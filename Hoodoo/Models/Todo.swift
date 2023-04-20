//
//  Todo.swift
//  Hoodoo
//
//  Created by Alex Bate on 2023-04-20.
//

import Foundation

struct Todo {
    var label: String
    var isComplete: Bool
}

extension Todo {
    static var sampleData: [Todo] =
    [
        Todo(label: "Buy milk", isComplete: false),
        Todo(label: "Walk dog", isComplete: true),
        Todo(label: "Clean kitchen", isComplete: false)
    ]
}
