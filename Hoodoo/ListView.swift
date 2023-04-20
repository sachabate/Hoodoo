//
//  ContentView.swift
//  Hoodoo
//
//  Created by Alex Bate on 2023-04-20.
//

import SwiftUI

struct ListView: View {
    let todos: [Todo]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hoodoo Todo")
                .font(.headline)
                .padding(.leading, 20)
            List(todos) { todo in
                TodoCardView(todo: todo)
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(todos: Todo.sampleData)
    }
}
