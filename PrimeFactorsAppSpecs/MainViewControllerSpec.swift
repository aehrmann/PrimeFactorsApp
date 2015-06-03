import Foundation
import Quick
import Nimble

class MainViewControllerSpec: QuickSpec {
    override func spec() {
        describe("MainViewController") {
            var controller = MainViewController()
            var generator = MockPrimeFactorsGenerator()
            var textField = UITextField()
            var tableView = UITableView()
            var errorLabel = UILabel()
            let placeholderInput = "2"

            beforeEach {
                controller = MainViewController()
                generator = MockPrimeFactorsGenerator()
                textField = UITextField()
                tableView = UITableView()
                errorLabel = UILabel()
                controller.generator = generator
                controller.numberTextField = textField
                controller.factorsTableView = tableView
                controller.numberTextField.text = placeholderInput
                controller.errorLabel = errorLabel
            }

            describe("Loading the view") {
                beforeEach {
                    let controller = MainViewController()
                    let errorLabel = UILabel()
                    controller.errorLabel = errorLabel
                }
                it("builds a generator") {
                    controller.viewDidLoad()

                    expect(controller.generator).notTo(beNil())
                }

                it("build a label manager") {
                    controller.viewDidLoad()

                    expect(controller.labelManager).notTo(beNil())
                }
            }

            describe("Processing input from the text field") {
                it("converts the text field's content to an integer value") {
                    controller.numberTextField.text = "38"

                    controller.updateFactorsTable()

                    expect(controller.inputAsInteger).to(equal(38))
                }

                context("when the input is an integer") {
                    beforeEach {
                        controller.numberTextField.text = "5"
                    }

                    it("delegates to the generator") {
                        controller.updateFactorsTable()

                        expect(generator.generateWasCalled).to(beTrue())
                    }

                    it("stores the generated prime factors") {
                        controller.updateFactorsTable()

                        expect(controller.generatedFactors).toNot(beNil())
                    }
                }

                context("when the input is not an integer") {
                    let errorTextLabel = UILabel()
                    let nonIntegerInput = "not an integer"
                    let emptyInput = ""
                    let errorMessage = "\"\(nonIntegerInput)\" is not an integer"

                    beforeEach {
                        controller.numberTextField.text = nonIntegerInput
                        controller.errorLabel = errorTextLabel
                    }

                    context("when input length is less than or equal to the allowed number of characters") {
                        it("displays an error message with the invalid input") {
                            let input = "input"
                            controller.numberTextField.text = input
                            let errorMessage = "\"\(input)\" is not an integer"

                            controller.updateFactorsTable()

                            expect(controller.errorLabel.hidden).to(beFalse())
                            expect(controller.errorLabel.text).to(equal(errorMessage))
                        }

                    }

                    context("when input length is greater than the allowed number of characters") {
                        it("displays an error message with the truncated invalid input") {
                            let nonIntegerInput = "not an integer"
                            let truncatedInput = "not an integ..."

                            let errorMessage = "\"\(truncatedInput)\" is not an integer"

                            controller.updateFactorsTable()

                            expect(controller.errorLabel.hidden).to(beFalse())
                            expect(controller.errorLabel.text).to(equal(errorMessage))
                        }

                    }

                    it("does not display an error message if the input is an empty string") {
                        controller.numberTextField.text = emptyInput

                        controller.updateFactorsTable()

                        expect(controller.errorLabel.hidden).to(beTrue())
                    }

                    it("does not delegate to the generator") {
                        controller.updateFactorsTable()

                        expect(generator.generateWasCalled).to(beFalse())
                    }

                    it("has an empty list of prime factors") {
                        controller.updateFactorsTable()

                        expect(controller.generatedFactors?.isEmpty).to(beTrue())
                    }
                }
            }

            describe("Populating the table with generated factors") {

                it("sets the table view's data source") {
                    controller.updateFactorsTable()

                    expect(controller.factorsTableView.dataSource).notTo(beNil())
                }

                it("reloads the table view's data") {
                    let tableView = MockUITableView()
                    controller.factorsTableView = tableView

                    controller.updateFactorsTable()

                    expect(tableView.reloadDataWasCalled).to(beTrue())
                }

                it("populates the table with the correct number of rows") {
                    generator.results = [2, 3, 5, 7]

                    controller.updateFactorsTable()

                    expect(controller.factorsTableView.numberOfRowsInSection(0)).to(equal(4))
                }

                it("has the correct values in each row of the table") {
                    generator.results = [2, 3, 5]

                    controller.updateFactorsTable()

                    var indexPath = NSIndexPath(forRow: 0, inSection: 0)
                    var cell = controller.tableView(tableView, cellForRowAtIndexPath: indexPath)
                    var textLabel = cell.textLabel
                    expect(textLabel!.text).to(equal("2"))

                    indexPath = NSIndexPath(forRow: 1, inSection: 0)
                    cell = controller.tableView(tableView, cellForRowAtIndexPath: indexPath)
                    textLabel = cell.textLabel
                    expect(textLabel!.text).to(equal("3"))

                    indexPath = NSIndexPath(forRow: 2, inSection: 0)
                    cell = controller.tableView(tableView, cellForRowAtIndexPath: indexPath)
                    textLabel = cell.textLabel
                    expect(textLabel!.text).to(equal("5"))
                }
            }
        }
    }
}
