import Foundation
import Quick
import Nimble
import PrimeFactorsApp

class PrimeFactorsGeneratorSpec: QuickSpec {
    let generator = PrimeFactorsGenerator()

    func generatePrimes(number: Int) -> [Int] {
        return generator.generate(number)
    }

    override func spec() {
        describe("Prime Factors Generator") {
            it("generates no prime factors for the number 1") {
                expect(self.generatePrimes(1)).to(equal([]))
            }

            it("generates prime factors for 2") {
                expect(self.generatePrimes(2)).to(equal([2]))
            }

            it("generates prime factors for 3") {
                expect(self.generatePrimes(3)).to(equal([3]))
            }

            it("generates prime factors for 4") {
                expect(self.generatePrimes(4)).to(equal([2, 2]))
            }

            it("generates prime factors for 6") {
                expect(self.generatePrimes(6)).to(equal([2, 3]))
            }

            it("generates prime factors for 8") {
                expect(self.generatePrimes(8)).to(equal([2, 2, 2]))
            }

            it("generates prime factors for 9") {
                expect(self.generatePrimes(9)).to(equal([3, 3]))
            }

            it("generates prime factors for 25") {
                expect(self.generatePrimes(25)).to(equal([5, 5]))
            }

            it("generates prime factors for 2 * 2 * 3 * 5 * 7") {
                expect(self.generatePrimes(2 * 2 * 3 * 5 * 7)).to(equal([2, 2, 3, 5, 7]))
            }


        }
    }
}