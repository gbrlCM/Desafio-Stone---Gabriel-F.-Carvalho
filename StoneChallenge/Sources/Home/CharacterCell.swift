//
//  CharacterCell.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 12/12/22.
//

import UIKit

class CharacterCell: UICollectionViewCell {
    static let identifier = "com.stonechallenge.sources.home.charactercell"
    
    private lazy var avatar: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var characterName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupConstraints()
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        contentView.addSubview(avatar)
        contentView.addSubview(characterName)
    }
    
    private func setupConstraints() {
        let avatarConstraints: [NSLayoutConstraint] = [
            avatar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            avatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            avatar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            avatar.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7)
        ]
        
        let characterNameConstraints: [NSLayoutConstraint] = [
            characterName.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 8),
            characterName.leadingAnchor.constraint(equalTo: avatar.leadingAnchor),
            characterName.trailingAnchor.constraint(equalTo: avatar.trailingAnchor),
            characterName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(avatarConstraints)
        NSLayoutConstraint.activate(characterNameConstraints)
    }
    
    private func setupStyle() {
        contentView.backgroundColor = UIColor(named: "CellColor") ?? .systemBackground
        contentView.layer.cornerRadius = 8
        characterName.sizeToFit()
    }
    
    func setup(with viewModel: CharacterCellViewModel) {
        characterName.text = viewModel.name
        // Lidar com imagem
        avatar.image = UIImage(named: "dummyImage")
    }
}

struct CharacterCellViewModel: Equatable {
    let name: String
    let imageUrl: URL
}
