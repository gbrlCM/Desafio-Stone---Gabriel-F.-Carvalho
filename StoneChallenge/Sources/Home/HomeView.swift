//
//  HomeView.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 12/12/22.
//

import UIKit

final class HomeView: UIView {

    lazy var characterCollection: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: CharacterLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.identifier)
        cv.insetsLayoutMarginsFromSafeArea = true
        cv.refreshControl = refreshControl
        return cv
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        return rc
    }()
    
    lazy var progressIndicator: UIActivityIndicatorView = {
        let act = UIActivityIndicatorView(style: .medium)
        act.color = .systemGreen
        act.translatesAutoresizingMaskIntoConstraints = false
        act.hidesWhenStopped = true
        return act
    }()
    
    lazy var errorLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .preferredFont(forTextStyle: .body)
        l.textColor = .systemRed
        l.isHidden = true
        l.text = "Ocorreu um erro, arraste para cima para recarregar"
        return l
    }()
    
    init() {
        super.init(frame: .zero)
        setupHirearchy()
        setupConstraints()
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHirearchy() {
        addSubview(characterCollection)
        addSubview(progressIndicator)
        addSubview(errorLabel)
    }
    
    private func setupConstraints() {
        let characterCollectionConstraints: [NSLayoutConstraint] = [
            characterCollection.topAnchor.constraint(equalTo: topAnchor),
            characterCollection.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            characterCollection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            characterCollection.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        let progressIndicatorConstraints = [
            progressIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            progressIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
        
        let errorLabelConstraints = [
            errorLabel.topAnchor.constraint(equalTo: topAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(errorLabelConstraints)
        NSLayoutConstraint.activate(progressIndicatorConstraints)
        NSLayoutConstraint.activate(characterCollectionConstraints)
    }
    
    private func setupStyle() {
        backgroundColor = UIColor(named: "BackgroundColor")!
        characterCollection.backgroundColor = .clear
    }
}

private final class CharacterLayout: UICollectionViewFlowLayout {
    
    private let minColumnWidth: CGFloat = 150
    private let cellHeight: CGFloat = 220
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView else { return }
        
        let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
        let maxNumColumns = Int(availableWidth / minColumnWidth)
        let cellWidth = (availableWidth / CGFloat(maxNumColumns)).rounded(.down)
        
        self.itemSize = CGSize(width: cellWidth, height: cellHeight)
        self.sectionInset = UIEdgeInsets(top: self.minimumInteritemSpacing, left: 0, bottom: 0.0, right: 0)
        self.sectionInsetReference = .fromSafeArea
    }
}
