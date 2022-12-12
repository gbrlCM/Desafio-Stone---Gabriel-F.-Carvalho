//
//  HomeView.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 12/12/22.
//

import UIKit

class HomeView: UIView {

    lazy var characterCollection: UICollectionView = {
        let cv = UICollectionView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.identifier)
        return cv
    }()
    
    init() {
        super.init(frame: .zero)
        setupHirearchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHirearchy() {
        addSubview(characterCollection)
    }
    
    private func setupConstraints() {
        let characterCollectionConstraints: [NSLayoutConstraint] = [
            characterCollection.topAnchor.constraint(equalTo: topAnchor),
            characterCollection.leadingAnchor.constraint(equalTo: leadingAnchor),
            characterCollection.trailingAnchor.constraint(equalTo: trailingAnchor),
            characterCollection.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(characterCollectionConstraints)
    }

}
