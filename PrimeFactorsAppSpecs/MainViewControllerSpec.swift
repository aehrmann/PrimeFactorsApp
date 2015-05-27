//
//  HomeViewControllerSpec.swift
//  PrimeFactorsApp
//
//  Created by Ariel Ehrmann on 5/27/15.
//  Copyright (c) 2015 AriAndLisa. All rights reserved.
//

import Foundation
import Quick
import Nimble

class MockPrimeFactorsGenerator: FactorsGenerator {
    var generateWasCalled: Bool

    init() {
        self.generateWasCalled = false
    }

    func generate(number: Int) -> [Int] {
        self.generateWasCalled = true
        return [Int]()
    }
}

class MainViewControllerSpec: QuickSpec {
    override func spec() {
        describe("home view controller") {

            describe("Loading the view") {
                it("builds a generator") {
                    let controller = MainViewController()
                    controller.viewDidLoad()
                    expect(controller.generator).notTo(beNil())
                }
            }

            describe("Submitting input from the text field") {
                var controller: MainViewController?
                var generator: MockPrimeFactorsGenerator?

                beforeEach {
                    controller = MainViewController()
                    generator = MockPrimeFactorsGenerator()
                    controller!.generator = generator
                }

                it("delegates to the generator") {
                    controller!.submitNumberInput()

                    expect(generator!.generateWasCalled).to(beTrue())
                }

                it("stores the generated prime factors") {
                    controller!.submitNumberInput()
                    expect(controller!.generatedFactors).toNot(beNil())
                }
            }
        }
    }
}
