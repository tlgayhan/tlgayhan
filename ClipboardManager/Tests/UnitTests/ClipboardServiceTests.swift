import XCTest
@testable import ClipboardManager

class MockClipboardServiceDelegate: ClipboardServiceDelegate {
    var receivedContent: String?

    func clipboardDidChange(content: String) {
        receivedContent = content
    }
}

class ClipboardServiceTests: XCTestCase {
    var clipboardService: ClipboardService!
    var mockDelegate: MockClipboardServiceDelegate!

    override func setUp() {
        super.setUp()
        clipboardService = ClipboardService.shared
        mockDelegate = MockClipboardServiceDelegate()
        clipboardService.delegate = mockDelegate
    }

    override func tearDown() {
        clipboardService = nil
        mockDelegate = nil
        super.tearDown()
    }

    func testCopyToClipboard() {
        // Given
        let testString = "Test Content"

        // When
        clipboardService.copyToClipboard(text: testString)

        // Then
        let pasteboardContent = NSPasteboard.general.string(forType: .string)
        XCTAssertEqual(pasteboardContent, testString)
    }

    func testPasteFromClipboard() {
        // Given
        let testString = "Test Content"
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(testString, forType: .string)

        // When
        let result = clipboardService.pasteFromClipboard()

        // Then
        XCTAssertEqual(result, testString)
    }

    func testDelegateNotification() {
        // Given
        let testString = "Test Content"

        // When
        clipboardService.copyToClipboard(text: testString)

        // Then
        // Wait a bit for the timer to trigger
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.mockDelegate.receivedContent, testString)
        }
    }
}
