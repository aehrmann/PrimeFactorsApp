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
            describe("submits input from the text field") {
                it("delegates to the generator") {
                    let controller = MainViewController()
                    let button = UIButton()
                    var textField = UITextField()
                    let generator = MockPrimeFactorsGenerator()

                    controller.generateButton = button
                    controller.numberTextField = textField
                    controller.generator = generator

                    controller.submitNumberInput()

                    expect(generator.generateWasCalled).to(beTrue())
                }
            }
        }
    }
}
