import ComposableArchitecture
import SwiftUI

struct TodosFeature: ReducerProtocol {
    @Dependency(\.coreData) var coreData

    struct State: Equatable {
        @BindingState var editMode: EditMode = .inactive
        @BindingState var isAddView: Bool = false
    }

    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case addButtonTapped
        case addTodoDismissed
        case editButtonTapped
    }

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce(self.core)
    }

    func core(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .addButtonTapped:
            state.isAddView = true
            return .none
        case .addTodoDismissed:
            state.isAddView = false
            return .none
        case .editButtonTapped:
            state.editMode.toggle()
            return .none
        default:
            return .none
        }
    }
}
