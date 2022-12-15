//
//  FilterView.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 14/12/22.
//

import UIKit

class FilterView: UIView {

    private lazy var nameTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var buttonsStack: UIStackView = {
        let sv = UIStackView(frame: .zero)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
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
        addSubview(nameTextField)
        addSubview(buttonsStack)
    }
    
    private func setupConstraints() {
        let nameConstraints: [NSLayoutConstraint] = [
            nameTextField.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -8),
            nameTextField.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            nameTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        ]
        
        NSLayoutConstraint.activate(nameConstraints)
    }
    
    private func setupStyle() {
        backgroundColor = .systemBackground
    }
}
