//
//  GamePresenter.swift
//  FiveLetterGame
//
//  Created by Дарья Ауст on 28.11.2023.
//

import Foundation

class GamePresenter: GameViewPresenter {
    unowned var view: GameView
    
    let wordModel: GameWordModelProtocol
    let keyboardModel: GameKeyboardModelProtocol
    
    weak var updating: GameUpdating?
    
    var countСharacter: Int {
        wordModel.correctWord.count
    }
    var numberOfAttempts: Int {
        wordModel.numberOfAttempts
    }
    var numberOfLetters: Int {
        wordModel.numberOfLetters
    }
    var enteredWords: [String] {
        wordModel.enteredWords
    }
    
    init(wordModel: GameWordModelProtocol, keyboardModel: GameKeyboardModelProtocol, view: GameView) {
        self.wordModel = wordModel
        self.keyboardModel = keyboardModel
        self.view = view
    }
    
    func update(correctWord: String = "", enteredWords: [String]) {
        wordModel.update(
            correctWord: correctWord,
            enteredWords: enteredWords
        )
        keyboardModel.configureKeyboardStyles(
            for: enteredWords,
            and: correctWord
        )
        
        view.updateView()
        view.updateKeyboard(styles: keyboardModel.keyboardStyles)
    }
}

extension GamePresenter {
    func data(for indexPath: IndexPath) -> (String, GameLetterStyle) {
        return wordModel.configureLetterWithStyle(forWord: indexPath.section, andLetter: indexPath.row)
    }
    
    func appendLetter(_ letter: String) {
        wordModel.appendLetter(letter)
    }
    
    func removeLastLetter() {
        wordModel.removeLastLetter()
    }
    
    func checkWord() {
        let state = wordModel.checkWord()
        guard state != .nothing else {
            return
        }
        keyboardModel.updateKeyboardStyles(
            for: wordModel.lastEnteredWord,
            with: wordModel.correctWord
        )
        view.updateKeyboard(styles: keyboardModel.keyboardStyles)
        wordModel.appendWord()
        if state == .startNew {
            startNewGame()
            return
        }
        guard state != .failed else {
            view.presentFailedAlert(with: wordModel.correctWord)
            return
        }
    }
    
    func quitGame(withSavingWords isSave: Bool) {
        updating?.needSaveProgress(with: isSave ? wordModel.enteredWords : [])
        view.dismissView()
    }
    
    func saveProgress() {
        updating?.needSaveProgress(with: wordModel.enteredWords)
    }
    
    func startNewGame() {
        updating?.restartGame()
    }
    
    func needUpdateKeyboard() {
        view.updateKeyboard(styles: keyboardModel.keyboardStyles)
    }
}
