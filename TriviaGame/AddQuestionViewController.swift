//
//  AddQuestionViewController.swift
//  TriviaGame
//
//  Created by Caleb Ogles on 10/19/18.
//  Copyright © 2018 Caleb Ogles. All rights reserved.
//

import UIKit

class AddQuestionViewController: UIViewController {

    @IBOutlet weak var newQuestionTextField: UITextField!
    @IBOutlet weak var answerATextField: UITextField!
    @IBOutlet weak var answerBTextField: UITextField!
    @IBOutlet weak var answerCTextField: UITextField!
    @IBOutlet weak var answerDTextField: UITextField!
    @IBOutlet weak var correctAnswerSelector: UISegmentedControl!
    
    var newTriviaQuestion: TriviaQuestion?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    
    @IBAction func returnToQuizScreen(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegueToQuizScreen", sender: self)
    }

    @IBAction func addTapped(_ sender: Any) {
        guard
            let question = newQuestionTextField.text, !question.isEmpty,
            let a = answerATextField.text, !a.isEmpty,
            let b = answerBTextField.text, !b.isEmpty,
            let c = answerCTextField.text, !c.isEmpty,
            let d = answerDTextField.text, !d.isEmpty
            
        else {
            let errorAlert = UIAlertController(title: "Error", message: "Please fill all fields, or press cancel to return to quiz.", preferredStyle: UIAlertController.Style.alert)
            let dismissAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {UIAlertAction in}; errorAlert.addAction(dismissAction)
            self.present(errorAlert, animated: true, completion: nil)
            return
            
        }
        newTriviaQuestion = TriviaQuestion(triviaQuestion: question, answers: [a, b, c, d], correctAnswerIndex: correctAnswerSelector.selectedSegmentIndex)
        
        performSegue(withIdentifier: "unwindSegueToQuizScreen", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destinationVC = segue.destination as? QuizViewController,
            let newTriviaQuestion = newTriviaQuestion
            else { return }
        destinationVC.questions.append(newTriviaQuestion)
        destinationVC.resetGame()
        
        }
    }
    

