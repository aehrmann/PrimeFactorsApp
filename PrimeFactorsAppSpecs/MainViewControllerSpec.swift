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
                var controller = MainViewController()
                var generator = MockPrimeFactorsGenerator()
                var textField = UITextField()
                var tableView = UITableView()

                beforeEach {
                    controller = MainViewController()
                    generator = MockPrimeFactorsGenerator()
                    textField = UITextField()
                    tableView = UITableView()
                    controller.generator = generator
                    controller.numberTextField = textField
                    controller.factorsTableView = tableView
                }

                it("delegates to the generator") {
                    controller.numberTextField.text = "2"

                    controller.submitNumberInput()

                    expect(generator.generateWasCalled).to(beTrue())
                }

                it("stores the correct generated prime factors") {
                    controller.numberTextField.text = "2"
                    controller.generator = PrimeFactorsGenerator()

                    controller.submitNumberInput()

                    expect(controller.generatedFactors).to(equal([2]))
                }

                it("has the correct number of rows in the table") {
                    controller.numberTextField.text = "2"
                    generator.results = [2, 3, 5]
                    tableView.dataSource = controller

                    controller.submitNumberInput()

                    expect(controller.factorsTableView.numberOfRowsInSection(0)).to(equal(3))
                }

            }
        }
    }
}
