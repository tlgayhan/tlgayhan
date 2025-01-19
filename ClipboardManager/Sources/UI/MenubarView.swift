import SwiftUI

struct MenubarView: View {
    @StateObject private var clipboardService = ClipboardService.shared
    @State private var history: [HistoryItem] = HistoryManager.shared.getHistory()

    var body: some View {
        Menu("Clipboard Manager") {
            // Recent Items Section
            if !history.isEmpty {
                Section("Recent Items") {
                    ForEach(history.prefix(10), id: \.timestamp) { item in
                        Button(action: {
                            clipboardService.copyToClipboard(text: item.content)
                        }) {
                            Text(item.content.prefix(40))
                                .lineLimit(1)
                        }
                    }

                    Divider()

                    Button("Clear History") {
                        HistoryManager.shared.clearHistory()
                        history = []
                    }
                }

                Divider()
            }

            // Main Menu Items
            Button("Show History") {
                // Action to show history window
            }

            Button("Preferences") {
                // Action to show preferences
            }

            Divider()

            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
        }
        .onAppear {
            updateHistory()
        }
    }

    private func updateHistory() {
        history = HistoryManager.shared.getHistory()
    }
}

#Preview {
    MenubarView()
}
