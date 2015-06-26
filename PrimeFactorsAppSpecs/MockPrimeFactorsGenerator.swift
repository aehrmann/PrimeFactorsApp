import Foundation
import PrimeFactorsApp

class MockPrimeFactorsGenerator: FactorsGenerator {
    var generateWasCalled: Bool
    var results: [Int]

    init() {
        self.generateWasCalled = false
        self.results = [Int]()
    }

    func generate(number: Int) -> [Int] {
        self.generateWasCalled = true
        return self.results
    }
}