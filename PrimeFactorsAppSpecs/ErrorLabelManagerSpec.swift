import Foundation
import Quick
import Nimble

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

            }
        }
    }
}