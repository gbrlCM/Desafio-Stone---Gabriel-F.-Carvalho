//
//  HomePresenter.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 12/12/22.
//

import Foundation
import RxSwift
import RxRelay

protocol HomePresenterProtocol {
    var characters: Observable<[CharacterCellViewModel]> { get }
    var viewState: Observable<ViewState> { get }
    
    func itemSelected(at index: Int)
    func loadMoreItems()
}

final class HomePresenter: HomePresenterProtocol {
    
    private let store = BehaviorRelay<HomeState>(value: HomeState())
    private let disposeBag = DisposeBag()
    
    var characters: Observable<[CharacterCellViewModel]> {
        store
            .map(\.characters)
            .distinctUntilChanged()
    }
    
    var viewState: Observable<ViewState> {
        store
            .map(\.viewState)
            .distinctUntilChanged()
    }
    
    func itemSelected(at index: Int) {
        
    }
    
    func loadMoreItems() {
        let currentState = store.value
        
        CurrentEnv.api.fetchCharactersList(
            currentState.textFilter,
            currentState.currentPage,
            currentState.statusFilter
        )
        .map { characters in
            characters.map { CharacterCellViewModel(name: $0.name, imageUrl: $0.image) }
        }
        .map { cells in
            var newState = currentState
            newState.characters.append(contentsOf: cells)
            newState.currentPage += 1
            return newState
        }
        .subscribe(with: store, onNext: { store, newState in
            store.accept(newState)
        }, onError: { store, _ in
            var newState = currentState
            newState.viewState = .error
            newState.currentPage = 1
            store.accept(newState)
        })
        .disposed(by: disposeBag)
    }
    
}

struct HomeState {
    var characters: [CharacterCellViewModel] = Array(repeating: CharacterCellViewModel(name: "Morty Smith", imageUrl: URL(string: "https://www.google.com.br")!), count: 100)
    var currentPage: Int = 1
    var statusFilter: RMCharacter.Status? = nil
    var textFilter: String? = nil
    var viewState: ViewState = .loading
}

enum ViewState {
    case loading, error, loaded
}

enum HomeAction {
    
}
