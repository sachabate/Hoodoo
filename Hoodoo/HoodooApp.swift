import SwiftUI

@main
struct HoodooApp: App {
    @State private var todos = Todo.sampleData

    var body: some Scene {
        WindowGroup {
            ListView(todos: $todos)
        }
    }
}
