import Foundation
import UIKit

public class MainViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var factorsTableView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!

    public var generator: FactorsGenerator?
    public var generatedFactors: [Int]?
    public var inputAsInteger: Int?

    private let characterLimit = 12

    override public func viewDidLoad() {
        super.viewDidLoad()
        generator = PrimeFactorsGenerator()
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
        if inputString.isEmpty {
            errorLabel.hidden = true
        } else {
            let errorMessage = createErrorMessage(inputString)
            errorLabel.hidden = false
            errorLabel.text = errorMessage
        }
    }

    private func createErrorMessage(inputString: String) -> String {
        let displayString = formatInputStringForDisplay(inputString, characterLimit: characterLimit)
        return "\"\(displayString)\" is not an integer"
    }

    private func formatInputStringForDisplay(inputString: String, characterLimit: Int) -> String {
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
        let row = indexPath.row
        var cellLabelValue = String(generatedFactors![row])
        cell.textLabel?.text = cellLabelValue
        cell.textLabel?.font = UIFont(name: "Avenir", size: 17.0)
        return cell
    }
}