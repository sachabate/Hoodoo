import SwiftUI

struct DetailView: View {
    @Binding var todo: Todo

    @State private var isEditView = false
    @State private var editingTodo = Todo.emptyTodo
    @State private var deadlineString = ""

    var body: some View {
        List {
            Text(todo.description)
            Section(header: Text(LocalizedStringKey("Detail.Details"))) {
                HStack {
                    Text(LocalizedStringKey("Detail.Due"))
                        .foregroundColor(.gray)
                    Spacer()
                    Text(deadlineString)
                }
            }
        }
        .onAppear {
            deadlineString = formatDateToString(todo.deadline)
        }
        .navigationTitle(todo.label)
        .toolbar {
            Button(LocalizedStringKey("Detail.Edit")) {
                isEditView = true
                editingTodo = todo
            }
        }
        .sheet(isPresented: $isEditView) {
            NavigationView {
                DetailEditView(todo: $editingTodo)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button(LocalizedStringKey("Toolbar.Cancel")) {
                                isEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button(LocalizedStringKey("Toolbar.Done")) {
                                todo = editingTodo
                                deadlineString = formatDateToString(todo.deadline)
                                isEditView = false
                            }
                        }
                    }
            }
        }
    }
}

extension DetailView {
    func formatDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(todo: .constant(Todo.sampleData[0]))
    }
}
