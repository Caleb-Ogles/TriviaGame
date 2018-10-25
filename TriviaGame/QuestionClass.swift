//
//  QuestionClass.swift
//  TriviaGame
//
//  Created by Caleb Ogles on 10/19/18.
//  Copyright © 2018 Caleb Ogles. All rights reserved.
//

import Foundation

class TriviaQuestion {
    var triviaQuestion: String
    var answers: [String]
    var correctAnswerIndex: Int
    
    var correctAnswer: String {
        return answers[correctAnswerIndex]
    }
    
    init(triviaQuestion: String, answers: [String], correctAnswerIndex: Int) {
        self.triviaQuestion = triviaQuestion
        self.answers = answers
        self.correctAnswerIndex = correctAnswerIndex
        
    }
    
    
    
    
    
}


