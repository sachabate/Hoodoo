//
//  Todo.swift
//  Hoodoo
//
//  Created by Alex Bate on 2023-04-20.
//

import Foundation

struct Todo {
    var label: String
}

extension Todo {
    static let sampleData: [Todo] =
    [
        Todo(label: "Buy milk"),
        Todo(label: "Walk dog"),
        Todo(label: "Clean kitchen")
    ]
}
