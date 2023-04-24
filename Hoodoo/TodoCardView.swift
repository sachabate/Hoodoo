import SwiftUI

struct TodoCardView: View {
    @Binding var todo: Todo

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
        TodoCardView(todo: .constant(todo))
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
