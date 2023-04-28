import SwiftUI

struct ListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var coreTodos: FetchedResults<Todo>

    @Binding var todos: [Todo]

    @State private var history: [Todo]?
    @State private var isAddView = false
    @State private var isHistoryView = false

    var body: some View {
        NavigationView {
            List {
                ForEach($todos, id: \.self) { todo in
                    NavigationLink(destination: DetailView(todo: todo)) {
                        TodoCardView(todo: todo)
                    }
                }
                .onMove(perform: move)
                .onDelete(perform: delete)
            }
            .navigationTitle(LocalizedStringKey("List.Title"))
            .task {
                print(String("Fetching data... Nil"))
            }
            .toolbar {
                ToolbarItemGroup {
                    EditButton()
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    NavigationLink(
                        destination: HistoryView(history: $history),
                        isActive: $isHistoryView) {
                            Button { isHistoryView = true } label: {
                                Image(systemName: "clock.arrow.circlepath")
                            }
                        }
                    Spacer()
                    Button { isAddView = true } label: {
                        Image(systemName: "plus")
                    }
                    .padding(.trailing)
                }
            }
        }
        .sheet(isPresented: $isAddView) {
            NavigationView {
                NewTodoView()
            }
        }
    }

    func move(from source: IndexSet, to destination: Int) {
        todos.move(fromOffsets: source, toOffset: destination)
        print(destination)
    }

    func delete(at offsets: IndexSet) {
        let index = offsets[offsets.startIndex]

        if history != nil {
            history?.insert(todos[index], at: 0)
        } else {
            history = [todos[index]]
        }

        todos.remove(atOffsets: offsets)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(todos: .constant(Todo.sampleData))
    }
}
