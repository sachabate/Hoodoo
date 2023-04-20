//
//  DetailView.swift
//  Hoodoo
//
//  Created by Alex Bate on 2023-04-20.
//

import SwiftUI

struct DetailView: View {
    @Binding var todo: Todo

    var body: some View {
        List {
            Section(header: Text("Details")) {
                HStack {
                    Text("Label")
                        .foregroundColor(.gray)
                    TextField("", text: $todo.label)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Deadline")
                        .foregroundColor(.gray)
                    Text("")
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(todo: .constant(Todo.sampleData[0]))
    }
}
