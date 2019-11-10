//
//  ViewController.swift
//  hw5
//
//  Created by 王文贝 on 2019/10/23.
//  Copyright © 2019 Wenbei Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var model = FlashcardsModel.sharedInstance
    var firstColor = true
    let color1 = UIColor.black
    let color2 = UIColor.red
    
    //IBOutlets
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBAction func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .right {
            let swipeRight = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: rightAway)
            swipeRight.addCompletion(rightBack)
            swipeRight.startAnimation()
        }
        else {
            let swipeLeft = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: leftAway)
            swipeLeft.addCompletion(leftBack)
            swipeLeft.startAnimation()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let doubletap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubletap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubletap)
        
        let singletap = UITapGestureRecognizer(target: self, action: #selector(singleTapped))
        singletap.numberOfTapsRequired = 1
        view.addGestureRecognizer(singletap)
        
        singletap.require(toFail: doubletap)
        singletap.delaysTouchesBegan = true
        doubletap.delaysTouchesBegan = true
        getRandomQuestion()
    }
    
    @objc func doubleTapped() {
        let fadeOut = UIViewPropertyAnimator (duration: 1, curve: .linear, animations: fadeOutLabel)
        fadeOut.addCompletion(changeLabel)
        fadeOut.startAnimation()
    }
    @objc func singleTapped() {
        let firstAnimator = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: fadeUp)
        firstAnimator.addCompletion(fadeBack)
        firstAnimator.startAnimation()
    }
    func fadeOutLabel() {
        questionLabel.alpha = 0
    }
    func fadeInLabel() {
        questionLabel.alpha = 1
    }
    func changeLabel(postion:UIViewAnimatingPosition) {
        if model.questionDisplayed {
            model.questionDisplayed = false
            if let current = model.currentFlashcard() {
                questionLabel.text = current.getAnswer()
            }
            else {
                questionLabel.text = "Please add more flashcards"
            }
        }
        else {
            model.questionDisplayed = true
            if let current = model.currentFlashcard() {
                questionLabel.text = current.getQuestion()
            }
            else {
                questionLabel.text = "Please add more flashcards"
            }
        }
        if firstColor {
            questionLabel.textColor = color2
            firstColor = false
        }
        else {
            questionLabel.textColor = color1
            firstColor = true
        }
        let appearAnimation = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: {() in
        self.fadeInLabel() })
        appearAnimation.startAnimation()
    }
    func getRandomQuestion() {
        if let randomQuestion = model.randomFlashcard() {
            questionLabel.text = randomQuestion.getQuestion()
        }
        else {
            questionLabel.text = "There are no more flashcards"
        }
    }
    func fadeUp() {
        questionLabel.transform = CGAffineTransform(translationX: 0, y: -view.frame.size.height)
    }
    func fadeBack (position: UIViewAnimatingPosition)
    {
        // pop back to the position
        if let random = model.randomFlashcard() {
            questionLabel.textColor = color1
            model.questionDisplayed = true
            firstColor = true
            questionLabel.text = random.getQuestion()
        } else {
            questionLabel.text = "There are no more flashcards"
        }
        let backAnimation = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: {() in
        self.questionLabel.transform = CGAffineTransform(translationX: 0, y: 0) })
        backAnimation.startAnimation()
        
    }
    func rightAway() {
        questionLabel.transform = CGAffineTransform(translationX: view.frame.size.width, y: 0)
    }
    func leftAway() {
        questionLabel.transform = CGAffineTransform(translationX: -view.frame.size.width, y: 0)
    }
    func leftBack (position: UIViewAnimatingPosition){
        if let nextQuestion = model.nextFlashcard() {
            questionLabel.textColor = color1
            model.questionDisplayed = true
            firstColor = true
            questionLabel.text = nextQuestion.getQuestion()
        }
        else {
            questionLabel.text = "There are no more flashcards"
        }
        questionLabel.transform = CGAffineTransform(translationX: view.frame.size.width, y: 0)
        let leftBackAnimation = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: {() in
        self.questionLabel.transform = CGAffineTransform(translationX: 0, y: 0) })
        leftBackAnimation.startAnimation()
    }
    
    func rightBack (position: UIViewAnimatingPosition){
        if let prevQuestion = model.previousFlashcard() {
            questionLabel.textColor = color1
            model.questionDisplayed = true
            firstColor = true
            questionLabel.text = prevQuestion.getQuestion()
        }
        else {
            questionLabel.text = "There are no more flashcards"
        }
        questionLabel.transform = CGAffineTransform(translationX: -view.frame.size.width, y: 0)
        let rightBackAnimation = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: {() in
        self.questionLabel.transform = CGAffineTransform(translationX: 0, y: 0) })
        rightBackAnimation.startAnimation()
    }


}

