//
//  StartPresenter.swift
//  FiveLetterGame
//
//  Created by Дарья Ауст on 28.11.2023.
//

import Foundation

class StartPresenter: StartViewPresenter {
    unowned var view: StartView
    
    let startModel: StartModelProtocol
    
    var hasCurrentGame: Bool {
        startModel.hasCurrentGame
    }
    
    weak var updating: GameUpdating?
    
    init(model: StartModelProtocol, view: StartView) {
        self.startModel = model
        self.view = view
    }
    
    func update(hasCurrentGame: Bool) {
        startModel.update(hasCurrentGame: hasCurrentGame)
        view.updateVC()
    }
}

extension StartPresenter {
    func startGame(isNew newGame: Bool) {
        view.presentViewController(updating?.configureGameVC(isNew: newGame))
    }
}
