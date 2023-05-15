import ComposableArchitecture
import SwiftUI
import CoreData

struct TodosView: View {
    let store: StoreOf<TodosFeature>

    @Environment(\.managedObjectContext) var moc
    @Dependency(\.uuid) var uuid
    @Dependency(\.date.now) var now

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Todo.customOrder, ascending: true),
            NSSortDescriptor(keyPath: \Todo.createdAt, ascending: false)
        ]
    ) var coreTodos: FetchedResults<Todo>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                List {
                    if viewStore.editMode == .active {
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
                .animation(.easeInOut, value: viewStore.editMode)
                .environment(\.editMode, viewStore.binding(\.$editMode))
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
                            viewStore.send(.addButtonTapped)
                        } label: {
                            Image(systemName: "plus")
                        }
                        .padding(.trailing)
                    }
                }
            }
            .sheet(
                isPresented: viewStore.binding(
                    get: \.isAddView,
                    send: .addTodoDismissed
                )
            ) {
                NavigationView {
                    NewTodoView(store: store)
                }
            }
        }
    }
}

extension TodosView {
    private var deleteButton: some View {
        return Button("Remove all completed", role: .destructive, action: bulkDeleteComplete)
    }

    private var editButton: some View {
        return WithViewStore(self.store, observe: { $0 }) { viewStore in
            Button {
                viewStore.send(.editButtonTapped)
            } label: {
                Text(
                    viewStore.editMode == .inactive
                    ? LocalizedStringKey("Toolbar.Edit")
                    : LocalizedStringKey("Toolbar.Done")
                )
            }
        }
    }
}

extension TodosView {
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
        historyItem.id = self.uuid()
        historyItem.label = todo.label
        historyItem.desc = todo.desc
        historyItem.completed = self.now
    }
}

struct TodosView_Previews: PreviewProvider {
    static var storageProvider = StorageProvider()

    static var previews: some View {
        return TodosView(
            store: Store(
                initialState: TodosFeature.State(),
                reducer: TodosFeature()
            )
        )
            .environment(\.managedObjectContext, storageProvider.viewContext)
    }
}
