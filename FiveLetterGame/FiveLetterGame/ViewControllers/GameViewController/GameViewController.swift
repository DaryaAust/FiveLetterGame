//
//  GameViewController.swift
//  FiveLetterGame
//
//  Created by Дарья Ауст on 25.11.2023.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var keyboardView: KeyboardView!
    @IBOutlet private weak var collectionViewLeadingConstraint: NSLayoutConstraint!
    
    var presenter: GameViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureConstraints()
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.presentFailedAlertIfNeeded()
    }
}

private extension GameViewController {
    func configure() {
        configureCollectionView()
        configureKeyboardView()
        configureView()
        configureNavigation()
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register("GameLetterCell")
    }
    
    func configureKeyboardView() {
        keyboardView.delegate = self
        
        keyboardView.configure(
            for: presenter.keyboardFirstLine,
            secondArray: presenter.keyboardSecondLine,
            thirdArray: presenter.keyboardThirdLine
        )
        presenter.needUpdateKeyboard()
    }
    
    func configureView() {
        view.backgroundColor = .appBlack
    }
    
    func configureNavigation() {
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.appWhite
        ]
        navigationController?.navigationBar.tintColor = .appWhite
        title = String(format: "count letters".localized, presenter.countСharacter)
        
        navigationItem.backAction = UIAction { [weak self] _ in
            self?.presenter.quitGame(withSavingWords: true)
        }
    }
    
    func configureConstraints() {
        if UIDevice.isPad {
            collectionViewLeadingConstraint.isActive = false
        }
    }
}

extension GameViewController: KeyboardViewDelegate {
    func keyboardViewDone(_ view: KeyboardView) {
        presenter.checkWord()
        collectionView.reloadData()
    }
    
    func keyboardViewRemove(_ view: KeyboardView) {
        presenter.removeLastLetter()
        collectionView.reloadData()
    }
    
    func keyboardView(_ view: KeyboardView, actionWithCharacter character: String) {
        presenter.appendLetter(character)
        collectionView.reloadData()
    }
}

extension GameViewController: UICollectionViewDelegate {
    
}

extension GameViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfAttempts
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfLetters
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let (data, style) = presenter.data(for: indexPath)
        if let cell: GameLetterCell = collectionView.reusableCell("GameLetterCell", indexPath: indexPath) {
            cell.configure(for: data, andStyle: style)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .init(width: collectionView.frame.width, height: 6)
    }
}

extension GameViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberColumns = CGFloat(presenter.numberOfLetters)
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size: CGFloat = (collectionView.frame.width - (numberColumns - 1) * space) / numberColumns
        return CGSize(width: size, height: size)
    }
}

extension GameViewController: GameView {
    func updateStateDelete(_ state: Bool) {
        keyboardView.updateDeleteButton(state: state)
    }
    
    func updateStateCheck(_ state: Bool) {
        keyboardView.updateCheckButton(state: state)
    }
    
    func updateKeyboard(styles: [String : GameLetterStyle]) {
        keyboardView.updateStyle(styles: styles)
    }
    
    func presentFailedAlert(with text: String) {
        let alert = UIAlertController(
            title: text,
            message: nil,
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(
            title: "Play again".localized,
            style: .default) { [weak self] _ in
                self?.presenter.startNewGame()
            }
        )
        alert.addAction(UIAlertAction(
            title: "Quit the game".localized,
            style: .default) { [weak self] _ in
                self?.presenter.quitGame(withSavingWords: false)
            }
        )
        self.present(alert, animated: true, completion: nil)
    }
    
    func dismissView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateView() {
        collectionView.reloadData()
    }
}
