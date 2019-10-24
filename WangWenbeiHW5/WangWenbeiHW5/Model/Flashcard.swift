//
//  Flashcard.swift
//  WangWenbeiHW5
//
//  Created by 王文贝 on 2019/10/22.
//  Copyright © 2019 Wenbei Wang. All rights reserved.
//

import Foundation

struct Flashcard:Equatable {
    private var question : String
    private var answer : String
    public var isFavorite : Bool
    
    func getQuestion() -> String {
        return question
    }
    func getAnswer() -> String {
        return answer
    }
    init(question: String, answer: String, isFavorite: Bool=false){
        self.question = question
        self.answer = answer
        self.isFavorite = isFavorite
    }
    
}

class FlashcardsModel: NSObject, FlashcardsDataModel {
    // singleton
    static let sharedInstance = FlashcardsModel()
    
    private var flashcards = [Flashcard]()
    private var currentIndex : Int?
    var questionDisplayed : Bool
    override init() {
        self.currentIndex = 0
        // need five flashcards
        let card1 = Flashcard(question: "First Q", answer: "First A")
        let card2 = Flashcard(question: "Second Q", answer: "Second A")
//        let card3 =
//        let card4 =
        
        self.flashcards = [card1, card2]
    }
    func numberOfFlashcards() -> Int {
        return flashcards.count
    }
    
    func randomFlashcard() -> Flashcard? {
        let num = flashcards.count
        
        if num > 0 {
            let index = Int.random(in: 0..<num)
            return flashcards[index]
        }
        return nil
    }
    
    func flashcard(at index: Int) -> Flashcard? {
        if index > 0 && index < flashcards.count{
            return flashcards[index]
        }
        return nil
    }
    
    func nextFlashcard() -> Flashcard? {
        <#code#>
    }
    
    func previousFlashcard() -> Flashcard? {
        <#code#>
    }
    
    func insert(question: String, answer: String, favorite: Bool) {
        <#code#>
    }
    
    func insert(question: String, answer: String, favorite: Bool, at index: Int) {
        <#code#>
    }
    
    func currentFlashcard() -> Flashcard? {
        <#code#>
    }
    
    func removeFlashcard(at index: Int) {
        <#code#>
    }
    
    func toggleFavorite() {
        <#code#>
    }
    
    func favoriteFlashcards() -> [Flashcard] {
        <#code#>
    }
    
     
}
