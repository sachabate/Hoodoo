import SwiftUI

@main
struct HoodooApp: App {
//    @StateObject private var dataController = DataController()
    @StateObject private var storageProvider = StorageProvider()

    var body: some Scene {
        WindowGroup {
            ListView()
                .environment(\.managedObjectContext, storageProvider.viewContext)
        }
    }
}
