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

            describe("submits input from the text field") {
                it("delegates to the generator") {
                    let controller = MainViewController()
                    let generator = MockPrimeFactorsGenerator()
                    controller.generator = generator

                    controller.submitNumberInput()

                    expect(generator.generateWasCalled).to(beTrue())
                }
            }
        }
    }
}
