//
//  UIDeviceExtension.swift
//  FiveLetterGame
//
//  Created by Дарья Ауст on 28.11.2023.
//

import UIKit

extension UIDevice {
    static var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
}
