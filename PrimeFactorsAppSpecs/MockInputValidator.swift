import PrimeFactorsApp

class MockInputValidator: InputValidator {
    var updateWasCalled = false

    func update(input: String) {
        updateWasCalled = true
    }
}