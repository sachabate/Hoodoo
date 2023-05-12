import ComposableArchitecture
import SwiftUI

@main
struct HoodooApp: App {
//    @StateObject private var dataController = DataController()
    @StateObject private var storageProvider = StorageProvider()

    var body: some Scene {
        WindowGroup {
            TodosView(
                store: Store(
                    initialState: TodoStore.State(),
                    reducer: TodoStore()
                )
            )
                .environment(\.managedObjectContext, storageProvider.viewContext)
        }
    }
}
