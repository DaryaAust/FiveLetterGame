//
//  GameLetterStyle.swift
//  FiveLetterGame
//
//  Created by Дарья Ауст on 28.11.2023.
//

import UIKit

enum GameLetterStyle {
    case nope, wrongLetter, wrongPosition, correctPosition
    
    var backgroundColor: UIColor {
        switch self {
        case .wrongLetter:
            return .appGrey
        case .wrongPosition:
            return .appWhite
        case .correctPosition:
            return .appGreen
        case .nope:
            return .appBlack
        }
    }
    
    var foregroundColor: UIColor {
        switch self {
        case .wrongLetter, .nope:
            return .appWhite
        default:
            return .appBlack
        }
    }
}
