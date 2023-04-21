import SwiftUI

struct DetailEditView: View {
    @Binding var todo: Todo

    var body: some View {
        Form {
            Section(header: Text("Details")) {
                HStack {
                    Text("Label")
                        .foregroundColor(.gray)
                    TextField("", text: $todo.label)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Deadline")
                        .foregroundColor(.gray)
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
