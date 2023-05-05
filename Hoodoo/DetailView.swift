import SwiftUI

struct DetailView: View {
    @ObservedObject var todo: Todo

    @State private var isEditView = false
    @State private var deadlineString = ""

    var body: some View {
        List {
            Text(todo.desc)
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
            }
        }
        .sheet(isPresented: $isEditView) {
            NavigationView {
                DetailEditView(todo: todo)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button(LocalizedStringKey("Toolbar.Cancel")) {
                                isEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button(LocalizedStringKey("Toolbar.Done")) {
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
     static var dataController = DataController()

     static var previews: some View {
         let context = dataController.viewContext
         let todo = Todo(context: context)
         todo.label = "Buy milk"
         todo.desc = "Description"
         todo.deadline = Date()

         return NavigationView {
             DetailView(todo: todo)
                 .environment(\.managedObjectContext, dataController.viewContext)
         }
     }
 }
