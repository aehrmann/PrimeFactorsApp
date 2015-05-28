import Foundation
import UIKit

public class MainViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var factorsTableView: UITableView!

    public var generator: FactorsGenerator?
    public var generatedFactors: [Int]?
    public var inputAsInteger: Int?

    override public func viewDidLoad() {
        super.viewDidLoad()
        generator = PrimeFactorsGenerator()
    }

    @IBAction func submitNumberInput() {
        inputAsInteger = numberTextField.text.toInt()
        generatedFactors = generator!.generate(inputAsInteger!)
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
        return cell
    }
}