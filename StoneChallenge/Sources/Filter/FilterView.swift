//
//  FilterView.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 14/12/22.
//

import UIKit

class FilterView: UIView {

    private(set) lazy var nameTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Search..."
        tf.layer.cornerRadius = 8
        tf.backgroundColor = .secondarySystemBackground
        
        let view = UIView()
        let rightView = UIView()
        let image = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        
        view.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        rightView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(image)
        image.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 44),
            view.heightAnchor.constraint(equalToConstant: 44),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            rightView.widthAnchor.constraint(equalToConstant: 44),
            rightView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        tf.leftView = view
        tf.rightView = rightView
        tf.leftViewMode = .always
        tf.rightViewMode = .always
        
        let keyboardBar = UIToolbar()
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(finish))
        keyboardBar.items = [spacer, doneButton]
        keyboardBar.sizeToFit()
        tf.inputAccessoryView = keyboardBar
        return tf
    }()
    
    private(set) lazy var buttonsStack: UIStackView = {
        let sv = UIStackView(frame: .zero)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 8
        sv.alignment = .fill
        [aliveButton, deadButton, unknownButton]
            .forEach { sv.addArrangedSubview($0) }
        return sv
    }()
    
    private(set) lazy var aliveButton: UIButton = buildStatusButton(for: .alive)
    private(set) lazy var deadButton: UIButton = buildStatusButton(for: .dead)
    private(set) lazy var unknownButton: UIButton = buildStatusButton(for: .unknown)
    
    private func buildStatusButton(for status: RMCharacter.Status) -> UIButton {
        let button = UIButton(type: .roundedRect)
        button.setTitle(status.rawValue, for: .normal)
        button.setBackgroundImage(.color(.accent.withAlphaComponent(0.2)), for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
    }
    
    private(set) lazy var searchButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Search Characters", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.setBackgroundImage(UIImage.color(.accent), for: .normal)
        btn.setBackgroundImage(.color(.accent.withAlphaComponent(0.5)), for: .highlighted)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8
        return btn
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
        addSubview(searchButton)
        addSubview(buttonsStack)
    }
    
    private func setupConstraints() {
        let nameConstraints: [NSLayoutConstraint] = [
            nameTextField.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -8),
            nameTextField.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            nameTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        ]
        
        let stackViewConstraints: [NSLayoutConstraint] = [
            buttonsStack.topAnchor.constraint(equalTo: centerYAnchor, constant: 8),
            buttonsStack.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            buttonsStack.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            buttonsStack.heightAnchor.constraint(equalToConstant: 44)
        ]
        
        let searchButtonConstraints: [NSLayoutConstraint] = [
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            searchButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            searchButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            searchButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(nameConstraints)
        NSLayoutConstraint.activate(searchButtonConstraints)
    }
    
    private func setupStyle() {
        backgroundColor = .systemBackground
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(finish)))
    }
    
    @objc private func finish() {
        nameTextField.resignFirstResponder()
    }
}
