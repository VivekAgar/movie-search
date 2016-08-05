//
//  movieSearchUITests.swift
//  movieSearchUITests
//
//  Created by Satya on 30/07/16.
//  Copyright © 2016 My Company. All rights reserved.
//

import XCTest

class movieSearchUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    func test_SearchBarExists()
    {
        //let app = XCUIApplication().launch()
        XCUIDevice.sharedDevice().orientation = .FaceUp
        XCUIDevice.sharedDevice().orientation = .FaceUp
        
        let app = XCUIApplication()
        let searchMoviesEpisodesSeriesSearchField = app.searchFields["Search Movies, episodes,series "]
        XCTAssertTrue(searchMoviesEpisodesSeriesSearchField.exists, "Search Bar Must Be Exists in Portrait Mode")
    }
    
    func test_SearchBarExists_LandscapeMode(){
        XCUIDevice.sharedDevice().orientation = .LandscapeLeft
        let app = XCUIApplication()
        let searchMoviesEpisodesSeriesSearchField = app.searchFields["Search Movies, episodes,series "]
        XCTAssertTrue(searchMoviesEpisodesSeriesSearchField.exists, "Search Bar Must Be Exists in Landscape Mode")
    }
    
    func test_MoviesButton_Exists_LandscapeMode(){
        XCUIDevice.sharedDevice().orientation = .LandscapeLeft
        let app = XCUIApplication()
        let moviesButton = app.segmentedControls.buttons["Movies"]
        XCTAssertTrue(moviesButton.exists, "Movies Button Must Be Exists in segmented control in Landscape Mode")
    }
        
    func test_SeriesButton_Exists_LandscapeMode(){
        XCUIDevice.sharedDevice().orientation = .LandscapeLeft
        let app = XCUIApplication()
        let seriesButton = app.segmentedControls.buttons["Series"]
        XCTAssertTrue(seriesButton.exists, "Series Button Must Be Exists in  segmented control in Landscape Mode")
        
    }
        
    func test_EpisodeButton_Exists_LandscapeMode(){

        XCUIDevice.sharedDevice().orientation = .LandscapeLeft
        let app = XCUIApplication()
        let episodesButton = app.segmentedControls.buttons["Episodes"]
        XCTAssertTrue(episodesButton.exists, "Episodes Button Must Be Exists in  segmented control in Landscape Mode")
    }
    
    func test_EpisodeButton_Exists_portraitMode(){
        
        XCUIDevice.sharedDevice().orientation = .FaceUp
        let app = XCUIApplication()
        let episodesButton = app.segmentedControls.buttons["Episodes"]
        XCTAssertTrue(episodesButton.exists, "Episodes Button Must Be Exists in segmented control in  Portrait Mode")
    }
        
        
//        app.buttons["All"].tap()
//        
//        let cancelButton = app.buttons["Cancel"]
//        cancelButton.tap()
//        XCUIDevice.sharedDevice().orientation = .LandscapeLeft
//        searchMoviesEpisodesSeriesSearchField.tap()
//        cancelButton.tap()
//        moviesButton.tap()
//        seriesButton.tap()
//        episodesButton.tap()
//        app.searchFields["Search Movies, episodes,series "]
//        app.buttons["Search"].tap()
//        app.typeText("\n")

        
        
        
        //XCTAssertTrue(app.staticTexts["Search Movies, episodes,series"].exists , "Search Bar with text Must Be exist")
        
    //}
    
    
  func test_UITest()
  {
//    XCUIDevice.sharedDevice().orientation = .FaceUp
//    XCUIDevice.sharedDevice().orientation = .FaceUp
//    
//    let app = app2
//    app.searchFields["Search Movies, episodes,series "].tap()
//    app.searchFields["Search Movies, episodes,series "]
//    
//    let app2 = app
//    app2.keyboards.buttons["Search"].tap()
//    app.typeText("\n")
//    app.tables.childrenMatchingType(.Cell).elementBoundByIndex(2).staticTexts["Harry Potter and the Chamber of Secrets"].tap(.segmentedControls.buttons["Movies"]U_TOKEN@*/.tap()
//    XCUIDevice.sharedDevice().orientation = .Portrait
    
    
  }
    
    
    
    
    
}
