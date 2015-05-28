import Foundation

class PrimeFactorsGenerator: FactorsGenerator {
    func generate(var number: Int) -> [Int] {
        var factors = [Int]()
        var currentFactor = 2
        while number > 1 {
            while number % currentFactor == 0 {
                factors.append(currentFactor)
                number = number/currentFactor
            }
            currentFactor++
        }
        return factors
    }
}
