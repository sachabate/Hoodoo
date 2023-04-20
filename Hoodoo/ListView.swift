//
//  ContentView.swift
//  Hoodoo
//
//  Created by Alex Bate on 2023-04-20.
//

import SwiftUI

struct ListView: View {
    var todos: [Todo]

    var body: some View {
        NavigationView {
            List(todos) { todo in
                NavigationLink(destination: DetailView(todo: todo)) {
                        TodoCardView(todo: todo)
                }
            }
            .navigationTitle("Hoodoo Todo")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: {}) {
                        Image(systemName: "clock.arrow.circlepath")
                    }
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "plus")
                    }
                    .padding(.trailing)
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(todos: Todo.sampleData)
    }
}
