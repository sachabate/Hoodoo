import SwiftUI

struct ListView: View {
    @Binding var todos: [Todo]

    @State private var isEditView = false
    @State private var newTodo = Todo.emptyTodo

    var body: some View {
        NavigationView {
            List($todos) { todo in
                NavigationLink(destination: DetailView(todo: todo)) {
                    TodoCardView(todo: todo)
                }
            }
            .task {
                print(String("Fetching data... Nil"))
            }
            .navigationTitle(LocalizedStringKey("List.Toolbar.Title"))
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: {}) {
                        Image(systemName: "clock.arrow.circlepath")
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
                            Button(LocalizedStringKey("Toolbar.Done")) {}
                        }
                    }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(todos: .constant(Todo.sampleData))
    }
}
