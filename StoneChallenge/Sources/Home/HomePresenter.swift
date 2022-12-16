//
//  HomePresenter.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 12/12/22.
//

import Foundation
import RxSwift
import RxRelay

protocol HomePresenterProtocol: AnyObject {
    var viewModel: Observable<HomeViewModel> { get }
    
    func itemSelected(at index: Int)
    func initialLoad()
    func loadMoreItems()
    func displayFilter()
}

final class HomePresenter: HomePresenterProtocol {
    
    weak var mainCoordinator: MainCoordinatorProtocol?
    
    private let interactor: any HomeInteractorProtocol
    private let filterSubject: PublishSubject<FilterState>
    private let viewModelRelay: BehaviorRelay<HomeViewModel>
    private let disposeBag = DisposeBag()
    
    init(interactor: some HomeInteractorProtocol) {
        self.interactor = interactor
        self.viewModelRelay = .init(value: HomeViewModel(from: interactor.currentState))
        self.filterSubject = PublishSubject()
        updateWithFilterResults()
        bindInteractor()
    }
    
    var viewModel: Observable<HomeViewModel> {
        viewModelRelay.asObservable()
    }
    
    func initialLoad() {
        interactor.send(.initialLoad)
    }
    
    func itemSelected(at index: Int) {
        guard let character = interactor.currentState.characters[safe: index] else {
            return
        }
        
        mainCoordinator?.navigateToCharacter(character)
    }
    
    func loadMoreItems() {
        if viewModelRelay.value.canLoadMore {
            interactor.send(.loadMoreItems)
        }
    }
    
    func displayFilter() {
        mainCoordinator?.displayFilter(resultSubject: filterSubject)
    }
    
    private func updateWithFilterResults() {
        filterSubject
            .subscribe {[weak interactor] result in
                interactor?.send(.changeFilter(textFilter: result.text, statusFilter: result.status))
            }
            .disposed(by: disposeBag)
    }
    
    private func bindInteractor() {
        interactor
            .observable
            .map(HomeViewModel.init(from:))
            .bind(to: viewModelRelay)
            .disposed(by: disposeBag)
    }
    
}

struct HomeViewModel: Equatable {
    var cells: [CharacterCellViewModel]
    var canLoadMore: Bool
    var viewState: ViewState
    
    init(from state: HomeState) {
        cells = state.characters.map(CharacterCellViewModel.init(character:))
        canLoadMore = state.currentPage < state.pageLimit
        viewState = state.viewState
    }
    
    init() {
        cells = []
        canLoadMore = false
        viewState = .loading
    }
}
