//
//  MainCoordinator.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 15/12/22.
//

import UIKit

protocol MainCoordinatorProtocol: AnyObject {
    
    func navigateToCharacter(_ character: RMCharacter)
    func displayFilter()
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
        
    }
    
    func displayFilter() {
        let interactor = FilterInteractor(initialState: FilterState())
        let presenter = FilterPresenter(interactor: interactor)
        presenter.coordinator = self
        let filterView = FilterViewController(presenter: presenter)
        navigationView.present(UINavigationController(rootViewController: filterView), animated: true)
    }
    
    func dismiss() {
        navigationView.presentedViewController?.dismiss(animated: true)
    }
    
}
