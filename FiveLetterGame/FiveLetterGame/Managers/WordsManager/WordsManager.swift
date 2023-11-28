//
//  WordsManager.swift
//  FiveLetterGame
//
//  Created by Дарья Ауст on 26.11.2023.
//

import Foundation

protocol WordsManagerProtocol: AnyObject {
    func getWord(for index: Int) -> String?
}

class WordsManager: WordsManagerProtocol {
    private var words: [String] = []
    
    init() {
        updateWordsFromFile()
    }
    
    func getWord(for index: Int) -> String? {
        guard index < words.count else {
            return nil
        }
        return words[index]
    }
}

private extension WordsManager {
    func updateWordsFromFile() {
        guard let path = Bundle.main.path(forResource: "words", ofType: "json") else {
            return
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let jsonResult = jsonResult as? Dictionary<String, AnyObject>,
               let jsonWords = jsonResult["words"] as? [String] {
                words = jsonWords.map({ $0.uppercased() })
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
