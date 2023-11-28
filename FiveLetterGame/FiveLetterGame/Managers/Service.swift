//
//  Service.swift
//  FiveLetterGame
//
//  Created by Дарья Ауст on 26.11.2023.
//

import UIKit

class Service {
    static let shared = Service()
    
    let wordsManager: WordsManagerProtocol
    let saveProgressManager: ProgressProtocol
    let viewControllersManager: ViewControllersManagerProtocol
    let gameManager: GameManagerProtocol
    
    init() {
        wordsManager = WordsManager()
        saveProgressManager = ProgressManager()
        viewControllersManager = ViewControllersManager()
        gameManager = GameManager(
            wordsManager: wordsManager,
            progressManager: saveProgressManager,
            controllersManager: viewControllersManager
        )
    }
}

extension Service {
    func configureGameVC() -> GameViewController? {
        gameManager.configureGameVC()
    }
    
    func configureStartVC() -> UINavigationController? {
        gameManager.configureStartVC()
    }
    
    func needSaveProgress() {
        gameManager.saveProgress()
    }
}
