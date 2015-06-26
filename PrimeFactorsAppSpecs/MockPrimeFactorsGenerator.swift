import PrimeFactorsApp

class MockPrimeFactorsGenerator: FactorsGenerator {
    var generateWasCalled = false
    var results: [Int] = []

    func generate(number: Int) -> [Int] {
        generateWasCalled = true
        return results
    }
}