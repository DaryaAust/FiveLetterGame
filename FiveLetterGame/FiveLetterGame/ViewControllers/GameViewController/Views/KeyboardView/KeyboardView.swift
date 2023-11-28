//
//  KeyboardView.swift
//  FiveLetterGame
//
//  Created by Дарья Ауст on 27.11.2023.
//

import UIKit

protocol KeyboardViewDelegate: AnyObject {
    func keyboardView(_ view: KeyboardView, actionWithCharacter character: String)
    
    func keyboardViewDone(_ view: KeyboardView)
    func keyboardViewRemove(_ view: KeyboardView)
}

class KeyboardView: UIView {
    @IBOutlet private weak var checkButton: UIButton!
    @IBOutlet private weak var deleteButton: UIButton!
    
    @IBOutlet private weak var firstStackView: UIStackView!
    @IBOutlet private weak var secondStackView: UIStackView!
    @IBOutlet private weak var thirdStackView: UIStackView!
    
    @IBOutlet private weak var secondStackViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var thirdStackViewWidthConstraint: NSLayoutConstraint!
    
    weak var delegate: KeyboardViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromXib()
    }
    
    func configure(for firstArray: [String], secondArray: [String], thirdArray: [String]) {
        configureStackView(firstStackView, with: firstArray)
        configureStackView(secondStackView, with: secondArray)
        configureStackView(thirdStackView, with: thirdArray)
        
        secondStackViewWidthConstraint = secondStackViewWidthConstraint.changeMultiplier(
            multiplier: CGFloat(secondArray.count) / CGFloat(firstArray.count)
        )
        thirdStackViewWidthConstraint = thirdStackViewWidthConstraint.changeMultiplier(
            multiplier: CGFloat(thirdArray.count) / CGFloat(firstArray.count)
        )
        
        configureButtons()
    }
    
    func updateStyle(styles: [String: GameLetterStyle]) {
        updateButtonsStyleFrom(firstStackView, styles: styles)
        updateButtonsStyleFrom(secondStackView, styles: styles)
        updateButtonsStyleFrom(thirdStackView, styles: styles)
    }
    
    @IBAction private func checkButtonAction(_ sender: Any) {
        delegate?.keyboardViewDone(self)
    }
    
    @IBAction private func removeButtonAction(_ sender: Any) {
        delegate?.keyboardViewRemove(self)
    }
    
    func updateCheckButton(state: Bool) {
        updateButton(checkButton, for: state)
    }
    
    func updateDeleteButton(state: Bool) {
        updateButton(deleteButton, for: state)
    }
}

private extension KeyboardView {
    func configureStackView(_ stackView: UIStackView, with array: [String]) {
        array.forEach {
            let button = UIButton()
            button.setAttributedTitle(
                NSAttributedString(
                    string: $0,
                    attributes: attributedString(with: UIColor.appWhite)),
                for: .normal
            )
            button.layer.cornerRadius = 4
            button.layer.borderColor = .appWhite
            button.layer.borderWidth = 1
            button.backgroundColor = .clear
            button.addAction(
                UIAction(handler: {[weak self] _ in
                    self?.buttonAction(sender: button)
                }),
                for: .touchDown
            )
            stackView.addArrangedSubview(button)
        }
    }
    
    func buttonAction(sender: UIButton) {
        delegate?.keyboardView(self, actionWithCharacter: sender.titleLabel?.text ?? "")
    }
    
    func configureButtons() {
        configureButton(deleteButton)
        configureButton(checkButton)
    }
    
    func configureButton(_ button: UIButton) {
        button.layer.cornerRadius = 4
        updateButton(button, for: false)
    }
    
    func updateButton(_ button: UIButton, for state: Bool) {
        button.backgroundColor = state ? .appWhite : .appGrey
        button.tintColor = state ? .appBlack : .appWhite
    }
    
    func updateButtonsStyleFrom(_ stackView: UIStackView, styles: [String: GameLetterStyle]) {
        stackView.subviews.forEach {
            guard let button = $0 as? UIButton,
                  let text = button.titleLabel?.text,
                  let style = styles[text] else {
                return
            }
            button.backgroundColor = style.backgroundColor
            
            button.setAttributedTitle(
                NSAttributedString(
                    string: text,
                    attributes: attributedString(with: style.foregroundColor)),
                for: .normal
            )
            
        }
    }
    
    func attributedString(with color: UIColor) -> [NSAttributedString.Key : Any] {
        return [
            .font: UIFont.systemFont(ofSize: 20, weight: .bold),
            .foregroundColor: color
        ]
    }
}

