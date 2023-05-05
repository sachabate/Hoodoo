import SwiftUI

struct HistoryView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \History.completed, ascending: false)
    ]) var history: FetchedResults<History>

    let dateFormatter = DateFormatter()

    init() {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
    }

    var body: some View {
        VStack {
            List {
                ForEach(history) { todo in
                    Text(todo.label)
                    Text("Completed at \(dateFormatter.string(from: todo.completed))")
                        .font(.caption)
                }
                if history.count == 0 {
                    Text("Nothing to show")
                        .opacity(0.5)
                }
            }
            .navigationTitle("History")
        }
    }
}

//struct HistoryView_Previews: PreviewProvider {
//    static let dataController = DataController()
//
//    static var previews: some View {
//        HistoryView(history: history)
//            .environment(\.managedObjectContext, dataController.viewContext)
//    }
//}
