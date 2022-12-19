//
//  DetailViewPresenter.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 19/12/22.
//

import UIKit
import RxSwift

protocol DetailPresenterProcotol {
    var viewModel: Observable<DetailViewModel> { get }
    
    func viewDidLoad()
}

final class DetailPresenter: DetailPresenterProcotol {
    var viewModel: Observable<DetailViewModel> {
        interactor
            .observable
            .map(DetailViewModel.init(currentState:))
    }
    
    private let interactor: any DetailInteractorProtocol
    
    init(interactor: some DetailInteractorProtocol) {
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        interactor.send(.initialLoad)
    }
}
