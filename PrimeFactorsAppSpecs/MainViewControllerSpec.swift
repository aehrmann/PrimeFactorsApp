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
                    controller.numberTextField.text = "2"
                }

                it("converts the text field's content to a numeric value") {
                    controller.numberTextField.text = "38"

                    controller.submitNumberInput()

                    expect(controller.inputAsInteger).to(equal(38))
                }

                it("delegates to the generator") {
                    controller.submitNumberInput()

                    expect(generator.generateWasCalled).to(beTrue())
                }

                it("stores the generated prime factors") {
                    controller.submitNumberInput()

                    expect(controller.generatedFactors).toNot(beNil())
                }

                xit("has the correct values in each row of the table") {
                    generator.results = [2, 3, 5]
                    tableView.dataSource = controller

                    controller.submitNumberInput()

                    var indexPath = NSIndexPath(forRow: 0, inSection: 0)
                    var cell = controller.factorsTableView.cellForRowAtIndexPath(indexPath)
                    var textLabel = cell!.textLabel
                    expect(textLabel!.text).to(equal("2"))
                }

            }
        }
    }
}
