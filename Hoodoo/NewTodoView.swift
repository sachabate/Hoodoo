import SwiftUI
import ComposableArchitecture

struct NewTodoView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    @State private var label = ""
    @State private var isComplete = false
    @State private var desc = ""
    @State private var deadline = Date()

    var body: some View {
        Form {
            HStack {
                Text(LocalizedStringKey("Editor.Label"))
                    .foregroundColor(.gray)
                    .lineLimit(nil)
                TextField("", text: $label)
                    .multilineTextAlignment(.trailing)
            }
            Section(header: Text(LocalizedStringKey("Editor.Details"))) {
                HStack {
                    Text(LocalizedStringKey("Editor.Description"))
                        .foregroundColor(.gray)
                    TextEditor(text: $desc)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text(LocalizedStringKey("Editor.Deadline"))
                        .foregroundColor(.gray)
                    DatePicker("", selection: $deadline, in: Date.now..., displayedComponents: .date)
                }
            }
        }
        .navigationTitle(LocalizedStringKey("Editor.New.Title"))
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(LocalizedStringKey("Toolbar.Cancel")) {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button(LocalizedStringKey("Toolbar.Add")) {
                    saveNewTodo()
                    dismiss()
                }
            }
        }
    }

    // TODO: Move elsewhere
    func saveNewTodo() {
        let newTodo = Todo(context: moc)
        newTodo.id = UUID()
        newTodo.label = label
        newTodo.isComplete = isComplete
        newTodo.desc = desc
        newTodo.deadline = deadline
        newTodo.createdAt = Date()

        try? moc.save()
    }
}

struct NewTodoView_Previews: PreviewProvider {
    static var previews: some View {
        return NavigationView {
            NewTodoView()
        }
    }
}
