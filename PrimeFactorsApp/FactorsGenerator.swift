import Foundation

public protocol FactorsGenerator {
    func generate(number: Int) -> [Int]
}