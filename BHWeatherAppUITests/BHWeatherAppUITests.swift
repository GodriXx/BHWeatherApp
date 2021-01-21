//
//  BHWeatherAppUITests.swift
//  BHWeatherAppUITests
//
//  Created by Bassem Hatira on 19/01/2021.
//

import XCTest

class BHWeatherAppUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    func testBHWeatherApp() {
        
        let predicate = NSPredicate(format: "exists == 1")
    
        // Open Add screen
        let addQuery = app.buttons["xctest--btnAdd"]
        expectation(for: predicate, evaluatedWith: addQuery, handler: nil)
        waitForExpectations(timeout: 30, handler: nil)
        addQuery.tap()
        
        // Tap with keyboard something (Velizy in our example), software keyboard must appear
        app.keys["V"].tap()
        app.keys["e"].tap()
        app.keys["l"].tap()
        app.keys["i"].tap()
        app.keys["z"].tap()
        app.keys["y"].tap()
        
        // Add second element after search, this will dismiss the screen and add new location
        sleep(3)
        let addTableView = app.tables["xctest--addTableView"]
        let addCells = addTableView.cells
        let addCell = addCells.element(boundBy: 1)
        expectation(for: predicate, evaluatedWith: addCell, handler: nil)
        waitForExpectations(timeout: 30, handler: nil)
        addCell.tap()
        
        // Select first element in home screen to display details
        let homeTableView = app.tables["xctest--homeTableView"]
        let homeCells = homeTableView.cells
        let homeCell = homeCells.element(boundBy: 0)
        expectation(for: predicate, evaluatedWith: homeCell, handler: nil)
        waitForExpectations(timeout: 30, handler: nil)
        homeCell.tap()
        sleep(5)
        
        // Back to home screen
        app.navigationBars.buttons.element(boundBy: 0).tap()
        sleep(5)
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
