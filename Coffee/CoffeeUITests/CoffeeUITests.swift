import CoffeeKit
import XCTest

final class CoffeeUITests: XCTestCase {
  var app = XCUIApplication()

  override func setUpWithError() throws {
    try super.setUpWithError()
    continueAfterFailure = false
    app = XCUIApplication()
    app.launch()
  }

  func testAddCoffee() throws {
    CoffeesScreen()
      .tapAddCoffeeButton()
  }
  
  func testAddCoffeeWithNoNameShowsAlert() {
    // 1
    CoffeesScreen()
      .tapAddCoffeeButton()
    // 2
    CoffeeScreen()
      .tapSaveCoffee()
      .tapCloseSaveCoffeeErrorAlertButton()
  }

}
