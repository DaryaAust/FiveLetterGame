//
//  GameManager.swift
//  FiveLetterGame
//
//  Created by Дарья Ауст on 28.11.2023.
//

import UIKit

protocol GameUpdating: AnyObject {
    func configureNewGame()
    
    func configureGameVC(isNew newGame: Bool) -> GameViewController?
    
    func needSaveProgress(with saveWords: [String])
    
    func restartGame()
}

protocol GameManagerProtocol {
    func configureGameVC() -> GameViewController?
    func configureStartVC() -> UINavigationController?
    func saveProgress()
}

class GameManager {
    
    let wordsManager: WordsManagerProtocol
    var saveProgressManager: ProgressProtocol
    var controllersManager: ViewControllersManagerProtocol
    
    // т.к. у нас при запуске новой игры вызывается функция configureNewGame, которая увеличивает счетчик игр на единичку, целесообразно начальным значением сделать -1 (иначе пропускается первая игра)
    private (set) var currentIndexGame = -1
    private (set) var currentWordsForSave: [String]
    var isHasUnfinishedGame: Bool {
        !currentWordsForSave.isEmpty
    }
    
    init(wordsManager: WordsManagerProtocol, progressManager: ProgressProtocol, controllersManager: ViewControllersManagerProtocol) {
        
        self.wordsManager = wordsManager
        self.saveProgressManager = progressManager
        self.controllersManager = controllersManager
        
        currentWordsForSave = saveProgressManager.currentGameWords
        currentIndexGame = saveProgressManager.currentGameIndex
    }
}

extension GameManager: GameUpdating {
    func configureNewGame() {
        currentIndexGame += 1
        currentWordsForSave = []
    }
    
    func configureGameVC(isNew newGame: Bool) -> GameViewController? {
        if newGame {
            configureNewGame()
        }
        return configureGameVC()
    }
    
    func needSaveProgress(with saveWords: [String]) {
        currentWordsForSave = saveWords
        controllersManager.updateStartVC(with: isHasUnfinishedGame)
        saveProgress()
    }
    
    func restartGame() {
        configureNewGame()
        guard let wordForRestart = wordsManager.getWord(for: currentIndexGame) else {
            return
        }
        controllersManager.updateGameVC(
            with: wordForRestart,
            enteredWords: []
        )
    }
}

extension GameManager: GameManagerProtocol {
    func configureGameVC() -> GameViewController? {
        guard let word = wordsManager.getWord(for: currentIndexGame) else {
            return nil
        }
        return controllersManager.configureGameVC(for: word, enteredWords: currentWordsForSave, updating: self)
    }
    
    func configureStartVC() -> UINavigationController? {
        controllersManager.configureStartVC(with: isHasUnfinishedGame, updating: self)
    }
    
    func saveProgress() {
        if let words = controllersManager.currentWordsForSave {
            currentWordsForSave = words
        }
        saveProgressManager.saveProgress(index: currentIndexGame, words: currentWordsForSave)
    }
}
