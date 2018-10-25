//
//  ViewController.swift
//  TriviaGame
//
//  Created by Caleb Ogles on 10/18/18.
//  Copyright © 2018 Caleb Ogles. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerAButton: UIButton!
    @IBOutlet weak var answerBButton: UIButton!
    @IBOutlet weak var answerDButton: UIButton!
    @IBOutlet weak var answerCButton: UIButton!
    
    func getNewQuestion() {
        if questions.count > 0 {
            currentIndex = Int.random(in: 0..<questions.count)
            currentQuestion = questions[currentIndex]
        } else {
            showGameOverAlert()
        }
    }
    
    func showGameOverAlert() {
        let gameOverAlert = UIAlertController(title: "Trivia Results", message: "Game Over! you scored: \(score) out of a possible \(questionsPlaceholder.count) questions", preferredStyle: UIAlertController.Style.alert)
        let resetAction = UIAlertAction(title: "about that time to reset huh? *Tap Here*", style: UIAlertAction.Style.default) { UIAlertAction in
            self.resetGame()
        }
        
        gameOverAlert.addAction(resetAction)
        self.present(gameOverAlert, animated: true, completion: nil)
    }
    
    
    let backgroundColors = [
        UIColor(red: 255/255, green: 127/255, blue: 80/255, alpha: 1.0),
        UIColor(red: 234/255, green: 78/255, blue: 255/255, alpha: 1.0),
        UIColor(red: 127/255, green: 234/255, blue: 145/255, alpha: 1.0),
        UIColor(red: 178/255, green: 0/255, blue: 0/255, alpha: 1.0),
        UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 1.0)
        
    ]
    
    func setNewColors() {
        let randomNumber = Int.random(in: 1...100)
        let randomColorA = backgroundColors[randomNumber % 4]
        let randomColorB = backgroundColors[(randomNumber + 1) % 4]
        let randomColorC = backgroundColors[(randomNumber + 2) % 4]
        let randomColorD = backgroundColors[(randomNumber + 3) % 4]
        
        answerAButton.backgroundColor = randomColorA
        answerBButton.backgroundColor = randomColorB
        answerCButton.backgroundColor = randomColorC
        answerDButton.backgroundColor = randomColorD
    }
    
    
    var questions = [TriviaQuestion]()
    var questionsPlaceholder = [TriviaQuestion]()
    
    var currentIndex: Int!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var currentQuestion: TriviaQuestion! {
        didSet {
            if let currentQuestion = currentQuestion {
                questionLabel.text = currentQuestion.triviaQuestion
                answerAButton.setTitle(currentQuestion.answers[0], for: .normal)
                answerBButton.setTitle(currentQuestion.answers[1], for: .normal)
                answerCButton.setTitle(currentQuestion.answers[2], for: .normal)
                answerDButton.setTitle(currentQuestion.answers[3], for: .normal)
                setNewColors()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateQuesitons()
        getNewQuestion()
    }
    
    func populateQuesitons() {
        let question1 = TriviaQuestion(triviaQuestion: "How it do?", answers: ["it do", "It don't", "Good", "Bad"], correctAnswerIndex: 0)
        let question2 = TriviaQuestion(triviaQuestion: "How many languages is C-3PO fluent in?", answers: ["2", "450", "1,000,000", "6,000,000"], correctAnswerIndex: 3)
        let question3 = TriviaQuestion(triviaQuestion: "What is the name of the Wookiee's home world?", answers: ["Dathomir", "Kashyyyk", "Tatooine", "Jedha"], correctAnswerIndex: 1)
        let question4 = TriviaQuestion(triviaQuestion: "Which species stole the plans to the Death Star?", answers: ["Bothans", "Yarkora", "Quarren", "Gran"], correctAnswerIndex: 0)
        let question5 = TriviaQuestion(triviaQuestion: "What odds does C-3PO give Han for successfully navigating the asteroid field?", answers: ["4567 to 1", "3720 to 1", "5789 to 1", "2345 to 1"], correctAnswerIndex: 1)
        let question6 = TriviaQuestion(triviaQuestion: "Who is Lando Calrissian's co-pilot in Episode VI: Return of the Jedi?", answers: ["Ben Kenobi", "Nien Nunb", "Han Solo", "Bossk"], correctAnswerIndex: 1)
        let question7 = TriviaQuestion(triviaQuestion: "What does AT-AT stand for?", answers: ["All Terrain Armored Transport", "All Terrain Assault Transport", "All Terrain Attack Transport", "All Terrain Amazing Train"], correctAnswerIndex: 0)
        let question8 = TriviaQuestion(triviaQuestion: "What is the name of Boba Fett's ship?", answers: ["The Devestator", "The Executor", "Slave I", "Star Forge"] , correctAnswerIndex: 2)
        let question9 = TriviaQuestion(triviaQuestion: "Who was the original commander of the first Death Star?", answers: ["Wullf Yuarlen", "Grand Moff Tarkin", "Director Krennic", "Admiral Versio"], correctAnswerIndex: 1)
        let question10 = TriviaQuestion(triviaQuestion: "Where was Luke Skywalker originally headed to pick up power converters", answers: ["Death Star II", "Mos Eisley", "Tosche Station", "Kessell"], correctAnswerIndex: 2)
        questions = [question1, question2, question3, question4, question5, question6, question7, question8, question9, question10]
    }
    
    
    @IBAction func resetTapped(_ sender: Any) {
        resetGame()
    }
    
    
    func resetGame() {
        score = 0
        
        if !questions.isEmpty {
            questionsPlaceholder.append(contentsOf: questions)
            questions.removeAll()
        }
        questions = questionsPlaceholder
        questionsPlaceholder.removeAll()
        getNewQuestion()
    }
    
    

    @IBAction func answerTapped(_ sender: UIButton) {
        if currentQuestion.correctAnswerIndex == sender.tag {
            score += 1
            showCorrectAnswerAlert()
        } else {
            showIncorrectAnswerAlert()
        }
    }
    
    func showIncorrectAnswerAlert() {
        let incorrectAlert = UIAlertController(title: "Incorrect", message: "\(currentQuestion.correctAnswer) is the correct answer!! Bad dingus!!!", preferredStyle: .actionSheet)
        let okayAction = UIAlertAction(title: "...Dagum, sorry", style: UIAlertAction.Style.default) { UIAlertAction in
            self.questionsPlaceholder.append(self.questions[self.currentIndex])
            self.questions.remove(at: self.currentIndex)
            self.getNewQuestion()
        }
        incorrectAlert.addAction(okayAction)
        self.present(incorrectAlert, animated: true, completion: nil)
    }
    
    func showCorrectAnswerAlert() {
        let correctAlert = UIAlertController(title: "Correct", message: "\(currentQuestion.correctAnswer) is the correct answer! Good work!!!", preferredStyle: .actionSheet)
        let okayAction = UIAlertAction(title: "Thank you!", style: UIAlertAction.Style.default) { UIAlertAction in
            self.questionsPlaceholder.append(self.questions[self.currentIndex])
            self.questions.remove(at: self.currentIndex)
            self.getNewQuestion()
        }
        correctAlert.addAction(okayAction)
        self.present(correctAlert, animated: true, completion: nil)
    }
    
    
    
    @IBAction func unwindToQuizScreen(segue: UIStoryboardSegue){}
}

