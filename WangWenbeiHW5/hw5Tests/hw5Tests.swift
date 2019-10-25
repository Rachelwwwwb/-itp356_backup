//
//  hw5Tests.swift
//  hw5Tests
//
//  Created by 王文贝 on 2019/10/23.
//  Copyright © 2019 Wenbei Wang. All rights reserved.
//

import XCTest
@testable import hw5

class hw5Tests: XCTestCase {
    private var model = FlashcardsModel()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        model = FlashcardsModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSingleton(){
        let model1 = FlashcardsModel.sharedInstance
        let model2 = FlashcardsModel.sharedInstance
        model2.insert(question: "Which color represents USC", answer: "Cardinal Red", favorite: false)
        XCTAssertEqual(model1.numberOfFlashcards(), model2.numberOfFlashcards())
    }
    
    func testNumOfFla(){
        XCTAssertEqual(model.numberOfFlashcards(), 5)
    }
    
    func testCurrent(){
        XCTAssertEqual(model.currentFlashcard(), model.flashcard(at: 0))
    }
    
    func testRandom(){
        XCTAssertNotEqual(model.currentFlashcard(), model.randomFlashcard())
    }
    
    func testInsert(){
        let model2 = FlashcardsModel()
        model2.insert(question: "Which color represents USC", answer: "Cardinal Red", favorite: false)
        XCTAssertNotEqual(model2.numberOfFlashcards(), model.numberOfFlashcards())
    }
    
   func testInsertIndex(){
        let model2 = FlashcardsModel()
        model2.insert(question: "Which color represents USC", answer: "Cardinal Red", favorite: false, at: 0)
        XCTAssertNotEqual(model2.numberOfFlashcards(), model.numberOfFlashcards())
        XCTAssertNotEqual(model2.flashcard(at: 0), model.flashcard(at: 0))
    }
    
    func testRemove(){
        let model2 = FlashcardsModel()
        model2.removeFlashcard(at: 0)
        XCTAssertNotEqual(model2.numberOfFlashcards(), model.numberOfFlashcards())
    }
    // dont know how to test
    func testAt(){
        XCTAssertEqual(model.flashcard(at: 1), model.currentFlashcard())
    }
    
    func testPrev(){
        XCTAssertEqual(model.previousFlashcard(), model.flashcard(at: model.numberOfFlashcards()-1))
    }
    
    func testNext(){
        XCTAssertEqual(model.nextFlashcard(), model.flashcard(at: 1))
    }
    
    func testFav(){
        let model2 = FlashcardsModel()
        model2.toggleFavorite()
        XCTAssertNotEqual(model2, model)
    }
    func testFavCards(){
        for n in 0...model.numberOfFlashcards()-1 {
            model.flashcard(at: n)
            model.toggleFavorite()
        }
        XCTAssertEqual(model.favoriteFlashcards().count, model.numberOfFlashcards())
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
