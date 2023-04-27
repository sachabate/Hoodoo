import SwiftUI

struct HistoryView: View {
    @Binding var history: [Todo]?
    @FetchRequest(sortDescriptors: []) var coreTodos: FetchedResults<Todo>

    var body: some View {
        VStack {
            List {
                if let unwrap = Binding($history) {
                    ForEach(unwrap, id: \.self) { todo in
                        NavigationLink(destination: DetailView(todo: todo)) {
                            TodoCardView(todo: todo)
                        }
                    }
                } else {
                    Text("Nothing to show")
                        .opacity(0.5)
                }
            }
            .navigationTitle("History")
            List(coreTodos) { todo in
                Text(todo.label)
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(history: .constant(Todo.sampleData))
    }
}
