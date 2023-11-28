//
//  StartProtocols.swift
//  FiveLetterGame
//
//  Created by Дарья Ауст on 28.11.2023.
//

import UIKit

protocol StartView: AnyObject {
    func presentViewController(_ controller: UIViewController?)
    func updateVC()
}

protocol StartViewPresenter: AnyObject {
    var view: StartView { get set }
    var hasCurrentGame: Bool { get }
    
    func update(hasCurrentGame: Bool)
    func startGame(isNew newGame: Bool)
}
