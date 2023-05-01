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
//        coreTodos.move(fromOffsets: source, toOffset: destination)
    }

    func delete(at offsets: IndexSet) {
//        let index = offsets[offsets.startIndex]
//
//        if history != nil {
//            history?.insert(coreTodos[index], at: 0)
//        } else {
//            history = [coreTodos[index]]
//        }
//
//        coreTodos.remove(atOffsets: offsets)
    }
}

struct ListView_Previews: PreviewProvider {
    static var dataController = DataController()

    static var previews: some View {
        ListView(todos: .constant(Todo.sampleData))
            .environment(\.managedObjectContext, dataController.viewContext)
    }
}
