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
    func viewDidLoad()
    func loadMoreItems()
}

final class HomePresenter: HomePresenterProtocol {
    
    private let interactor: any HomeInteractorProtocol
    private let disposeBag = DisposeBag()
    
    init(interactor: some HomeInteractorProtocol) {
        self.interactor = interactor
    }
    
    var characters: Observable<[CharacterCellViewModel]> {
        interactor
            .observable
            .map(\.characters)
            .distinctUntilChanged()
    }
    
    var viewState: Observable<ViewState> {
        interactor
            .observable
            .map(\.viewState)
            .distinctUntilChanged()
    }
    
    func viewDidLoad() {
        interactor.send(.initialLoad(textFilter: nil, statusFilter: nil))
    }
    
    func itemSelected(at index: Int) {
        
    }
    
    func loadMoreItems() {
        interactor.send(.loadMoreItems(textFilter: nil, statusFilter: nil))
    }
    
}

protocol Interactor {
    associatedtype State
    associatedtype Action
    
    var observable: Observable<State> { get }
    
    init(initialState: State)
    
    func send(_ action: Action)
}

protocol Reducer: AnyObject {
    
    associatedtype State
    associatedtype Action
    
    
    var store: BehaviorRelay<State> { get }
    var actionSubject: PublishSubject<Action> { get }
    var disposeBag: DisposeBag { get }
    
    func bind()
    func reduce(action: Action, previousState: State) -> Observable<State>
}

extension Reducer {
    func bind() {
        actionSubject
            .flatMap {[weak self] action in
                guard let self
                else {
                    preconditionFailure("self is deinitialized")
                }
                return self.reduce(action: action, previousState: self.store.value)
            }
            .bind(to: store)
            .disposed(by: disposeBag)
    }
}

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
