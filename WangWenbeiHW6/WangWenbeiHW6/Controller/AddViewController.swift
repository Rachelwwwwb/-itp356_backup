//
//  AddViewController.swift
//  WangWenbeiHW6
//
//  Created by 王文贝 on 2019/11/9.
//  Copyright © 2019 Wenbei Wang. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {

    // IBOutlets
    @IBOutlet weak var questionTF: UITextView!
    @IBOutlet weak var answerTF: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var favSwitch: UISwitch!
    
    public var purpose = "Add Flashcard"
    let flashcardModel = FlashcardsModel.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = true
        questionTF.delegate = self as? UITextViewDelegate
        answerTF.delegate = self
        
        navBar.title = purpose
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - TextfieldDelegate
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == questionTF {
//            questionTF.resignFirstResponder()
//            answerTF.becomeFirstResponder()
//        } else {
//            answerTF.resignFirstResponder()
//        }
//
//        return true
//    }
//
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if true {
            questionTF.resignFirstResponder()
            answerTF.becomeFirstResponder()
        }
        else {
            answerTF.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // textField has its current value
        // the new value is created from the range and string
        
        if let text = textField.text, let textRange = Range(range, in: text) {
            
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            
            if textField == questionTF {
                enableSaveButton(questionText: updatedText)
            }
        }
        return true
    }
    
    // MARK: - IBAction Methods
    
    @IBAction func keyboardDismiss(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first

        if answerTF.isFirstResponder && touch?.view != answerTF {
            answerTF.resignFirstResponder()
        }
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let question = questionTF.text ?? ""
        let answer = answerTF.text ?? ""
        let fav = favSwitch.isOn
        
        if flashcardModel.checkAskedQuestion(potentialQuestion: question){
            let alert = UIAlertController(title: "Warning", message: "The question you have entered already exits! Try a new question.", preferredStyle: .alert)
            let warning = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            questionTF.text = ""
            answerTF.text = ""
            alert.addAction(warning)
            present(alert, animated: true)
            return
        }
        flashcardModel.insert(question: question, answer: answer, favorite: fav, at: flashcardModel.numberOfFlashcards())
        
        // close the view controller
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        answerTF.text = ""
        questionTF.text = ""
        
        // close the view controller
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Helper Methods:
    func enableSaveButton(questionText: String) {
        saveButton.isEnabled = questionText.count > 0
        
        // If we wanted to require quote & author
        // create a parameter for author, authorText
        // saveButton.isEnabled = (quoteText.count > 0) && (authorText.count > 0)
    }
}
