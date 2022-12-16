//
//  FilterViewController.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 15/12/22.
//

import UIKit
import RxSwift

class FilterViewController: UIViewController {
    
    private let contentView: FilterView
    private var disposeBag = DisposeBag()
    private let presenter: FilterPresenterProtocol
    
    init(presenter: FilterPresenterProtocol) {
        self.contentView = FilterView()
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        setupNavigationBar()
        setupButton(contentView.aliveButton, with: .alive)
        setupButton(contentView.unknownButton, with: .unknown)
        setupButton(contentView.deadButton, with: .dead)
        setupTextField()
        setupSearchButton()
    }
    
    private func setupButton(_ button: UIButton, with status: RMCharacter.Status?) {
        button
            .rx
            .controlEvent(.touchUpInside)
            .subscribe {[weak presenter] _ in
                presenter?.statusButtonTapped(status)
            }
            .disposed(by: disposeBag)
        
        presenter
            .viewModel
            .map(\.status)
            .distinctUntilChanged()
            .subscribe(with: button) { button, stateStatus in
                if let stateStatus, stateStatus == status {
                    button.setTitleColor(.white, for: .normal)
                    button.setBackgroundImage(.color(.accent), for: .normal)
                } else {
                    button.setTitleColor(.accent, for: .normal)
                    button.setBackgroundImage(.color(.accent.withAlphaComponent(0.2)), for: .normal)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func setupTextField() {
        contentView
            .nameTextField
            .rx
            .text
            .subscribe { [weak presenter] newValue in
                presenter?.updateTextField(newValue)
            }
            .disposed(by: disposeBag)
    }
    
    private func setupSearchButton() {
        contentView
            .searchButton
            .rx
            .controlEvent(.touchUpInside)
            .subscribe { [weak presenter] _ in
                presenter?.searchButtonTapped()
            }
            .disposed(by: disposeBag)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Search"
        navigationController?.navigationBar.applyDefaultStyle()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissView))
    }
    
    @objc
    private func dismissView() {
        dismiss(animated: true)
    }

}
