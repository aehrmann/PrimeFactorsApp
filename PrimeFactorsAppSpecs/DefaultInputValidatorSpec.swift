import Quick
import Nimble
import PrimeFactorsApp

class DefaultInputValidatorSpec: QuickSpec {
    override func spec() {
        describe("DefaultInputValidator") {
            describe("updating the label") {
                var label: ErrorLabel!
                var inputValidator: DefaultInputValidator!

                beforeEach {
                    label = ErrorLabel()
                    inputValidator = DefaultInputValidator(view: label)
                }

                describe("displaying the label") {
                    context("when input is valid") {
                        it("hides the label") {
                            let userInput = "2"
                            inputValidator.update(userInput)
                            expect(label.hidden).to(beTrue())
                        }
                    }

                    context("when input is invalid") {
                        it("shows the label") {
                            let userInput = "not valid"
                            label.hidden = true
                            inputValidator.update(userInput)
                            expect(label.hidden).to(beFalse())
                        }
                    }

                    context("when input is empty") {
                        it("hides the label") {
                            let userInput = ""
                            inputValidator.update(userInput)
                            expect(label.hidden).to(beTrue())
                        }
                    }
                }

                describe("setting the label's text") {
                    
                    context("when input length is less than or equal to the allowed number of characters") {

                        it("displays an error message with the invalid input") {
                            let userInput = "not valid"
                            let errorMessage = "\"\(userInput)\" is not an integer"

                            inputValidator.update(userInput)

                            expect(label.text).to(equal(errorMessage))
                        }

                    }

                    context("when input length is greater than the allowed number of characters") {
                        it("displays an error message with the truncated invalid input") {
                            let userInput = "not an integer"
                            let truncatedInput = "not an integ..."
                            let errorMessage = "\"\(truncatedInput)\" is not an integer"

                            inputValidator.update(userInput)

                            expect(label.text).to(equal(errorMessage))
                        }
                        
                    }

                }
            }
        }
    }
}