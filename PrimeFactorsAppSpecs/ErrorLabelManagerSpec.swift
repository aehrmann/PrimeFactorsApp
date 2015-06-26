import Foundation
import Quick
import Nimble
import PrimeFactorsApp

class ErrorLabelManagerSpec: QuickSpec {
    override func spec() {
        describe("ErrorLabelManager") {
            describe("creating a manager") {
                it("stores a text label") {
                    let label = UILabel()
                    let manager = ErrorLabelManager(label: label)

                    expect(manager.label).notTo(beNil())
                }
            }

            describe("updating the label") {
                var label = UILabel()
                var manager = ErrorLabelManager(label: label)

                beforeEach {
                    label = UILabel()
                    manager = ErrorLabelManager(label: label)
                }

                describe("displaying the label") {
                    context("when input is valid") {
                        it("hides the label") {
                            let userInput = "2"
                            manager.update(userInput)
                            expect(label.hidden).to(beTrue())
                        }
                    }

                    context("when input is invalid") {
                        it("shows the label") {
                            let userInput = "not valid"
                            manager.update(userInput)
                            expect(label.hidden).to(beFalse())
                        }
                    }

                    context("when input is empty") {
                        it("hides the label") {
                            let userInput = ""
                            manager.update(userInput)
                            expect(label.hidden).to(beTrue())
                        }
                    }
                }

                describe("setting the label's text") {
                    
                    context("when input length is less than or equal to the allowed number of characters") {

                        it("displays an error message with the invalid input") {
                            let userInput = "not valid"
                            let errorMessage = "\"\(userInput)\" is not an integer"

                            manager.update(userInput)

                            expect(label.text).to(equal(errorMessage))
                        }

                    }

                    context("when input length is greater than the allowed number of characters") {
                        it("displays an error message with the truncated invalid input") {
                            let userInput = "not an integer"
                            let truncatedInput = "not an integ..."
                            let errorMessage = "\"\(truncatedInput)\" is not an integer"

                            manager.update(userInput)

                            expect(label.text).to(equal(errorMessage))
                        }
                        
                    }

                }
            }
        }
    }
}