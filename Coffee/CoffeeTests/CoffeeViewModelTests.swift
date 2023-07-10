import XCTest
@testable import CoffeeChanhee1234

@MainActor
final class CoffeeViewModelTests: XCTestCase {
  var model = CoffeeViewModel(coffeeDataStore: TestCoffeeDataStore())

  override func setUp() async throws {
    try await super.setUp()
    model = CoffeeViewModel(coffeeDataStore: TestCoffeeDataStore())
    try await model.updateCoffees()
  }

  func testCoffees() async throws {
    XCTAssertEqual(model.coffees.count, 2)
  }

  func testSaveNewCoffee() async throws {
    var coffeeToSave = CoffeeViewModel.newCoffee
    coffeeToSave.name = "Coffee"

    try await model.saveCoffee(coffeeToSave)

    XCTAssertEqual(model.coffees.count, 3)
  }

  func testSaveExistingCoffee() async throws {
    var coffeeToEdit = model.coffees[0]
    let newName = "New Coffee Name"
    coffeeToEdit.name = newName

    try await model.saveCoffee(coffeeToEdit)

    XCTAssertEqual(model.coffees[0].name, newName)
    XCTAssertEqual(model.coffees.count, 2)
  }
  
  func testSaveCoffeeWithEmptyName() async throws {
    // 1
    var coffeeToSave = CoffeeViewModel.newCoffee
    coffeeToSave.name = ""

    do {
      // 2
      try await model.saveCoffee(coffeeToSave)
      XCTFail("Coffee with no name should throw empty name error")
    } catch CoffeeViewModel.CoffeeError.emptyName {
      // 3
      XCTAssert(model.showCoffeeErrorAlert)
      XCTAssertEqual(model.saveCoffeeError, .emptyName)
    } catch {
      // 4
      XCTFail("Coffee with no name should throw empty name error")
    }
  }

}
