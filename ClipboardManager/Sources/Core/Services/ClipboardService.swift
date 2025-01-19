import Cocoa

protocol ClipboardServiceDelegate: AnyObject {
    func clipboardDidChange(content: String)
}

class ClipboardService {
    static let shared = ClipboardService()

    weak var delegate: ClipboardServiceDelegate?
    private var timer: Timer?
    private var lastChangeCount: Int

    private init() {
        self.lastChangeCount = NSPasteboard.general.changeCount
        startMonitoring()
    }

    private func startMonitoring() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.checkForChanges()
        }
    }

    private func checkForChanges() {
        let pasteboard = NSPasteboard.general
        if pasteboard.changeCount != lastChangeCount {
            lastChangeCount = pasteboard.changeCount
            if let newString = pasteboard.string(forType: .string) {
                delegate?.clipboardDidChange(content: newString)
            }
        }
    }

    func copyToClipboard(text: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(text, forType: .string)
    }

    func pasteFromClipboard() -> String? {
        let pasteboard = NSPasteboard.general
        return pasteboard.string(forType: .string)
    }

    deinit {
        timer?.invalidate()
    }
}
