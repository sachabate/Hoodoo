import SwiftUI

struct DetailEditView: View {
    @Binding var todo: Todo

    @State var text = ""

    var body: some View {
        Form {
            Section(header: Text("Details")) {
                HStack {
                    Text("Label")
                        .foregroundColor(.gray)
                        .lineLimit(nil)
                    TextField("", text: $todo.label)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Deadline")
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Description")
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
