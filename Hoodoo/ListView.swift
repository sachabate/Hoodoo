import SwiftUI

struct ListView: View {
    @Binding var todos: [Todo]

    var body: some View {
        NavigationView {
            List($todos) { $todo in
                NavigationLink(destination: DetailView(todo: $todo)) {
                    TodoCardView(todo: todo)
                }
            }
            .navigationTitle("Todo")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: {}) {
                        Image(systemName: "clock.arrow.circlepath")
                    }
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "plus")
                    }
                    .padding(.trailing)
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(todos: .constant(Todo.sampleData))
    }
}
