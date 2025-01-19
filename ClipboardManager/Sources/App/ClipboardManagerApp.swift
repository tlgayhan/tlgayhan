import SwiftUI

@main
struct ClipboardManagerApp: App {

    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 400, minHeight: 300)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .commands {
            // Add app specific commands here
            CommandGroup(replacing: .newItem) { }
        }
    }
}
