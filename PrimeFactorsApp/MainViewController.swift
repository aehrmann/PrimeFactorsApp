import Foundation
import UIKit

public class MainViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var factorsTableView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!

    public var generator: FactorsGenerator?
    public var generatedFactors: [Int]?
    public var inputAsInteger: Int?

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
            generatedFactors = generator!.generate(inputAsInteger!)
        } else {
            if currentInput.isEmpty {
                errorLabel.hidden = true
            } else {
                let errorMessage: String?
                if count(currentInput) >= 12 {
                    let substringRange = Range(start: currentInput.startIndex, end: advance(currentInput.startIndex, 12))
                    let truncatedInput = currentInput.substringWithRange(substringRange) + "..."
                    errorMessage = "\"\(truncatedInput)\" is not an integer"
                } else {
                    errorMessage = "\"\(currentInput)\" is not an integer"
                }
                errorLabel.hidden = false
                errorLabel.text = errorMessage
            }
            generatedFactors = []
        }
    }

    private func reloadTableData() {
        factorsTableView.dataSource = self
        factorsTableView.reloadData()
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