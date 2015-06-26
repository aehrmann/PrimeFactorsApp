import UIKit

public protocol ErrorMessageView {

    func inputWasValid()
    func inputWasInvalid(userInput: String)

}

public class ErrorLabel: UILabel, ErrorMessageView {

    private let characterLimit = 12

    required public init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public func inputWasValid() {
        hidden = true
    }

    public func inputWasInvalid(userInput: String) {
        hidden = false
        text = createErrorMessage(userInput)
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
