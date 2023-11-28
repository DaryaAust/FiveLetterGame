//
//  StringExtension.swift
//  FiveLetterGame
//
//  Created by Дарья Ауст on 24.11.2023.
//

import Foundation

extension String {
    func substring(_ index: Int) -> String {
        guard index >= 0, index < self.count else {
            return ""
        }
        return String(self[self.index(self.startIndex, offsetBy: index)])
    }
    
    var localized: String {
        let value = NSLocalizedString(self, comment: "")
        if value != self || NSLocale.preferredLanguages.first == "en" {
            return value
        }
        
        guard let path = Bundle.main.path(forResource: "en", ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return value
        }
        return NSLocalizedString(self, bundle: bundle, comment: "")
    }
}
