import SwiftUI

struct DetailEditView: View {
    @Binding var todo: Todo

    var body: some View {
        Form {
            Section(header: Text("Details")) {
                TextField(text: $todo.label) {
                    Text("Label")
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
