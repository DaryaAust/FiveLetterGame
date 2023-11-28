//
//  GameWordModel.swift
//  FiveLetterGame
//
//  Created by Дарья Ауст on 28.11.2023.
//

import Foundation

enum GameCheckState {
    case nothing, startNew, failed, update
}

protocol GameWordModelProtocol: AnyObject {
    var correctWord: String { get }
    var enteredWords: [String] { get }
    var lastEnteredWord: String { get }
    var numberOfAttempts: Int { get }
    var numberOfLetters: Int { get }
    var deleteActionState: Bool { get }
    var checkActionState: Bool { get }
    
    func configureLetterWithStyle(forWord wordIndex: Int,
                                  andLetter letterIndex: Int) -> (String, GameLetterStyle)
    
    func update(correctWord: String, enteredWords: [String])
    func appendLetter(_ letter: String)
    func appendWord()
    func removeLastLetter()
    func checkWord() -> GameCheckState
}

class GameWordModel: GameWordModelProtocol {
    private (set) var correctWord = ""
    private (set) var enteredWords: [String] = [""]
    
    private var countEnteredAttempts: Int {
        enteredWords.count
    }
    var countLetter: Int {
        correctWord.count
    }
    var lastEnteredWordIndex: Int {
        enteredWords.count - 1
    }
    var lastEnteredWord: String {
        get {
            enteredWords[lastEnteredWordIndex]
        }
        set {
            enteredWords[lastEnteredWordIndex] = newValue
        }
    }
    var numberOfLetters: Int {
        DefaultValues.numberOfLetters
    }
    var numberOfAttempts: Int {
        DefaultValues.numberOfAttempts
    }
    var deleteActionState: Bool {
        !lastEnteredWord.isEmpty
    }
    var checkActionState: Bool {
        lastEnteredWord.count == numberOfLetters
    }
    
    init(correctWord: String, enteredWords: [String]) {
        self.correctWord = correctWord
        self.enteredWords = enteredWords.isEmpty ? [""] : enteredWords
    }
}

extension GameWordModel {
    func update(correctWord: String, enteredWords: [String]) {
        self.enteredWords = enteredWords.isEmpty ? [""] : enteredWords
        self.correctWord = correctWord
    }
}

extension GameWordModel {
    func appendWord() {
        enteredWords.append("")
    }
    
    func appendLetter(_ letter: String) {
        guard lastEnteredWord.count < numberOfLetters else {
            return
        }
        lastEnteredWord = lastEnteredWord.appending(letter)
    }
    
    func removeLastLetter() {
        lastEnteredWord = String(lastEnteredWord.dropLast())
    }
    
    func checkWord() -> GameCheckState {
        if enteredWords.count > numberOfAttempts {
            enteredWords.removeLast()
        }
        guard lastEnteredWord.count >= numberOfLetters else {
            return .nothing
        }
        if lastEnteredWord == correctWord {
            return .startNew
        }
        guard countEnteredAttempts < numberOfAttempts else {
            return .failed
        }
        return .update
    }
    
    func configureLetterWithStyle(forWord wordIndex: Int,
                                  andLetter letterIndex: Int) -> (String, GameLetterStyle) {
        guard wordIndex < enteredWords.count,
              letterIndex < enteredWords[wordIndex].count else {
            return ("", .nope)
        }
        
        let word = enteredWords[wordIndex]
        let letter = word.substring(letterIndex)
        
        guard word.count == numberOfLetters,
              wordIndex != (lastEnteredWordIndex) else {
            return (letter, .nope)
        }
        
        let correctLetter = correctWord.substring(letterIndex)
        
        var style = GameLetterStyle.wrongLetter
        if correctWord.contains(letter) {
            style = letter == correctLetter ? .correctPosition : .wrongPosition
        }
        return (letter, style)
    }
}
