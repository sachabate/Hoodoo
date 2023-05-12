import ComposableArchitecture
import Foundation

struct TodoStore: ReducerProtocol {
    @Dependency(\.coreData) var coreData

    struct State: Equatable {}

    enum Action: Equatable {}

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {}
    }
}
