import ComposableArchitecture
import SwiftUI

@main
struct HoodooApp: App {
    @StateObject private var storageProvider = StorageProvider()

    var body: some Scene {
        WindowGroup {
            TodosView(
                store: Store(
                    initialState: TodosFeature.State(),
                    reducer: TodosFeature()
                )
            )
                .environment(\.managedObjectContext, storageProvider.viewContext)
        }
    }
}
