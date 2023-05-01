import SwiftUI

struct ListView: View {
    @Environment(\.managedObjectContext) var moc

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Todo.customOrder, ascending: true),
            NSSortDescriptor(keyPath: \Todo.label, ascending: true)
        ]
    ) var coreTodos: FetchedResults<Todo>

    @State private var history: [Todo]?
    @State private var isAddView = false
    @State private var isHistoryView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(coreTodos) { todo in
                    NavigationLink {
                        DetailView(todo: todo)
                    } label: {
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
        var reordered: [Todo] = coreTodos.map{ $0 }

        reordered.move(fromOffsets: source, toOffset: destination)

        for index in stride(
            from: coreTodos.count - 1,
            through: 0,
            by: -1
        ) {
            reordered[index].customOrder = Int16(index)
        }
    }

    func delete(at offsets: IndexSet) {
        for index in offsets {
            let item = coreTodos[index]
            addToHistory(todo: item)
            moc.delete(item)
        }
    }

    func addToHistory(todo: Todo) {
        if history != nil {
            history?.insert(todo, at: 0)
        } else {
            history = [todo]
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var dataController = DataController()

    static var previews: some View {
        ListView()
            .environment(\.managedObjectContext, dataController.viewContext)
    }
}
