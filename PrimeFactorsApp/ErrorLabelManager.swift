import UIKit

public class ErrorLabelManager: LabelManager {
    public let label: UILabel
    private let characterLimit = 12

    public init(label: UILabel) {
        self.label = label
    }

    public func update(userInput: String) {
        if userInput.toInt() != nil || userInput.isEmpty {
            label.hidden = true
        } else {
            label.hidden = false
            label.text = createErrorMessage(userInput)
        }
    }

    private func createErrorMessage(inputString: String) -> String {
        let displayString = formatForDisplay(inputString: inputString)
        return "\"\(displayString)\" is not an integer"
    }

    private func formatForDisplay(#inputString: String) -> String {
        var displayString = inputString
        if count(inputString) >= self.characterLimit {
            let substringRange = Range(start: inputString.startIndex, end: advance(inputString.startIndex, self.characterLimit))
            displayString = inputString.substringWithRange(substringRange) + "..."
        }
        return displayString
    }

}