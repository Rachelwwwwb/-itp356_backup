//
//  Flashcard.swift
//  hw5
//
//  Created by 王文贝 on 2019/10/23.
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
        self.questionDisplayed = false
        // need five flashcards
        let card1 = Flashcard(question: "Which animal  ", answer: "Bonobo")
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
            var index = Int.random(in: 0..<num)
            while index == currentIndex {
                index = Int.random(in: 0..<num)
            }
            currentIndex = index
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
        let current = currentIndex ?? -1
        if current > 0 && current < flashcards.count - 1{
            return flashcards[current + 1]
        }
        else if current == flashcards.count - 1 {
            return flashcards[0]
        }
        return nil
    }
    
    func previousFlashcard() -> Flashcard? {
        let current = currentIndex ?? -1
        if current > 0 && current < flashcards.count {
            return flashcards[current - 1]
        }
        else if current == 0 {
            return flashcards[flashcards.count - 1]
        }
        return nil
    }
    
    func insert(question: String, answer: String, favorite: Bool) {
        let fc = Flashcard(question:question, answer:answer, isFavorite: favorite)
        flashcards.insert(fc,at: flashcards.count)
        currentIndex = flashcards.count - 1
    }
    
    func insert(question: String, answer: String, favorite: Bool, at index: Int) {
        let fc = Flashcard(question:question, answer:answer, isFavorite: favorite)
        if index >= 0 && index <= flashcards.count {
            flashcards.insert(fc, at:index)
        }
        currentIndex = index
    }
    
    func currentFlashcard() -> Flashcard? {
        let current = currentIndex ?? -1
        if current >= 0 && current < flashcards.count {
            return flashcards[current]
        }
        return nil
    }
    
    func removeFlashcard(at index: Int) {
        if index >= 0 && index < flashcards.count {
            flashcards.remove(at:index)
        }
        else {
            flashcards.remove(at:flashcards.count - 1)
        }
        //set the current index to somewhere
        currentIndex = index - 1
    }
    
    func toggleFavorite() {
        let current = currentIndex ?? -1
        if current >= 0 && current < flashcards.count {
            flashcards[current].isFavorite = !flashcards[current].isFavorite
        }
    }
    
    func favoriteFlashcards() -> [Flashcard] {
        var fav = [Flashcard]()
        for card in flashcards {
            fav.insert(card,at:fav.count)
        }
        return fav
    }
    
     
}

