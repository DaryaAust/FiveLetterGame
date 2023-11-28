//
//  GameLetterCell.swift
//  FiveLetterGame
//
//  Created by Дарья Ауст on 25.11.2023.
//

import UIKit

class GameLetterCell: UICollectionViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(for text: String, andStyle style: GameLetterStyle) {
        configureTitleLabel(text, textColor: style.foregroundColor)
        configureView(wth: style.backgroundColor)
    }
}

private extension GameLetterCell {
    func configureTitleLabel(_ text: String, textColor color: UIColor) {
        titleLabel.text = text
        titleLabel.font = .systemFont(ofSize: 34, weight: .bold)
        titleLabel.textColor = color
    }
    
    func configureView(wth backgroundColor: UIColor) {
        layer.cornerRadius = 5
        self.backgroundColor = backgroundColor
        layer.borderColor = .appWhite
        layer.borderWidth = 1
    }
}
