import SwiftUI

struct DetailEditView: View {
    @ObservedObject var todo: Todo

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
                    DatePicker("", selection: $todo.deadline, displayedComponents: .date)
                }
            }
        }
        .navigationTitle(LocalizedStringKey("Editor.Title"))
        .onAppear {
            print(String("Editor appears"))
        }
        .onDisappear {
            print(String("Editor disappears"))
        }

    }
}

 struct DetailEditView_Previews: PreviewProvider {
     static var dataController = DataController()

     static var previews: some View {
         let context = dataController.viewContext
         let todo = Todo(context: context)
         todo.label = "Buy milk"
         todo.desc = "description"
         todo.deadline = Date()

         return NavigationView {
             DetailEditView(todo: todo)
                 .environment(\.managedObjectContext, dataController.viewContext)
         }
     }
 }
