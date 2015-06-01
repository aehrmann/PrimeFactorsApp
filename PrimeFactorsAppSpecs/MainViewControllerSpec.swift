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
            let placeholderInput = "2"

            beforeEach {
                controller = MainViewController()
                generator = MockPrimeFactorsGenerator()
                textField = UITextField()
                tableView = UITableView()
                controller.generator = generator
                controller.numberTextField = textField
                controller.factorsTableView = tableView
                controller.numberTextField.text = placeholderInput
            }

            describe("Loading the view") {
                it("builds a generator") {
                    let controller = MainViewController()

                    controller.viewDidLoad()

                    expect(controller.generator).notTo(beNil())
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
                    beforeEach {
                        controller.numberTextField.text = "not an integer"
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
