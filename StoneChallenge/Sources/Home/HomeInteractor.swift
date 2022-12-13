//
//  HomeInteractor.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 13/12/22.
//

import Foundation
import RxSwift
import RxRelay

protocol HomeInteractorProtocol: Interactor where State == HomeState, Action == HomeAction {}

final class HomeInteractor: HomeInteractorProtocol, Reducer {
    let store: BehaviorRelay<HomeState>
    let actionSubject: PublishSubject<HomeAction>
    var disposeBag = DisposeBag()
    
    var observable: Observable<HomeState> {
        store.asObservable()
    }
    
    init(initialState: HomeState) {
        self.store = BehaviorRelay(value: initialState)
        self.actionSubject = PublishSubject<HomeAction>()
        bind()
    }
    
    func send(_ action: HomeAction) {
        actionSubject.on(.next(action))
    }
    
    func reduce(action: HomeAction, previousState: HomeState) -> Observable<HomeState> {
        switch action {
        case .loadMoreItems(let textFilter, let statusFilter):
            return loadMoreItemsObservable(
                previousState: previousState,
                textFilter: textFilter,
                statusFilter: statusFilter
            )
        case .initialLoad(let textFilter, let statusFilter):
            var loadState = previousState
            loadState.viewState = .loading
            store.accept(loadState)
            
            return loadMoreItemsObservable(
                previousState: HomeState(), //Reset state
                textFilter: textFilter,
                statusFilter: statusFilter)
        }
    }
    
    private func loadMoreItemsObservable(previousState: HomeState, textFilter: String?, statusFilter: RMCharacter.Status?) -> Observable<HomeState> {
        CurrentEnv.api
            .fetchCharactersList(textFilter, previousState.currentPage, statusFilter)
            .map { characters in
                characters.map { CharacterCellViewModel(name: $0.name, imageUrl: $0.image) }
            }
            .map { cells in
                var newState = previousState
                newState.characters.append(contentsOf: cells)
                newState.currentPage += 1
                newState.viewState = .loaded
                return newState
            }
            .catchAndReturn({
                var newState = previousState
                newState.viewState = .error
                return newState
            }())
        }
    
}

struct HomeState {
    var characters: [CharacterCellViewModel] = []
    var currentPage: Int = 1
    var viewState: ViewState = .loading
}

enum ViewState {
    case loading, error, loaded
}

enum HomeAction {
    case loadMoreItems(textFilter: String?, statusFilter: RMCharacter.Status?)
    case initialLoad(textFilter: String?, statusFilter: RMCharacter.Status?)
}
