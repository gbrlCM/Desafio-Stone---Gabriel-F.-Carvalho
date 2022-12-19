//
//  DetailViewHeader.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 18/12/22.
//

import UIKit
import RxSwift

final class DetailViewHeader: UIView {
    
    var imageBinder: Binder<UIImage?> {
        imageView.rx.image
    }
    
    private lazy var imageView: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.contentMode = .scaleAspectFill
        i.layer.masksToBounds = true
        return i
    }()
    
    private lazy var generalInfoStackView: UIStackView = {
        let stv = UIStackView()
        stv.axis = .horizontal
        stv.translatesAutoresizingMaskIntoConstraints = false
        stv.spacing = 8
        stv.distribution = .fillEqually
        stv.addArrangedSubview(makeTitleContentStack(statusTitle, content: statusContent))
        stv.addArrangedSubview(makeTitleContentStack(speciesTitle, content: speciesContent))
        stv.addArrangedSubview(makeTitleContentStack(genderTitle, content: genderContent))
        //stv.backgroundColor = .systemBackground
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.backgroundColor = .systemBackground.withAlphaComponent(0.3)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        stv.addSubview(blurView)
        
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: stv.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: stv.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: stv.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: stv.bottomAnchor),
        ])
        
        blurView.layer.zPosition = -1
        blurView.layer.masksToBounds = true
        blurView.layer.cornerRadius = 16
        
        stv.layer.cornerRadius = 16
        return stv
    }()

    
    private lazy var statusTitle: UILabel = makeTitleLabel("Status")
    private lazy var speciesTitle: UILabel = makeTitleLabel("Species")
    private lazy var genderTitle: UILabel = makeTitleLabel("Gender")
    
    private lazy var statusContent: UILabel = makeContentLabel()
    private lazy var speciesContent: UILabel = makeContentLabel()
    private lazy var genderContent: UILabel = makeContentLabel()

    init() {
        super.init(frame: .zero)
        setupHierarchy()
        setupConstraints()
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(imageView)
        addSubview(generalInfoStackView)
    }
    
    private func setupConstraints() {
        let generalInfoConstraints: [NSLayoutConstraint] = [
            generalInfoStackView.heightAnchor.constraint(equalToConstant: 80),
            generalInfoStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            generalInfoStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            generalInfoStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ]
        
        let imageConstraints: [NSLayoutConstraint] = [
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor)
        ]
        
        NSLayoutConstraint.activate(generalInfoConstraints)
        NSLayoutConstraint.activate(imageConstraints)
        
        
    }
    
    private func setupStyle() {
        backgroundColor = .systemBackground
        layer.masksToBounds = true
    }
    
    func setupContent(status: RMCharacter.Status, species: String, gender: String) {
        statusContent.text = status.rawValue
        speciesContent.text = species
        genderContent.text = gender
    }
    
    private func makeTitleLabel(_ content: String, textAlignment: NSTextAlignment = .center) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = content
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .accent
        label.textAlignment = .center
        return label
    }
    
    private func makeContentLabel(textAlignment: NSTextAlignment = .center) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }
    
    private func makeTitleContentStack(_ title: UILabel, content: UILabel) -> UIView {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.addSubview(title)
        v.addSubview(content)
        NSLayoutConstraint.activate([
            title.bottomAnchor.constraint(equalTo: v.centerYAnchor, constant: -4),
            content.topAnchor.constraint(equalTo: v.centerYAnchor, constant: 4),
            title.widthAnchor.constraint(equalTo: v.widthAnchor),
            content.widthAnchor.constraint(equalTo: v.widthAnchor)
        ])
        return v
    }
}
