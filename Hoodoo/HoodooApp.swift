import SwiftUI

@main
struct HoodooApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ListView()
                .environment(\.managedObjectContext, dataController.viewContext)
        }
    }
}
