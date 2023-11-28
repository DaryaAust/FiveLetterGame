//
//  StartModel.swift
//  FiveLetterGame
//
//  Created by Дарья Ауст on 28.11.2023.
//

protocol StartModelProtocol {
    var hasCurrentGame: Bool { get }
    
    func update(hasCurrentGame: Bool)
}

class StartModel: StartModelProtocol {
    private (set) var hasCurrentGame: Bool
    
    init(hasCurrentGame: Bool) {
        self.hasCurrentGame = hasCurrentGame
    }
    
    func update(hasCurrentGame: Bool) {
        self.hasCurrentGame = hasCurrentGame
    }
}
