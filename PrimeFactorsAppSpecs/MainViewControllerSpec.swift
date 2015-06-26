import Quick
import Nimble
import PrimeFactorsApp

class MainViewControllerSpec: QuickSpec {
    override func spec() {
        describe("MainViewController") {
            var controller: MainViewController!
            var generator: MockPrimeFactorsGenerator!
            var textField: UITextField!
            var tableView: UITableView!
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
                var controller = MainViewController()
                var errorLabel = UILabel()
                controller.errorLabel = errorLabel

                beforeEach {
                    controller = MainViewController()
                    errorLabel = UILabel()
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
                it("delegates to the label manager") {
                    let label = UILabel()
                    let labelManager = MockErrorLabelManager()
                    controller.labelManager = labelManager

                    controller.updateFactorsTable()

                    expect(labelManager.updateWasCalled).to(beTrue())
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
