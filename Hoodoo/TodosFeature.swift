import ComposableArchitecture
import SwiftUI

struct TodoStore: ReducerProtocol {
    @Dependency(\.coreData) var coreData

    struct State: Equatable {
        @BindingState var editMode: EditMode = .inactive
    }

    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case editButtonTapped
    }

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce(self.reduce)
    }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .editButtonTapped:
            state.editMode.toggle()
            return .none
        default:
            return .none
        }
    }
}
