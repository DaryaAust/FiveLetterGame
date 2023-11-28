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
}
