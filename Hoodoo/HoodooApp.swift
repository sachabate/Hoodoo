import SwiftUI

@main
struct HoodooApp: App {
    @StateObject private var dataController = DataController()
    @State private var todos = Todo.sampleData

    var body: some Scene {
        WindowGroup {
            ListView(todos: $todos)
        }
    }
}
