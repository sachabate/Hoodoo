import SwiftUI

struct DetailEditView: View {
    @Binding var todo: Todo

    @State var text = ""

    var body: some View {
        Form {
            Section(header: Text(LocalizedStringKey("Editor.Details"))) {
                HStack {
                    Text(LocalizedStringKey("Editor.Label"))
                        .foregroundColor(.gray)
                        .lineLimit(nil)
                    TextField("", text: $todo.label)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text(LocalizedStringKey("Editor.Deadline"))
                        .foregroundColor(.gray)
                }
                HStack {
                    Text(LocalizedStringKey("Editor.Description"))
                        .foregroundColor(.gray)
                    TextEditor(text: $text)
                }
            }
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(todo: .constant(Todo.sampleData[0]))
    }
}
