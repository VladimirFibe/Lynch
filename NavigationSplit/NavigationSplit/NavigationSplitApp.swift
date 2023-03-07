import SwiftUI

@main
struct NavigationSplitApp: App {
    @StateObject var store = DataStore()
    var body: some Scene {
        WindowGroup {
            StartTabView()
                .environmentObject(store)
        }
    }
}
