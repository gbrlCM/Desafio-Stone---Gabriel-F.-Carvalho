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
        print(index)
    }
    
    func loadMoreItems() {
        interactor.send(.loadMoreItems(textFilter: nil, statusFilter: nil))
    }
    
}
