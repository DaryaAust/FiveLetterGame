//
//  StartViewController.swift
//  FiveLetterGame
//
//  Created by Дарья Ауст on 24.11.2023.
//

import UIKit

class StartViewController: UIViewController {
    @IBOutlet private weak var continueButton: UIButton!
    @IBOutlet private weak var startNewButton: UIButton!
    
    var presenter: StartViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func updateModel(hasCurrentGame: Bool) {
        presenter.update(hasCurrentGame: hasCurrentGame)
    }
    
    @IBAction private func continueButtonAction(_ sender: Any) {
        presenter.startGame(isNew: false)
    }
    
    @IBAction private func startNewButtonAction(_ sender: Any) {
        presenter.startGame(isNew: true)
    }
}

extension StartViewController: StartView {
    func updateVC() {
        configure()
    }
    
    func presentViewController(_ controller: UIViewController?) {
        guard let controller else {
            return
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

private extension StartViewController {
    func configure() {
        configureView()
        configureButton(continueButton, withText: "continueButton")
        configureButton(startNewButton, withText: "startNewButton")
        configureNavigation()
        
        continueButton.isHidden = !presenter.hasCurrentGame
    }
    
    func configureButton(_ button: UIButton, withText text: String) {
        button.setAttributedTitle(
            NSAttributedString(
                string: text,
                attributes: [
                    .font: UIFont.systemFont(ofSize: 14),
                    .foregroundColor: UIColor.appBlack
                ]),
            for: .normal
        )
        button.backgroundColor = .appWhite
        button.layer.cornerRadius = 0.25 * button.frame.height
    }
    
    func configureView() {
        view.backgroundColor = .appBlack
    }
    
    func configureNavigation() {
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
    }
}
