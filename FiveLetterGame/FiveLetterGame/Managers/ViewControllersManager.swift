//
//  ViewControllersManager.swift
//  FiveLetterGame
//
//  Created by Дарья Ауст on 26.11.2023.
//

import UIKit

protocol ViewControllersManagerProtocol: AnyObject {
    var currentWordsForSave: [String]? { get }
    
    func configureGameVC(for correctWord: String,
                         enteredWords: [String],
                         delegate: GameUpdating) -> GameViewController?
    func configureStartVC(with isHasUnfinishedGame: Bool,
                          delegate: GameUpdating) -> UINavigationController?
    
    func updateStartVC(with isHasUnfinishedGame: Bool)
    func updateGameVC(with correctWord: String,
                      enteredWords: [String])
}

class ViewControllersManager: ViewControllersManagerProtocol {
    var currentWordsForSave: [String]? {
        gamePresenter?.enteredWords
    }
    
    var gamePresenter: GameViewPresenter?
    var startPresenter: StartViewPresenter?
    
    init() {}
}

extension ViewControllersManager {
    func configureGameVC(for correctWord: String,
                         enteredWords: [String],
                         delegate: GameUpdating) -> GameViewController? {
        let keyboardModel = GameKeyboardModel(enteredWords: enteredWords, correctWord: correctWord)
        let wordModel = GameWordModel(correctWord: correctWord, enteredWords: enteredWords)
        let view = GameViewController()
        let presenter = GamePresenter(
            wordModel: wordModel,
            keyboardModel: keyboardModel,
            view: view
        )
        presenter.updating = delegate
        view.presenter = presenter
        
        gamePresenter = presenter
        return view
    }
    
    func configureStartVC(with isHasUnfinishedGame: Bool,
                          delegate: GameUpdating) -> UINavigationController? {
        
        let startModel = StartModel(hasCurrentGame: isHasUnfinishedGame)
        let view = StartViewController()
        let presenter = StartPresenter(
            model: startModel,
            view: view
        )
        presenter.updating = delegate
        view.presenter = presenter
        
        startPresenter = presenter
        return UINavigationController(rootViewController: view)
    }
    
    func updateStartVC(with isHasUnfinishedGame: Bool) {
        startPresenter?.update(hasCurrentGame: isHasUnfinishedGame)
    }
    
    func updateGameVC(with correctWord: String,
                      enteredWords: [String]) {
        gamePresenter?.update(correctWord: correctWord, enteredWords: enteredWords)
    }
}
