import UIKit

public class ErrorLabelManager {
    let label: UILabel

    public init(label: UILabel) {
        self.label = label
    }

    public func update(userInput: String) {
        label.hidden = true
    }
}