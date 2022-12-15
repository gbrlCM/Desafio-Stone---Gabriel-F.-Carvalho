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
    var viewModel: Observable<HomeViewModel> { get }
    
    func itemSelected(at index: Int)
    func initialLoad()
    func loadMoreItems()
}

final class HomePresenter: HomePresenterProtocol {
    
    private let interactor: any HomeInteractorProtocol
    private let disposeBag = DisposeBag()
    
    init(interactor: some HomeInteractorProtocol) {
        self.interactor = interactor
    }
    
    var viewModel: Observable<HomeViewModel> {
        interactor
            .observable
            .map(HomeViewModel.init(from:))
    }
    
    func initialLoad() {
        interactor.send(.initialLoad)
    }
    
    func itemSelected(at index: Int) {
        print(index)
    }
    
    func loadMoreItems() {
        interactor.send(.loadMoreItems)
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
}
