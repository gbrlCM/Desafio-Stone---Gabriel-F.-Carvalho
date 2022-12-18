//
//  DetailView.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 17/12/22.
//

import UIKit

class DetailView: UIView {
    
    private(set) lazy var imageView: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.contentMode = .scaleAspectFill
        i.layer.masksToBounds = true
        return i
    }()
    
    private(set) lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private(set) lazy var scrollContentView: UIStackView = {
        let stv = UIStackView()
        stv.axis = .vertical
        stv.translatesAutoresizingMaskIntoConstraints = false
        stv.spacing = 8
        stv.distribution = .equalSpacing
        return stv
    }()
    
    private(set) lazy var generalInfoStackView: UIStackView = {
        let stv = UIStackView()
        stv.axis = .horizontal
        stv.translatesAutoresizingMaskIntoConstraints = false
        stv.spacing = 8
        stv.distribution = .fillEqually
        stv.addArrangedSubview(makeTitleContentStack(statusTitle, content: statusContent))
        stv.addArrangedSubview(makeTitleContentStack(speciesTitle, content: speciesContent))
        stv.addArrangedSubview(makeTitleContentStack(genderTitle, content: genderContent))
        stv.backgroundColor = .secondarySystemBackground
        stv.layer.cornerRadius = 16
        return stv
    }()
    
    private(set) lazy var statusTitle: UILabel = makeTitleLabel("Status")
    private(set) lazy var speciesTitle: UILabel = makeTitleLabel("Species")
    private(set) lazy var genderTitle: UILabel = makeTitleLabel("Gender")
    
    private(set) lazy var statusContent: UILabel = makeContentLabel()
    private(set) lazy var speciesContent: UILabel = makeContentLabel()
    private(set) lazy var genderContent: UILabel = makeContentLabel()

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
        addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        scrollContentView.addArrangedSubview(imageView)
        scrollContentView.addArrangedSubview(generalInfoStackView)
    }
    
    private func setupConstraints() {
        let scrollViewConstraints: [NSLayoutConstraint] = [
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        let scrollContentConstraints: [NSLayoutConstraint] = [
            scrollContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ]
        
        let generalInfoConstraints: [NSLayoutConstraint] = [
            generalInfoStackView.heightAnchor.constraint(equalToConstant: 80),
            generalInfoStackView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 8),
            generalInfoStackView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -8),
        ]
        
        let imageConstraints: [NSLayoutConstraint] = [
            imageView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(scrollContentConstraints)
        NSLayoutConstraint.activate(generalInfoConstraints)
        NSLayoutConstraint.activate(imageConstraints)
        
        
    }
    
    private func setupStyle() {
        backgroundColor = .systemBackground
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
