import SwiftUI

struct DetailView: View {
    @Binding var todo: Todo

    @State private var isEditView = false
    @State private var editingTodo = Todo.emptyTodo

    var body: some View {
        List {
            Section(header: Text("Details")) {
                HStack {
                    Text("")
                }
                HStack {
                    Text("")
                }
            }
        }
        .navigationTitle(todo.label)
        .toolbar {
            Button("Edit") {
                isEditView = true
                editingTodo = todo
            }
        }
        .sheet(isPresented: $isEditView) {
            NavigationView {
                DetailEditView(todo: $editingTodo)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                todo = editingTodo
                                isEditView = false
                            }
                        }
                    }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(todo: .constant(Todo.sampleData[0]))
    }
}
