public class PrimeFactorsGenerator: FactorsGenerator {

    public init() {}

    public func generate(number: Int) -> [Int] {
        var factors = [Int]()
        var currentFactor = 2
        var currentNumber = number
        while currentNumber > 1 {
            while currentNumber % currentFactor == 0 {
                factors.append(currentFactor)
                currentNumber = number/currentFactor
            }
            currentFactor += 1
        }
        return factors
    }

}
