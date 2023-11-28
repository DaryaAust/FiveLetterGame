//
//  ProgressManager.swift
//  FiveLetterGame
//
//  Created by Дарья Ауст on 24.11.2023.
//

import Foundation

protocol ProgressProtocol {
    var currentGameIndex: Int { get }
    var currentGameWords: [String] { get }
    
    func saveProgress(index: Int, words: [String])
}

class ProgressManager: ProgressProtocol {
    // MARK: - Current game index
    
    @UserDefault(key: "currentGameIndex", defaultValue: 0)
    var currentGameIndex: Int
    
    // MARK: - Current game words
    
    @UserDefault(key: "currentGameWords", defaultValue: [])
    var currentGameWords: [String]
    
    func saveProgress(index: Int, words: [String]) {
        currentGameIndex = index
        currentGameWords = words
    }
}
