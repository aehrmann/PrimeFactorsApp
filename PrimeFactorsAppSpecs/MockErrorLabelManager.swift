import Foundation
import UIKit
import PrimeFactorsApp

class MockErrorLabelManager: LabelManager {
    var updateWasCalled: Bool

    init() {
        self.updateWasCalled = false
    }

    func update(input: String) {
        self.updateWasCalled = true
    }
}