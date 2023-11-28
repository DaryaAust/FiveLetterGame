//
//  GameKeyboardModel.swift
//  FiveLetterGame
//
//  Created by Дарья Ауст on 28.11.2023.
//

import Foundation

protocol GameKeyboardModelProtocol: AnyObject {
    var keyboardStyles: [String: GameLetterStyle] { get }
    var firstLineOfKeyboard: [String] { get }
    var secondLineOfKeyboard: [String] { get }
    var thirdLineOfKeyboard: [String] { get }
    
    func updateKeyboardStyles(for word: String, with correctWord: String)
    func configureKeyboardStyles(for words: [String], and correctWord: String)
}

class GameKeyboardModel: GameKeyboardModelProtocol {
    private (set) var keyboardStyles: [String: GameLetterStyle] = [:]
    
    private (set) var firstLineOfKeyboard = ["Й", "Ц", "У", "К", "Е", "Н", "Г", "Ш", "Щ", "З", "Х", "Ъ"]
    private (set) var secondLineOfKeyboard = ["Ф", "Ы", "В", "А", "П", "Р", "О", "Л", "Д", "Ж", "Э"]
    private (set) var thirdLineOfKeyboard = ["Я", "Ч", "С", "М", "И", "Т", "Ь", "Б", "Ю"]
    
    init(enteredWords: [String], correctWord: String) {
        configureKeyboardStyles(for: enteredWords, and: correctWord)
    }
}

extension GameKeyboardModel {
    func updateKeyboardStyles(for word: String, with correctWord: String) {
        guard word.count == correctWord.count else {
            return
        }
        for index in 0 ..< word.count {
            let letter = word.substring(index)
            let correctLetter = correctWord.substring(index)
            
            var style = GameLetterStyle.wrongLetter
            if correctWord.contains(letter) {
                style = letter == correctLetter ? .correctPosition : .wrongPosition
            }
            updateKeyboard(for: letter, toStyle: style)
        }
    }
    
    func configureKeyboardStyles(for words: [String], and correctWord: String) {
        firstLineOfKeyboard.forEach { keyboardStyles[$0] = .nope }
        secondLineOfKeyboard.forEach { keyboardStyles[$0] = .nope }
        thirdLineOfKeyboard.forEach { keyboardStyles[$0] = .nope }
        
        words.forEach {
            updateKeyboardStyles(for: $0, with: correctWord)
        }
    }
}

private extension GameKeyboardModel {
    func updateKeyboard(for key: String, toStyle newStyle: GameLetterStyle) {
        if keyboardStyles[key] != .correctPosition {
            keyboardStyles[key] = newStyle
        }
    }
}
