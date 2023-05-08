import ComposableArchitecture
import SwiftUI
import CoreData

struct ListView: View {
    @Environment(\.managedObjectContext) var moc

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Todo.customOrder, ascending: true),
            NSSortDescriptor(keyPath: \Todo.createdAt, ascending: false)
        ]
    ) var coreTodos: FetchedResults<Todo>

    @State var editMode: EditMode = .inactive
    @State private var isAddView = false

    var body: some View {
        NavigationView {
            List {
                if editMode == .active {
                    deleteButton
                }
                Section {
                    ForEach(coreTodos) { todo in
                        NavigationLink(destination: DetailView(todo: todo)) {
                            TodoCardView(
                                store: Store(
                                    initialState: TodoCard.State(todo: todo),
                                    reducer: TodoCard()
                                ),
                                todo: todo
                            )
                        }
                    }
                    .onMove(perform: move)
                    .onDelete(perform: delete)
                }
            }
            .animation(.easeInOut, value: editMode)
            .environment(\.editMode, self.$editMode)
            .navigationTitle(LocalizedStringKey("List.Title"))
            .toolbar {
                ToolbarItem {
                    editButton
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    NavigationLink {
                        HistoryView()
                    } label: {
                        Image(systemName: "clock.arrow.circlepath")
                    }
                    Spacer()
                    Button {
                        isAddView = true
                    } label: {
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
}

extension ListView {
    private var deleteButton: some View {
        return Button("Remove all completed", role: .destructive, action: bulkDeleteComplete)
    }

    private var editButton: some View {
        return Button {
            self.editMode.toggle()
        } label: {
            Text(
                self.editMode == .inactive
                ? LocalizedStringKey("Toolbar.Edit")
                : LocalizedStringKey("Toolbar.Done")
            )
        }
    }
}

extension ListView {
    func move(from source: IndexSet, to destination: Int) {
        var reordered: [Todo] = coreTodos.map {$0}

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
            newHistoryTodo(todo: item)
            moc.delete(item)
        }
    }

    func bulkDeleteComplete() {
        let request = NSFetchRequest<Todo>(entityName: "Todo")
        request.predicate = NSPredicate(format: "isComplete == %@", NSNumber(value: true))

        do {
            let items = try moc.fetch(request)
            for item in items {
                newHistoryTodo(todo: item)
                moc.delete(item)
            }
        } catch {
            print("Failed to delete items.")
        }
    }

    func newHistoryTodo(todo: Todo) {
        let historyItem = History(context: moc)
        historyItem.id = UUID()
        historyItem.label = todo.label
        historyItem.desc = todo.desc
        historyItem.completed = Date()
    }
}

struct ListView_Previews: PreviewProvider {
    static var dataController = DataController()

    static var previews: some View {
        return ListView()
            .environment(\.managedObjectContext, dataController.viewContext)
    }
}
