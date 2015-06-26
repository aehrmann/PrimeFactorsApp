import UIKit

class MockUITableView: UITableView {
    var reloadDataWasCalled = false

    override func reloadData() {
        reloadDataWasCalled = true
    }
}