import UIKit

public class MainViewController: UIViewController, UITableViewDataSource {

    @IBOutlet public weak var numberTextField: UITextField!
    @IBOutlet public weak var factorsTableView: UITableView!
    @IBOutlet public weak var errorLabel: ErrorLabel!

    public var generator: FactorsGenerator?
    public var generatedFactors: [Int]?
    public var inputAsInteger: Int?
    public var inputValidator: InputValidator?

    private let characterLimit = 12
    private let customFont = UIFont(name: "Avenir", size: 17.0)

    override public func viewDidLoad() {
        super.viewDidLoad()
        generator = PrimeFactorsGenerator()
        inputValidator = DefaultInputValidator(view: errorLabel)
    }

    @IBAction public func updateFactorsTable() {
        processInput()
        reloadTableData()
    }

    private func processInput() {
        let currentInput = numberTextField.text
        inputValidator?.update(currentInput!)
        generatedFactors = factorsFor(currentInput!)
    }

    private func reloadTableData() {
        factorsTableView.dataSource = self
        factorsTableView.reloadData()
    }

    private func factorsFor(inputString: String) -> [Int] {
        if let integerValue = Int(inputString) {
            inputAsInteger = integerValue
            return generator!.generate(inputAsInteger!)
        } else {
            return []
        }
    }

    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return generatedFactors!.count
    }

    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = String(generatedFactors![indexPath.row])
        cell.textLabel?.font = customFont
        return cell
    }
}