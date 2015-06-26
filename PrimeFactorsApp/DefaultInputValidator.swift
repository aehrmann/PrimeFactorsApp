import UIKit

public class DefaultInputValidator: InputValidator {
    public let view: ErrorMessageView

    public init(view: ErrorMessageView) {
        self.view = view
    }

    public func update(userInput: String) {
        if userInput.toInt() != nil || userInput.isEmpty {
            view.inputWasValid()
        } else {
            view.inputWasInvalid(userInput)
        }
    }

}
