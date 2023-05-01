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

//struct TodoCardView_Previews: PreviewProvider {
//    static var dataController = DataController()
//
//    static var previews: some View {
//
//        return NavigationView {
//            TodoCardView()
//                .environment(\.managedObjectContext, dataController.viewContext)
//        }
//    }
//}
