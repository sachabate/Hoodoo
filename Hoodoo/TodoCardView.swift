import SwiftUI
import CoreData

struct TodoCardView: View {
    @ObservedObject var todo: Todo
    var body: some View {
        HStack {
            Image(systemName: todo.isComplete ? "checkmark.square.fill" : "square")
                .onTapGesture {
                    withAnimation(Animation.easeInOut) {
                        todo.isComplete.toggle()
                    }
                }
            Text(todo.label)
                .opacity(todo.isComplete ? 0.5 : 1.0)
            Spacer()
        }
        .padding()
    }
}

struct TodoCardView_Previews: PreviewProvider {
    static var dataController = DataController()

    static var previews: some View {
        let context = dataController.viewContext
        let todo = Todo(context: context)
        todo.label = "Buy milk"

        return NavigationView {
            TodoCardView(todo: todo)
                .environment(\.managedObjectContext, dataController.viewContext)
        }
    }
}
