//
//  TodoCardView.swift
//  Hoodoo
//
//  Created by Alex Bate on 2023-04-20.
//

import SwiftUI

struct TodoCardView: View {
    @State var todo: Todo

    var body: some View {
        HStack {
            Image(systemName: todo.isComplete ? "checkmark.square.fill" : "square")
                .onTapGesture {
                    todo.isComplete.toggle()
                }
            Text(todo.label)
            Spacer()
        }
        .padding()
    }
}

struct TodoCardView_Previews: PreviewProvider {
    static var todo = Todo.sampleData[0]
    static var previews: some View {
        TodoCardView(todo: todo)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
