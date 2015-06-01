import Foundation
import UIKit

public class MainViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var factorsTableView: UITableView!

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
        if let integerValue = numberTextField.text.toInt() {
            inputAsInteger = integerValue
            generatedFactors = generator!.generate(inputAsInteger!)
        } else {
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