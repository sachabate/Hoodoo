import SwiftUI

struct ListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var coreTodos: FetchedResults<Todo>

    @Binding var todos: [Todo]

    @State private var history: [Todo]?
    @State private var isAddView = false
    @State private var isHistoryView = false
//    @State private var newTodo: Todo()

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
            .navigationTitle(LocalizedStringKey("List.Toolbar.Title"))
            .task {
                print(String("Fetching data... Nil"))
            }
            .toolbar {
                ToolbarItemGroup {
                    Button(LocalizedStringKey("List.Toolbar.Fetch")) {
                        Task {
//                            try await fetchTodos()
                            print("Whoops!")
                        }
                    }
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
//        .sheet(isPresented: $isEditView) {
//            NavigationView {
//                DetailEditView(todo: $todos[0])
//                    .toolbar {
//                        ToolbarItem(placement: .cancellationAction) {
//                            Button(LocalizedStringKey("Toolbar.Cancel")) {
//                                isEditView = false
//                            }
//                        }
//                        ToolbarItem(placement: .confirmationAction) {
//                            Button(LocalizedStringKey("Toolbar.Add")) {
////                                todos.append(newTodo)
//                                isEditView = false
//                            }
//                        }
//                    }
//            }
//        }
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

//    func fetchTodos() async throws {
//        let url = URL(string: "http://localhost:8000/todoItems.json")!
//        let urlRequest = URLRequest(url: url)
//
//        let (data, response) = try await URLSession.shared.data(for: urlRequest)
//
//        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
//            print("Failed to fetch data")
//            return
//        }
//
//        let items = try JSONDecoder().decode([Todo].self, from: data)
//        importTodos(items: items)
//    }
//
//    func importTodos(items: [Todo]) {
//        items.forEach { item in
//            if !todos.contains(item) {todos.append(item)}
//        }
//    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(todos: .constant(Todo.sampleData))
    }
}
