import SwiftUI

struct HistoryView: View {
    @Binding var history: [Todo]?

    var body: some View {
        List {
            if let unwrap = Binding($history) {
                ForEach(unwrap, id: \.self) { todo in
                    TodoCardView(todo: todo)
                }
            } else {
                Text("Nothing to show")
                    .opacity(0.5)
            }
        }
        .navigationTitle("History")
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(history: .constant(Todo.sampleData))
    }
}
