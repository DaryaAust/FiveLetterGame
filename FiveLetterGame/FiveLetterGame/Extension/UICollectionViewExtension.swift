//
//  UICollectionViewExtension.swift
//  FiveLetterGame
//
//  Created by Дарья Ауст on 24.11.2023.
//

import UIKit

extension UICollectionView {
    func register(_ reuseIdenitifer: String) {
        let nib = UINib(nibName: reuseIdenitifer, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: reuseIdenitifer)
    }
    
    func reusableCell<T>(_ reuseIdentifier: String, indexPath: IndexPath) -> T? {
        self.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? T
    }
}
