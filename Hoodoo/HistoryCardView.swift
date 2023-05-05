import SwiftUI

struct HistoryCardView: View {
    var todo: History

    let dateFormatter = DateFormatter()

    var body: some View {
        Text(todo.label)
        Text("Completed on \(dateFormatter.string(from: todo.completed))")
            .font(.caption)
    }
}

//struct HistoryCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryCardView()
//    }
//}
