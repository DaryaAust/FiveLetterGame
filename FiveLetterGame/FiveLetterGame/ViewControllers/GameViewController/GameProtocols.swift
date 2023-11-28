//
//  GameProtocols.swift
//  FiveLetterGame
//
//  Created by Дарья Ауст on 28.11.2023.
//

import Foundation

protocol GameView: AnyObject {
    func presentFailedAlert(with text: String)
    func updateKeyboard(styles: [String: GameLetterStyle])
    
    func dismissView()
    func updateView()
}

protocol GameViewPresenter: AnyObject {
    var view: GameView { get set }
    var numberOfAttempts: Int { get }
    var numberOfLetters: Int { get }
    var countСharacter: Int { get }
    var enteredWords: [String] { get }
    
    func update(correctWord: String, enteredWords: [String])
    
    func data(for indexPath: IndexPath) -> (String, GameLetterStyle)
    func needUpdateKeyboard()
    
    func appendLetter(_ letter: String)
    func removeLastLetter()
    func checkWord()
    
    func quitGame(withSavingWords isSave: Bool)
    func saveProgress()
    func startNewGame()
}
