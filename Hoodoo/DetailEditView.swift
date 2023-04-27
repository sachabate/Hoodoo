import SwiftUI

struct DetailEditView: View {
    @Binding var todo: Todo

    var body: some View {
        Form {
            HStack {
                Text(LocalizedStringKey("Editor.Label"))
                    .foregroundColor(.gray)
                    .lineLimit(nil)
                TextField("", text: $todo.label)
                    .multilineTextAlignment(.trailing)
            }
            Section(header: Text(LocalizedStringKey("Editor.Details"))) {
                HStack {
                    Text(LocalizedStringKey("Editor.Description"))
                        .foregroundColor(.gray)
                    TextEditor(text: $todo.desc)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text(LocalizedStringKey("Editor.Deadline"))
                        .foregroundColor(.gray)
                    DatePicker("", selection: $todo.deadline, in: Date.now..., displayedComponents: .date)
                }
            }
        }
        .onAppear {
            print(String("Editor appears"))
        }
        .onDisappear {
            print(String("Editor disappears"))
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(todo: .constant(Todo.sampleData[0]))
    }
}
