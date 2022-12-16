//
//  FilterPresenter.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 16/12/22.
//

import RxSwift
import RxRelay
import Foundation

protocol FilterPresenterProtocol: AnyObject {
    var viewModel: Observable<FilterState> { get }
    
    func statusButtonTapped(_ status: RMCharacter.Status?)
    func updateTextField(_ newValue: String?)
    func searchButtonTapped()
}

final class FilterPresenter: FilterPresenterProtocol {
    
    var viewModel: Observable<FilterState> {
        interactor.observable
    }
    
    private let interactor: any FilterInteractorProtocol
    weak var coordinator: MainCoordinatorProtocol?
    weak var resultPublish: PublishSubject<FilterState>?
    
    init(interactor: some FilterInteractorProtocol) {
        self.interactor = interactor
    }
    
    func statusButtonTapped(_ status: RMCharacter.Status?) {
        interactor.send(.changeStatus(status))
    }
    
    func updateTextField(_ newValue: String?) {
        interactor.send(.updateText(newValue))
    }
    
    func searchButtonTapped() {
        print(interactor.currentState)
        resultPublish?.on(.next(interactor.currentState))
        coordinator?.dismiss()
    }
}
