import Foundation

struct HistoryItem: Codable {
    let content: String
    let timestamp: Date
}

class HistoryManager {
    static let shared = HistoryManager()

    private let maxHistorySize = 50
    private var history: [HistoryItem] = []
    private let defaults = UserDefaults.standard
    private let historyKey = "clipboard_history"

    private init() {
        loadHistory()
    }

    func addToHistory(content: String) {
        let item = HistoryItem(content: content, timestamp: Date())
        history.insert(item, at: 0)

        if history.count > maxHistorySize {
            history.removeLast()
        }

        saveHistory()
    }

    func getHistory() -> [HistoryItem] {
        return history
    }

    func clearHistory() {
        history.removeAll()
        saveHistory()
    }

    func removeItem(at index: Int) {
        guard index < history.count else { return }
        history.remove(at: index)
        saveHistory()
    }

    private func saveHistory() {
        if let encoded = try? JSONEncoder().encode(history) {
            defaults.set(encoded, forKey: historyKey)
        }
    }

    private func loadHistory() {
        if let data = defaults.data(forKey: historyKey),
           let decoded = try? JSONDecoder().decode([HistoryItem].self, from: data) {
            history = decoded
        }
    }
}
