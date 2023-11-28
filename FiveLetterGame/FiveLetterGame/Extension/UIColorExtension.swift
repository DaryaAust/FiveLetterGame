//
//  UIColorExtension.swift
//  FiveLetterGame
//
//  Created by Дарья Ауст on 24.11.2023.
//

import UIKit

extension UIColor {
    static let appBlack = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let appWhite = #colorLiteral(red: 0.9999999404, green: 1, blue: 1, alpha: 1)
    static let appGrey = #colorLiteral(red: 0.5843137255, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
    static let appGreen = #colorLiteral(red: 0, green: 0.8866186738, blue: 0, alpha: 1)
}

extension CGColor {
    static let appBlack = UIColor.appBlack.cgColor
    static let appWhite = UIColor.appWhite.cgColor
    static let appGrey = UIColor.appGrey.cgColor
    static let appGreen = UIColor.appGreen.cgColor
}
