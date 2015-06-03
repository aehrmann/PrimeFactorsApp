import Foundation
import UIKit

class MockErrorLabelManager: LabelManager {
    var updateWasCalled: Bool

    init() {
        self.updateWasCalled = false
    }

    func update(input: String) {
        self.updateWasCalled = true
    }
}