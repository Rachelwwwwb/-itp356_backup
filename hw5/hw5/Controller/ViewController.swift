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
    
    //IBOutlets
    @IBOutlet weak var questionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getRandomQuestion()
    }
    
    func getRandomQuestion() {
        if let randomQuestion = model.randomFlashcard() {
            questionLabel.text = randomQuestion.getQuestion()
        }
        else {
            questionLabel.text = "cannot find any questions"
        }
    }
    func fadeUp() {
        questionLabel.transform = CGAffineTransform(translationX: 0, y: -view.frame.size.height)
    }
    func fadeBack (position: UIViewAnimatingPosition)
    {
        // pop back to the position
        if let random = model.randomFlashcard() {
            questionLabel.text = random.getQuestion()
        } else {
            questionLabel.text = "No more quotes"
        }
        let backAnimation = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: {() in
        self.questionLabel.transform = CGAffineTransform(translationX: 0, y: 0) })
        backAnimation.startAnimation()
        
    }
    func rightAway() {
        questionLabel.transform = CGAffineTransform(translationX: view.frame.size.width, y: 0)
    }
    func rightBack (position: UIViewAnimatingPosition){
        if let prevQuestion = model.previousFlashcard() {
            questionLabel.text = prevQuestion.getQuestion()
        }
        else {
            questionLabel.text = "No previous card"
        }
        questionLabel.transform = CGAffineTransform(translationX: -view.frame.size.width, y: 0)
        let rightBackAnimation = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: {() in
        self.questionLabel.transform = CGAffineTransform(translationX: 0, y: 0) })
        rightBackAnimation.startAnimation()
    }
    @IBAction func singleTapped(_ sender: UITapGestureRecognizer) {
        let firstAnimator = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: fadeUp)
        firstAnimator.addCompletion(fadeBack)
        firstAnimator.startAnimation()
    }
    
    @IBAction func rightSwipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .right {
            let swipeRight = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: rightAway)
            swipeRight.addCompletion(rightBack)
            swipeRight.startAnimation()
        }
    }
    
    

}

