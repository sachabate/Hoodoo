import ComposableArchitecture
import SwiftUI
import CoreData

struct TodoCard: ReducerProtocol {
    struct State: Equatable {
        @ObservedObject var todo: Todo

        static func == (lhs: TodoCard.State, rhs: TodoCard.State) -> Bool {
            return lhs.todo.id == rhs.todo.id
        }
    }

    enum Action: Equatable {
        case isCompleteToggle
    }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .isCompleteToggle:
            state.todo.isComplete.toggle()
            return .none
        }
    }
}

struct TodoCardView: View {
    let store: StoreOf<TodoCard>

    @ObservedObject var todo: Todo
    var body: some View {

        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack {
                Image(systemName: viewStore.todo.isComplete ? "checkmark.square.fill" : "square")
                    .onTapGesture {
                        viewStore.send(.isCompleteToggle)
                    }
                Text(viewStore.todo.label)
                    .opacity(viewStore.todo.isComplete ? 0.5 : 1.0)
                Spacer()
            }
            .padding()
        }

    }
}

struct TodoCardView_Previews: PreviewProvider {
    static var dataController = DataController()

    static var previews: some View {
        let context = dataController.viewContext
        let todo = Todo(context: context)
        todo.label = "Buy milk"
        todo.isComplete = false

        return NavigationView {
            TodoCardView(
                store: Store(
                    initialState: TodoCard.State(todo: todo),
                    reducer: TodoCard()
                ),
                todo: todo
            )
            .environment(\.managedObjectContext, dataController.viewContext)
        }
    }
}
