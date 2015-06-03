import Foundation
import UIKit

public class MainViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var factorsTableView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!

    public var generator: FactorsGenerator?
    public var generatedFactors: [Int]?
    public var inputAsInteger: Int?
    public var labelManager: ErrorLabelManager?

    private let characterLimit = 12
    private let customFont = UIFont(name: "Avenir", size: 17.0)

    override public func viewDidLoad() {
        super.viewDidLoad()
        generator = PrimeFactorsGenerator()
        labelManager = ErrorLabelManager(label: errorLabel)
    }

    @IBAction func updateFactorsTable() {
        processInput()
        reloadTableData()
    }

    private func processInput() {
        let currentInput = numberTextField.text
        if let integerValue = currentInput.toInt() {
            inputAsInteger = integerValue
        } else {
            updateLabel(currentInput)
        }


        generatedFactors = factorsFor(currentInput)
    }

    private func reloadTableData() {
        factorsTableView.dataSource = self
        factorsTableView.reloadData()
    }

    private func factorsFor(inputString: String) -> [Int] {
        if let integerValue = inputString.toInt() {
            inputAsInteger = integerValue
            return generator!.generate(inputAsInteger!)
        }
        return []
    }

    private func updateLabel(inputString: String) {
        errorLabel.hidden = isVisible(forInput: inputString)
        if !errorLabel.hidden {
            errorLabel.text = createErrorMessage(inputString)
        }
    }

    private func isVisible(forInput inputString: String) -> Bool {
        return inputString.isEmpty
    }

    private func createErrorMessage(inputString: String) -> String {
        let displayString = formatForDisplay(inputString: inputString, characterLimit: characterLimit)
        return "\"\(displayString)\" is not an integer"
    }

    private func formatForDisplay(#inputString: String, characterLimit: Int) -> String {
        var displayString = inputString
        if count(inputString) >= characterLimit {
            let substringRange = Range(start: inputString.startIndex, end: advance(inputString.startIndex, characterLimit))
            displayString = inputString.substringWithRange(substringRange) + "..."
        }
        return displayString
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