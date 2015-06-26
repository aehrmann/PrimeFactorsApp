import PrimeFactorsApp

class MockErrorLabelManager: LabelManager {
    var updateWasCalled = false

    func update(input: String) {
        updateWasCalled = true
    }
}