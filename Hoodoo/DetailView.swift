//
//  DetailView.swift
//  Hoodoo
//
//  Created by Alex Bate on 2023-04-20.
//

import SwiftUI

struct DetailView: View {
    var todo: Todo

    var body: some View {
        List {
            Section(header: Text("Details")) {
                HStack {
                    Label("Label", systemImage: "square.and.pencil")
                    Spacer()
                    Text(todo.label)
                }
                HStack {
                    Label("Deadline", systemImage: "calendar")
                    Spacer()
                    Text("")
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(todo: Todo.sampleData[0])
    }
}
