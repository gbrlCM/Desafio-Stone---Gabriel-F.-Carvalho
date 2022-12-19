//
//  MainCoordinator.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 15/12/22.
//

import UIKit
import RxSwift

protocol MainCoordinatorProtocol: AnyObject {
    
    func navigateToCharacter(_ character: RMCharacter)
    func displayFilter(resultSubject: PublishSubject<FilterState>)
    func dismiss()
}

final class MainCoordinator: MainCoordinatorProtocol, CoordinatorProcotol {
    
    let navigationView: UINavigationController
    
    init(navigationView: UINavigationController) {
        self.navigationView = navigationView
    }
    
    func start() {
        let homeInteractor = HomeInteractor(initialState: HomeState())
        let homePresenter = HomePresenter(interactor: homeInteractor)
        homePresenter.mainCoordinator = self
        let homeView = HomeViewController(presenter: homePresenter)
        
        navigationView.pushViewController(homeView, animated: false)
    }
    func navigateToCharacter(_ character: RMCharacter) {
        let interactor = DetailInteractor(initialState: DetailViewState(character: character))
        let presenter = DetailPresenter(interactor: interactor)
        let detailView = DetailViewController(presenter: presenter)
        navigationView.pushViewController(detailView, animated: true)
    }
    
    func displayFilter(resultSubject: PublishSubject<FilterState>) {
        let interactor = FilterInteractor(initialState: FilterState())
        let presenter = FilterPresenter(interactor: interactor)
        presenter.coordinator = self
        presenter.resultPublish = resultSubject
        let filterView = FilterViewController(presenter: presenter)
        navigationView.present(UINavigationController(rootViewController: filterView), animated: true)
    }
    
    func dismiss() {
        navigationView.presentedViewController?.dismiss(animated: true)
    }
    
}
