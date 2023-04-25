import SwiftUI

struct ListView: View {
    @Binding var todos: [Todo]

    @State private var history: [Todo]?
    @State private var isEditView = false
    @State private var isHistoryView = false
    @State private var newTodo = Todo.emptyTodo

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
                    EditButton()
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    NavigationLink(
                        destination: HistoryView(history: $history),
                        isActive: $isHistoryView) {
                            Button(action: {}) {
                                Image(systemName: "clock.arrow.circlepath")
                                    .onTapGesture {
                                        isHistoryView = true
                                    }
                            }
                        }
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "plus")
                            .onTapGesture {
                                isEditView = true
                            }
                    }
                    .padding(.trailing)
                }
            }
        }
        .sheet(isPresented: $isEditView) {
            NavigationView {
                DetailEditView(todo: $newTodo)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button(LocalizedStringKey("Toolbar.Cancel")) {
                                isEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button(LocalizedStringKey("Toolbar.Add")) {
                                todos.append(newTodo)
                                isEditView = false
                            }
                        }
                    }
            }
        }
    }

    func move(from source: IndexSet, to destination: Int) {
        todos.move(fromOffsets: source, toOffset: destination)
        print(destination)
    }

    func delete(at offsets: IndexSet) {
        let index = offsets[offsets.startIndex]

        if let unwrap = history {
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
