//
//  UIViewExtension.swift
//  FiveLetterGame
//
//  Created by Дарья Ауст on 24.11.2023.
//

import UIKit

extension UIView {
    func loadFromXib() {
        let nibName = String(describing: type(of: self))
        let bundle = Bundle(for: type(of: self))
        guard let view = bundle.loadNibNamed(
            nibName,
            owner: self)?.first as? UIView else {
            fatalError("Unable to loadview from xib with name \(nibName)")
        }
        addSubview(view)
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
    }
}
